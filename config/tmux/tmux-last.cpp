// Compile with: g++ -std=c++11 -O2 -o tmux-cycle-daemon tmux-cycle-daemon.cpp

#include <algorithm>
#include <cstdlib>
#include <cstring>
#include <fcntl.h>
#include <iostream>
#include <signal.h>
#include <string>
#include <sys/select.h>
#include <sys/stat.h>
#include <unistd.h>
#include <vector>

#define FIFO_PATH "/tmp/tmux-cycle.fifo"
#define TIMEOUT_MS 300

std::vector<std::string> history; // MRU order, most recent first, excludes current
std::string current_window;
bool cycling = false;
int sel_index = -1;
int fifo_fd = -1;
bool running = true;

void remove_from_history(const std::string &id) {
   auto it = std::find(history.begin(), history.end(), id);
   if (it != history.end())
      history.erase(it);
}

void add_to_front(const std::string &id) {
   remove_from_history(id);
   history.insert(history.begin(), id);
}

void select_window(int index) {
   if (index < 0 || index >= (int)history.size())
      return;
   std::string target = history[index];

   // Switch to the target window
   std::string cmd = "tmux select-window -t " + target;
   system(cmd.c_str());

   // Update MRU list: target becomes current, old current goes to front
   history.erase(history.begin() + index);
   if (!current_window.empty() && current_window != target) {
      add_to_front(current_window);
   }
   current_window = target;

   // Exit cycling mode
   cycling = false;
   sel_index = -1;
}

void process_command(const std::string &line) {
   if (line.empty()) {
      return;
   }

   // Parse command and arguments
   size_t space = line.find(' ');
   std::string cmd = (space == std::string::npos) ? line : line.substr(0, space);
   std::string arg = (space == std::string::npos) ? "" : line.substr(space + 1);

   if (cmd == "switch") {
      size_t sep = arg.find(' ');
      std::string old_win = (sep == std::string::npos) ? arg : arg.substr(0, sep);
      std::string new_win = (sep == std::string::npos) ? "" : arg.substr(sep + 1);

      if (!old_win.empty() && old_win != new_win) {
         add_to_front(old_win);
      }
      if (!new_win.empty()) {
         current_window = new_win;
         remove_from_history(new_win);
      }
      // Manual switch cancels cycling
      cycling = false;
      sel_index = -1;
   } else if (cmd == "next") {
      if (history.empty())
         return;
      if (!cycling) {
         cycling = true;
         sel_index = 0;
      } else {
         sel_index = (sel_index + 1) % history.size();
      }
   } else if (cmd == "prev") {
      if (history.empty())
         return;
      if (!cycling) {
         cycling = true;
         sel_index = (int)history.size() - 1;
      } else {
         sel_index = (sel_index - 1 + (int)history.size()) % history.size();
      }
   } else if (cmd == "select") {
      if (cycling && sel_index >= 0 && sel_index < (int)history.size()) {
         select_window(sel_index);
      }
   } else if (cmd == "quit") {
      running = false;
   }
}

void read_and_process() {
   char buf[4096];
   std::string line;

   while (running) {
      fd_set readfds;
      FD_ZERO(&readfds);
      FD_SET(fifo_fd, &readfds);

      struct timeval tv;
      tv.tv_sec = TIMEOUT_MS / 1000;
      tv.tv_usec = (TIMEOUT_MS % 1000) * 1000;

      int ret = select(fifo_fd + 1, &readfds, NULL, NULL, &tv);
      if (ret < 0) {
         perror("select");
         break;
      }

      if (ret == 0) {
         // Timeout – auto‑select if we are cycling
         if (cycling && sel_index >= 0 && sel_index < (int)history.size()) {
            select_window(sel_index);
         }
         continue;
      }

      // Data available
      int n = read(fifo_fd, buf, sizeof(buf) - 1);
      if (n < 0) {
         if (errno == EAGAIN || errno == EWOULDBLOCK)
            continue;
         perror("read");
         break;
      }
      if (n == 0) {
         // EOF – writer closed, reopen FIFO
         close(fifo_fd);
         fifo_fd = open(FIFO_PATH, O_RDONLY | O_NONBLOCK);
         if (fifo_fd < 0) {
            perror("reopen fifo");
            break;
         }
         continue;
      }

      buf[n] = '\0';
      line += buf;

      // Process complete lines
      size_t pos;
      while ((pos = line.find('\n')) != std::string::npos) {
         std::string cmd = line.substr(0, pos);
         line.erase(0, pos + 1);
         process_command(cmd);
      }
   }
}

void cleanup(int) {
   running = false;
   if (fifo_fd >= 0)
      close(fifo_fd);
   unlink(FIFO_PATH);
   exit(0);
}

int main() {
   // Create FIFO if it doesn't exist
   mkfifo(FIFO_PATH, 0666);

   // Open FIFO non‑blocking for select()
   fifo_fd = open(FIFO_PATH, O_RDONLY | O_NONBLOCK);
   if (fifo_fd < 0) {
      perror("open fifo");
      return 1;
   }

   // Set up signal handler to clean up
   signal(SIGINT, cleanup);
   signal(SIGTERM, cleanup);

   read_and_process();

   cleanup(0);
   return 0;
}

// clang --target=x86_64-w64-windows-gnu -std=gnu2x setup/windows/src/remaps.c -o remaps && ./remaps.exe
#define WIN32_LEAN_AND_MEAN
#include <stdio.h>
#include <windows.h>

#define VK_CAPSLOCK VK_CAPITAL

#define KeyDown 0
#define KeyUp KEYEVENTF_KEYUP

static HHOOK keyboard_hook;
static HHOOK mouse_hook;

#define print_struct(d) __builtin_dump_struct(&d, &printf)

#ifndef size_of
#   define size_of(x) (sizeof(x))
#endif

#ifndef count_of
#define count_of(x)                                                            \
  ((size_of(x) / size_of(x[0])) / ((!(size_of(x) % size_of(x[0])))))
#endif

// Assuming VK_OEM_CLEAR is biggest value for all Vks
WORD scan_codes[VK_OEM_CLEAR]       = {0};
BOOL physical_keydown[VK_OEM_CLEAR] = {0};
BOOL logical_keydown[VK_OEM_CLEAR]  = {0};

BOOL logical_champions_only_down_by[]  = {
   ['Q'] = 0,
   ['W'] = 0,
   ['E'] = 0,
   ['R'] = 0,

   ['C'] = 0,
   ['S'] = 0,

   ['B'] = 0 // Right Mouse [B]utton.
};


void track_key_state(const KBDLLHOOKSTRUCT *k, WPARAM wParam) {
   BOOL down = (wParam == WM_KEYDOWN || wParam == WM_SYSKEYDOWN);
   BOOL up   = (wParam == WM_KEYUP   || wParam == WM_SYSKEYUP);

   if (!down && !up) {
      return;
   }

   BYTE vk = (BYTE)k->vkCode;

   // This key event was created by us (or other software)
   if (k->flags & LLKHF_INJECTED) {
      if (down) {
         logical_keydown[vk] = TRUE;
         // printf("%x logical (injected) down\n", vk);
      }
      if (up) {
         // printf("%x logical (injected) up\n", vk);
         logical_keydown[vk] = FALSE;
      }
   } else {
      // Physical keyboard input
      if (down) {
         physical_keydown[vk] = TRUE;
         logical_keydown[vk] = TRUE;
      }
      if (up) {
         physical_keydown[vk] = FALSE;
         logical_keydown[vk] = FALSE;
      }
   }
}

const char *LEAGUE_PROCESS_NAME = "League of Legends (TM) Client";

BOOL is_league_active(void) {
   HWND fg = GetForegroundWindow();
   if (!fg) {
      return FALSE;
   }

   char title[256];
   GetWindowTextA(fg, title, sizeof(title));

   return strstr(title, LEAGUE_PROCESS_NAME) != NULL;
}

// Example:  "." down
//    send_virtual_key(VK_OEM_PERIOD, 0);
// C press + release
//    send_virtual_key('C', 0);
//    send_virtual_key('C', KEYEVENTF_KEYUP);
static void send_virtual_key(WORD vk, DWORD flags) {
   INPUT in = {0};
   in.type = INPUT_KEYBOARD;
   in.ki.wVk = vk;
   in.ki.dwFlags = flags;
   SendInput(1, &in, sizeof(INPUT));
}

static void send_scancode(WORD vk, DWORD flags) {
   INPUT in = {0};
   in.type = INPUT_KEYBOARD;
   in.ki.wScan = scan_codes[vk];
   in.ki.dwFlags = KEYEVENTF_SCANCODE | flags;
   SendInput(1, &in, sizeof(INPUT));
}

static int champion_only_count = 0;

static void send_champion_only_down(WORD vk_sorta_XD) {
   send_scancode(VK_OEM_PERIOD, KeyDown);
   logical_champions_only_down_by[vk_sorta_XD] = true;
}

static void send_champion_only_up(WORD vk_sorta_XD) {
   int count = 0;
   for (size_t i = 0; i < count_of(logical_champions_only_down_by); i++) {
      if (logical_champions_only_down_by[i]) {
         count += 1;
      }
   }

   logical_champions_only_down_by[vk_sorta_XD] = false;

   if (count <= 1) {
      send_scancode(VK_OEM_PERIOD, KeyUp);
   }
}

volatile LONG league_active = FALSE;

LRESULT CALLBACK mouse_procedure(int code, WPARAM wParam, LPARAM lParam) {
   if (!InterlockedCompareExchange(&league_active, 0, 0)) {
      return CallNextHookEx(NULL, code, wParam, lParam);
   }

   if (code == HC_ACTION) {

      if (wParam == WM_RBUTTONDOWN) {
         send_champion_only_down('B');
         send_scancode('C', KeyDown);
         send_scancode('C', KeyUp);
         return 1; // swallow right click
      }

      if (wParam == WM_RBUTTONUP) {
         send_scancode('C', KeyDown);
         send_scancode('C', KeyUp);
         send_champion_only_up('B');
         return 1; // swallow right click
      }
   }
end:

   return CallNextHookEx(NULL, code, wParam, lParam);
}

void release_all_logical_keys(void) {
   for (int vk = 0; vk < 256; vk++) {
      if (logical_keydown[vk] && !physical_keydown[vk]) {
         send_scancode(MapVirtualKey(vk, MAPVK_VK_TO_VSC), KEYEVENTF_KEYUP);
         logical_keydown[vk] = FALSE;
      }

   }

   for (size_t i = 0; i < count_of(logical_champions_only_down_by); i++) {
      logical_champions_only_down_by[i] = false;
   }
}


LRESULT CALLBACK keyboard_procedure(int code, WPARAM wParam, LPARAM lParam) {
   auto hook = keyboard_hook;

   if (!InterlockedCompareExchange(&league_active, 0, 0)) {
      return CallNextHookEx(hook, code, wParam, lParam);
   }

   if (code == HC_ACTION) {
      KBDLLHOOKSTRUCT *k = (KBDLLHOOKSTRUCT *)lParam;

      BOOL keydown = (wParam == WM_KEYDOWN || wParam == WM_SYSKEYDOWN);
      BOOL keyup   = (wParam == WM_KEYUP   || wParam == WM_SYSKEYUP);
      auto key = k->vkCode;


      // Always track first
      track_key_state(k, wParam);

      // Ignore injected keys (including our own)
      if (k->flags & LLKHF_INJECTED) {
         return CallNextHookEx(hook, code, wParam, lParam);
      }

      if (key == VK_ESCAPE && keydown) {
         printf("Escape Down\n");
         send_scancode('Y', KeyDown);
         // send_scancode(sc_y, KeyUp);
         return 1;
      }

      if (key == VK_ESCAPE && keyup) {
         printf("Escape Up\n");
         send_scancode('Y', KeyUp);
         return 1;
      }

      if (key == VK_CAPSLOCK && keydown) {
         printf("Escape Down\n");
         send_scancode(VK_ESCAPE, KeyDown);
         send_scancode(VK_ESCAPE, KeyUp);
         return 1;
      }



      if (key == 'C') {
         if (keydown) {
            send_champion_only_down('C');
            send_scancode('C', KeyDown);
            return 1;
         }
         if (keyup) {
            send_scancode('C', KeyUp);
            send_champion_only_up('C');
            return 1;
         }
      }


      if (key == 'S') {

         if (keydown && physical_keydown[VK_LCONTROL]) {
            send_scancode(MapVirtualKey('L', MAPVK_VK_TO_VSC), KeyDown);

            // If user is physically holding L, do nothing
            if (physical_keydown['L']) {
               return CallNextHookEx(keyboard_hook, code, wParam, lParam);
            }

            send_scancode(VK_LCONTROL, KeyUp);

            if (!logical_keydown['L']) {
               send_scancode('L', KeyDown);
            } else {
               send_scancode('L', KeyUp);
            }

            return 1; // swallow Ctrl+S
         }

         if (keydown) {
            send_champion_only_down('S');
            send_scancode('S', KeyDown);
            send_scancode('S', KeyUp);
            return 1;
         }

         if (keyup) {
            send_scancode('S', KeyDown);
            send_scancode('S', KeyUp);
            send_champion_only_up('S');
            return 1;
         }
      }

      static volatile bool flip_abilities_champion_only_default = false;
      if (key == VK_F5 && keyup) {
         flip_abilities_champion_only_default = !flip_abilities_champion_only_default;
         release_all_logical_keys();
         MessageBeep(MB_OK);
         return 1;
      }

      static const char abilities[] = {'Q', 'W', 'E', 'R'};
      bool send_champion_only_abilities = flip_abilities_champion_only_default ? physical_keydown[VK_LSHIFT] : !physical_keydown[VK_LSHIFT];
      for (int i = 0; i < count_of(abilities); i++) {
         WORD ability_key = abilities[i];
         if (key == ability_key) {

            if (keydown) {
               if (send_champion_only_abilities) {
                  send_champion_only_down(ability_key);
               }
               send_scancode(ability_key, KeyDown);
               return 1;
            }

            if (keyup) {
               send_scancode(ability_key, KeyUp);
               send_champion_only_up(ability_key);
               return 1;
            }
         }
      }
   }

end:
   return CallNextHookEx(hook, code, wParam, lParam);
}

DWORD WINAPI foreground_monitor(void *) {
   for (; true;) {
      BOOL before_active = InterlockedCompareExchange(&league_active, 0, 0);

      BOOL active = is_league_active();
      InterlockedExchange(&league_active, active);

      if (active != before_active) {
         if (active) {
            printf("%s Active\n", LEAGUE_PROCESS_NAME);
         } else {
            printf("%s Not active\n", LEAGUE_PROCESS_NAME);
         }
      }

      Sleep(40);
   }
}

int WINAPI WinMain(HINSTANCE hInst, HINSTANCE _1, LPSTR _2, int _3) {
   FreeConsole();
   // CreateMutexA(
   //       NULL,                   // default security
   //       FALSE,                  // do NOT lock it immediately
   //       "LeagueRemapsSingleton" // GLOBAL NAME
   // );
   //
   // HANDLE mutex = CreateMutexA(NULL, FALSE, "LeagueRemapsSingleton");
   // if (GetLastError() == ERROR_ALREADY_EXISTS) {
   //    exit(0);
   // }

   for (int vk = 0; vk < count_of(scan_codes); vk++) {
      scan_codes[vk] = MapVirtualKey(vk, MAPVK_VK_TO_VSC);
   }

   keyboard_hook = SetWindowsHookEx(WH_KEYBOARD_LL, keyboard_procedure, hInst, 0);
   mouse_hook = SetWindowsHookEx(WH_MOUSE_LL, mouse_procedure, hInst, 0);

   // Start foreground monitor thread
   CreateThread(NULL, 0, foreground_monitor, NULL, 0, NULL);

   MSG msg;
   while (GetMessage(&msg, NULL, 0, 0)) {
      TranslateMessage(&msg);
      DispatchMessage(&msg);
   }

   if (keyboard_hook) {
      UnhookWindowsHookEx(keyboard_hook);
   }

   if (mouse_hook) {
      UnhookWindowsHookEx(mouse_hook);
   }

   release_all_logical_keys();

   return 0;
}

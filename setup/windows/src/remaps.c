// -m windows makes the printf not show
// clang --target=x86_64-w64-windows-gnu -std=gnu2x setup/windows/src/remaps.c -o setup/windows/src/remaps.exe -luser32 -O3 && ./setup/windows/src/remaps.exe

#define WIN32_LEAN_AND_MEAN
#include <stdio.h>
#include <windows.h>

#define defer _Defer

#if 0
#  define MULTITHREAD 0
#  define DEBUGGING 1
#else
#  define MULTITHREAD 1
#  define DEBUGGING 0
#endif

#if DEBUGGING == 1
#include <assert.h>
#else
#define assert(x)
#define printf(...)
#endif

#define VK_CAPSLOCK VK_CAPITAL
static bool vk_is_extended(BYTE vk) {
   switch (vk) {
      // The non-numpad versions are extended
      case VK_INSERT:   case VK_DELETE:
      case VK_HOME:     case VK_END:
      case VK_PRIOR:    case VK_NEXT:   // Page Up / Page Down
      case VK_UP:       case VK_DOWN:
      case VK_LEFT:     case VK_RIGHT:
      // Extended modifier/control keys
      case VK_RCONTROL:
      case VK_RMENU:
      case VK_RSHIFT:   // actually NOT extended, same scancode as LSHIFT
      // Numlock/divide on numpad
      case VK_NUMLOCK:
      case VK_DIVIDE:   // numpad /
      // Misc
      case VK_SNAPSHOT: // Print Screen
      case VK_CANCEL:   // Ctrl+Break
         return true;
      default:
         return false;
   }
}

#define KeyDown 0
#define KeyUp KEYEVENTF_KEYUP

static HINSTANCE curresnt_instance;
static HHOOK keyboard_hook;
static HHOOK mouse_hook;

#define print_struct(d) __builtin_dump_struct(&d, &printf)

#ifndef size_of
#define size_of(x) (sizeof(x))
#endif

#ifndef count_of
#define count_of(x) ((size_of(x) / size_of(x[0])) / ((!(size_of(x) % size_of(x[0])))))
#endif

// IMPORTANT Assuming VK_OEM_CLEAR is biggest value for all Vks
WORD scan_codes[VK_OEM_CLEAR] = {0};
BOOL physical_keydown[VK_OEM_CLEAR] = {0};
BOOL logical_keydown[VK_OEM_CLEAR] = {0};

BOOL logical_champions_only_down_by[] = {
    ['Q'] = 0, ['W'] = 0, ['E'] = 0, ['R'] = 0,

    ['C'] = 0, ['S'] = 0,

    ['B'] = 0 // Right Mouse [B]utton.
};

enum {KEY_UP, KEY_DOWN, KEY_PRESSED, KEY_RELEASED} key_state[count_of(physical_keydown)];
const char *key_state_to_string(int key_state) {
   if (KEY_UP       == key_state) return "KEY_UP";
   if (KEY_DOWN     == key_state) return "KEY_DOWN";
   if (KEY_PRESSED  == key_state) return "KEY_PRESSED";
   if (KEY_RELEASED == key_state) return "KEY_RELEASED";
   return "KEY_UNKOWN";
}

void track_key_state(const KBDLLHOOKSTRUCT *k, WPARAM wParam) {
   BOOL down = (wParam == WM_KEYDOWN || wParam == WM_SYSKEYDOWN);
   BOOL up = (wParam == WM_KEYUP || wParam == WM_SYSKEYUP);

   if (!down && !up) {
      return;
   }

   BYTE vk = (BYTE)k->vkCode;

   // This key event was created by us (or other software)
   if (down) {
      logical_keydown[vk] = TRUE;
   }
   if (up) {
      logical_keydown[vk] = FALSE;
   }

   if (!(k->flags & LLKHF_INJECTED)) {
      if (down) {
         if (TRUE == physical_keydown[vk]) {
            key_state[vk] = KEY_DOWN;
         } else {
            key_state[vk] = KEY_PRESSED;
         }

         physical_keydown[vk] = TRUE;
      }
      if (up) {
         if (FALSE == physical_keydown[vk]) {
            key_state[vk] = KEY_UP;
         } else {
            key_state[vk] = KEY_RELEASED;
         }
         physical_keydown[vk] = FALSE;
      }
   }
}

void track_key_state_end(const KBDLLHOOKSTRUCT *k, WPARAM wParam) {
   BOOL down = (wParam == WM_KEYDOWN || wParam == WM_SYSKEYDOWN);
   BOOL up = (wParam == WM_KEYUP || wParam == WM_SYSKEYUP);

   if (!down && !up) {
      return;
   }

   BYTE vk = (BYTE)k->vkCode;

   if (!(k->flags & LLKHF_INJECTED)) {
      if (down) {
         printf("KEY_DOWN (vk = 0x%x)\n", vk);
         key_state[vk] = KEY_DOWN;
      }
      if (up) {
         printf("KEY_UP (vk = 0x%x)\n", vk);
         key_state[vk] = KEY_UP;
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

#define MAX_INPUTS (64 + count_of(scan_codes))
static INPUT input_buffer[MAX_INPUTS];
static UINT input_count = 0;

static void send_scancode(WORD vk, DWORD flags) {
   assert(input_count < MAX_INPUTS);

   INPUT *in = &input_buffer[input_count++];
   ZeroMemory(in, sizeof(INPUT));

   in->type = INPUT_KEYBOARD;
   in->ki.wScan = scan_codes[vk];
   in->ki.dwFlags = KEYEVENTF_SCANCODE | flags;

   if (vk_is_extended(vk)) {
      in->ki.dwFlags |= KEYEVENTF_EXTENDEDKEY;
   }
}

static void flush_inputs_sync(void) {
   if (!(input_count > 0)) return;
   SendInput(input_count, input_buffer, sizeof(INPUT));
   input_count = 0;
}

#if MULTITHREAD == 1
#define flush_inputs flush_inputs_async
#else
#define flush_inputs flush_inputs_sync
#endif

/////////////////////////
/// MULTITHREADING //////
/////////////////////////
#include <stdatomic.h>
#define QUEUE_SIZE 64

typedef struct {
   INPUT inputs[MAX_INPUTS];
   int count;
} InputBatch;

static InputBatch queue[QUEUE_SIZE];
static atomic_int queue_head = 0; // writer advances
static atomic_int queue_tail = 0; // reader advances
static HANDLE queue_event;        // signals the sender thread

static bool queue_push(InputBatch batch) {
   int head = atomic_load_explicit(&queue_head, memory_order_relaxed);
   int next = (head + 1) % QUEUE_SIZE;
   if (next == atomic_load_explicit(&queue_tail, memory_order_acquire))
      return false; // full, shouldn't happen
   queue[head] = batch;
   atomic_store_explicit(&queue_head, next, memory_order_release);
   SetEvent(queue_event);
   return true;
}

static void flush_inputs_async(void) {
   InputBatch batch;
   memcpy(batch.inputs, input_buffer, input_count * sizeof(INPUT));
   batch.count = input_count;
   input_count = 0;
   queue_push(batch);
}

static DWORD WINAPI input_sender_thread(LPVOID unused) {
   (void)unused;
   while (true) {
      WaitForSingleObject(queue_event, INFINITE);
      int tail = atomic_load_explicit(&queue_tail, memory_order_relaxed);
      while (tail != atomic_load_explicit(&queue_head, memory_order_acquire)) {
         SendInput(queue[tail].count, queue[tail].inputs, sizeof(INPUT));
         tail = (tail + 1) % QUEUE_SIZE;
         atomic_store_explicit(&queue_tail, tail, memory_order_release);
      }
   }
   return 0;
}

// Call once at startup, before hooks probably
void init_input_sender(void) {
   queue_event = CreateEvent(NULL, FALSE, FALSE, NULL); // auto-reset
   CreateThread(NULL, 0, input_sender_thread, NULL, 0, NULL);
}

/////////////////////////
/// MULTITHREADING //////
/////////////////////////

// #define VK_CHAMPION_ONLY VK_OEM_PERIOD
// #define VK_CHAMPION_ONLY VK_SCROLL
#define VK_CHAMPION_ONLY VK_F6
// #define VK_CHAMPION_ONLY VK_INSERT it needs KEYEVENTF_EXTENDEDKEY to be set in 'flags'
static int champion_only_count = 0;
static void send_scancode_champion_only_down(WORD vk_sorta_XD) {
   send_scancode(VK_CHAMPION_ONLY, KeyDown);
   logical_champions_only_down_by[vk_sorta_XD] = true;
}

static void send_scancode_champion_only_up(WORD vk_sorta_XD) {
   int count = 0;
   for (size_t i = 0; i < count_of(logical_champions_only_down_by); i++) {
      if (logical_champions_only_down_by[i]) {
         count += 1;
      }
   }

   logical_champions_only_down_by[vk_sorta_XD] = false;

   if (count <= 1) {
      send_scancode(VK_CHAMPION_ONLY, KeyUp);
   }
}

volatile LONG league_active = FALSE;
LRESULT CALLBACK mouse_procedure(int code, WPARAM wParam, LPARAM lParam) {

   // Tiny Race Conditions like this are irrelevant
   // If you really care, do this instead:
   if (!InterlockedCompareExchange(&league_active, 0, 0)) {
      return CallNextHookEx(NULL, code, wParam, lParam);
   }

   if (code == HC_ACTION) {

      if (wParam == WM_RBUTTONDOWN) {
         send_scancode_champion_only_down('B');

         send_scancode('C', KeyDown);
         send_scancode('C', KeyUp);

         send_scancode('C', KeyDown);
         send_scancode('C', KeyUp);

         flush_inputs();
         return 1; // swallow right click
      }

      if (wParam == WM_RBUTTONUP) {
         send_scancode('C', KeyDown);
         send_scancode('C', KeyUp);

         send_scancode('C', KeyDown);
         send_scancode('C', KeyUp);

         send_scancode_champion_only_up('B');
         flush_inputs();
         return 1; // swallow right click
      }
   }

end:
   return CallNextHookEx(NULL, code, wParam, lParam);
}

void release_all_logical_keys(void) {
   for (int vk = 0; vk < count_of(scan_codes); vk++) {
      if (logical_keydown[vk] && !physical_keydown[vk]) {
         send_scancode(vk, KeyUp);
         flush_inputs();
         logical_keydown[vk] = FALSE;
      }
   }

   for (size_t i = 0; i < count_of(logical_champions_only_down_by); i++) {
      logical_champions_only_down_by[i] = false;
   }
}


constexpr int MAX_KEYS = 8;
////////////////////////////////////
/// CHARACTER / SYMBOL REMAPS //////
////////////////////////////////////
// trigger[]: modifiers..., activation key, 0.
// output[]:  desired output CHARACTERS, 0 -- resolved to VK+shift/altgr
//            against the foreground app's actual layout, at fire time.

typedef struct {
   BYTE  trigger[MAX_KEYS + 1];
   WCHAR output[MAX_KEYS + 1];
   BYTE  output_vk; // for simple remaps
} KeyRemap;

#define REMAP_MAGIC 0x12345678



static const KeyRemap symbol_remaps[] = {
   { {VK_LCONTROL, VK_RMENU, 'J', 0},            {L'=', 0} },
   { {VK_LCONTROL, VK_RMENU, VK_LSHIFT, 'H', 0}, {L'\\', 0} },
   { {VK_LCONTROL, VK_RMENU, 'H', 0},            {L'/', 0} },
   { {VK_LCONTROL, 'H', 0},                      {L'|', 0} },
   { {VK_LCONTROL, VK_RMENU, 'Z', 0},            {L'|', 0} },
   { {VK_LCONTROL, VK_RMENU, VK_LSHIFT, 'K', 0}, {L'-', 0} },
   { {VK_LCONTROL, VK_RMENU, 'K', 0},            {L'_', 0} },
   { {VK_LCONTROL, VK_RMENU, 'L', 0},            {L'?', 0} },
   { {VK_LCONTROL, VK_RMENU, 'N', 0},            {L'%', 0} },
   { {VK_LCONTROL, VK_RMENU, VK_OEM_1, 0},       {L'!', 0} },
   { {VK_LCONTROL, VK_RMENU, 'B', 0},            {L'~', L' ', L'/', 0} },
   { {VK_LCONTROL, VK_RMENU, 'A', 0},            {L'$', 0} },
   { {VK_LCONTROL, VK_RMENU, 'S', 0},            {L'0', 0} },
   { {VK_LCONTROL, VK_RMENU, 'D', 0},            {L'$', 0} },
   { {VK_LCONTROL, VK_RMENU, 'X', 0},            {L'*', 0} },
   { {VK_LCONTROL, VK_RMENU, 'F', 0},            {L'&', 0} },
   { {VK_LCONTROL, VK_RMENU, 'G', 0},            {L'#', 0} },
   { {VK_LCONTROL, VK_RMENU, 'I', 0},            {L'-', 0} },
   { {VK_LCONTROL, VK_RMENU, 'U', 0},            {L'+', 0} },
   { {VK_LCONTROL, VK_RMENU, VK_LSHIFT, 'O', 0}, {L'|', 0} },
   { {VK_LCONTROL, VK_RMENU, 'O', 0},            {L'*', 0} },
   { {VK_LCONTROL, VK_RMENU, VK_LSHIFT, 'P', 0}, {L'|', 0} },
   { {VK_LCONTROL, VK_RMENU, 'P', 0},            {L'/', 0} },
   { {VK_LCONTROL, VK_RMENU, VK_OEM_PERIOD, 0},  {L'-', L'>', 0} },
   { {VK_LCONTROL, VK_RMENU, VK_OEM_COMMA, 0},   {L'+', 0} },

   { {VK_LCONTROL, VK_RMENU, '9', 0},            {L'{', 0} },
   { {VK_LCONTROL, VK_RMENU, '0', 0},            {L'}', 0} },
   { {VK_ESCAPE, '9', 0},                        {L'[', 0} },
   { {VK_ESCAPE, '0', 0},                        {L']', 0} },
   { {VK_RCONTROL, '9', 0},                      {L'<', 0} },
   { {VK_RCONTROL, '0', 0},                      {L'>', 0} },
   { {VK_LSHIFT, '9', 0},                        {L'(', 0} },
   { {VK_LSHIFT, '0', 0},                        {L')', 0} },

   { {VK_DIVIDE,    0}, {0},  VK_ESCAPE},
   { {VK_ESCAPE,    0}, {0},  VK_LCONTROL},
};

HKL keyboard_layout = {0};
static bool try_symbol_remap(BYTE key) {
   BOOL result = FALSE;
   for (size_t i = 0; i < count_of(symbol_remaps); i++) {
      const KeyRemap *r = &symbol_remaps[i];

      int last = 0;
      while (r->trigger[last + 1]) last += 1;

      if (r->trigger[last] != key) {
         continue;
      }

      bool matched = true;
      for (int t = 0; t <= last; t += 1) {
         auto vk = r->trigger[t];
         auto ks = key_state[vk];
         printf("input vk=0x%X state is %s %s\n", vk, key_state_to_string(ks), (KEY_RELEASED == ks) ? "FUCKYOU IS RELEASED IS RELEASED" : "");

         if (!(KEY_DOWN == ks || KEY_PRESSED == ks || KEY_RELEASED == ks)) {
            matched = false;
            break;
         }
      }

      printf("%s\n", matched ? "MATCHED" : "NOT MATCHED" );
      if (!matched) {
         continue;
      }

      // send_scancode(VK_LMENU, KeyUp);
      // send_scancode(VK_RMENU, KeyUp);
      // send_scancode(VK_LSHIFT, KeyUp);
      // send_scancode(VK_LCONTROL,  KeyUp);
      // send_scancode(VK_RSHIFT, KeyUp);
      // send_scancode(VK_RCONTROL,  KeyUp);
      for (int t = 0; t <=  last; t += 1) {
         send_scancode(r->trigger[t], KeyUp); // don't let held modifiers bleed into output
      }
      flush_inputs();

      if (r->output_vk) {
         auto ks = key_state[r->trigger[last]];
         printf("output_vk: is 0x%x r->trigger[last] is 0x%x ks is %s\n", r->output_vk, r->trigger[last], key_state_to_string(ks));
         // hold-through: mirror this event, nothing more
         if (KEY_DOWN == ks || KEY_PRESSED == ks) {
            printf("DONE SENDING DOWN output_vk\n");
            send_scancode(r->output_vk, KeyDown);
         }
         if (KEY_UP == ks || KEY_RELEASED == ks) {
            printf("DONE SENDING UP output_vk\n");
            send_scancode(r->output_vk, KeyUp);
         }
         flush_inputs();
         // result = TRUE;
         return true;
         // continue;
      }

      auto last_ks = key_state[r->trigger[last]];
      for (int o = 0; r->output[o]; o += 1) {
         SHORT vs = VkKeyScanExW(r->output[o], keyboard_layout);
         if (vs == -1) continue;

         BYTE vk = LOBYTE(vs);
         BYTE state = HIBYTE(vs);
         bool shift = (state & 1) == 1;
         bool ctrl  = (state & 2) == 2;
         bool altgr = (state & 6) == 6; // bits 1+2, AltGr is Ctrl+Alt

         printf("output: vk=0x%x, vs=0x%x state=0x%x (shift=%d, altgr=%d, ctrl=%d)\n", vk, vs, state, shift, altgr, ctrl);

         // The last should dictate the state of all this
         if (!(KEY_RELEASED == last_ks)) {
            if (shift) send_scancode(VK_LSHIFT, KeyDown);
            if (ctrl)  send_scancode(VK_LCONTROL, KeyDown);
            if (altgr) send_scancode(VK_RMENU, KeyDown);
            send_scancode(vk, KeyDown);
         } else {
            send_scancode(vk, KeyUp);

            if (altgr) send_scancode(VK_RMENU, KeyUp);
            if (ctrl)  send_scancode(VK_LCONTROL, KeyUp);
            if (shift) send_scancode(VK_LSHIFT, KeyUp);
         }

      }
      flush_inputs();
      return true;
   }
   return result;
}

// return 1 is handled
bool keyboard_normally(int code, WPARAM wParam, LPARAM lParam) {
   if (code == HC_ACTION) {
      KBDLLHOOKSTRUCT *k = (KBDLLHOOKSTRUCT *)lParam;
      BOOL keydown = (wParam == WM_KEYDOWN || wParam == WM_SYSKEYDOWN);
      BOOL keyup   = (wParam == WM_KEYUP || wParam == WM_SYSKEYUP);

      BYTE key = (BYTE)k->vkCode;

      if (k->flags & LLKHF_INJECTED) {
         return false;
      }


      // This is injected LCONTROL for AltGr for some reason?? Windows trying to lie to me
      // Only one key is being pressed next should be VK_RMENU
      // printf("key = 0x%x 0x%hx\n", key, GetAsyncKeyState(VK_RMENU));
      // if (VK_LCONTROL == key && GetAsyncKeyState(VK_RMENU) & 0x8000) {
      // if (GetAsyncKeyState(VK_RMENU) & 0x8000) {
      //    printf("I'm pressing RMENU = 0x%x 0x%hx\n", key, GetAsyncKeyState(VK_RMENU));
      //    return false;
      // }

      printf("before key_state[key=0x%x] is %s\n",  key, key_state_to_string(key_state[key]));
         track_key_state(k, wParam);
         defer track_key_state_end(k, wParam);
      printf("after key_state[key=0x%x] is %s\n\n", key, key_state_to_string(key_state[key]));
      printf("flags = 0x%lx %lu\n\n", k->flags, (k->flags & LLKHF_EXTENDED));

      if ((keyup || keydown) && try_symbol_remap(key)) {
         return true;
      }

      // return false;
      if (key == VK_DIVIDE) {
         if (keydown) {
            send_scancode(VK_ESCAPE, KeyDown);
            flush_inputs();
            return true;
         }
         if (keyup) {
            send_scancode(VK_ESCAPE, KeyUp);
            flush_inputs();
            return true;
         }
      }

      if (key == VK_ESCAPE) {
         if (keydown) {
            send_scancode(VK_LCONTROL, KeyDown);
            flush_inputs();
            return true;
         } else if (keyup) {
            send_scancode(VK_LCONTROL, KeyUp);
            flush_inputs();
            return true;
         }
      }
      return false;
   }
   return false;
}

LRESULT CALLBACK keyboard_procedure(int code, WPARAM wParam, LPARAM lParam) {
   auto hook = keyboard_hook;

   // Tiny Race Conditions like this are irrelevant
   // If we really care, we can do this instead:
   if (!InterlockedCompareExchange(&league_active, 0, 0)) {
      if (keyboard_normally(code, wParam, lParam)) {
         return 1;
      }
      return CallNextHookEx(hook, code, wParam, lParam);
   }

   if (code == HC_ACTION) {
      KBDLLHOOKSTRUCT *k = (KBDLLHOOKSTRUCT *)lParam;

      BOOL keydown = (wParam == WM_KEYDOWN || wParam == WM_SYSKEYDOWN);
      BOOL keyup = (wParam == WM_KEYUP || wParam == WM_SYSKEYUP);
      auto key = k->vkCode;

      BOOL keydown_before = physical_keydown[k->vkCode];

      // Ignore injected keys (including our own)
      if (k->flags & LLKHF_INJECTED) {
         return CallNextHookEx(hook, code, wParam, lParam);
      }

      // Only trigger on first down, ignore auto-repeat
      if (keydown_before && keydown && !keyup) {
         return CallNextHookEx(hook, code, wParam, lParam);
      }

      // Always track first
      track_key_state(k, wParam);

      if (key == 'C') {
         if (keydown) {
            send_scancode_champion_only_down('C');
            send_scancode('C', KeyDown);
            flush_inputs();
            return 1;
         }
         if (keyup) {
            send_scancode('C', KeyUp);
            send_scancode_champion_only_up('C');
            flush_inputs();
            return 1;
         }
      }

      if (key == VK_ESCAPE && keydown) {
         send_scancode('Y', KeyDown);
         flush_inputs();
         return 1;
      }

      if (key == VK_ESCAPE && keyup) {
         send_scancode('Y', KeyUp);
         flush_inputs();
         return 1;
      }

      if (key == VK_CAPSLOCK && keydown) {
         send_scancode(VK_ESCAPE, KeyDown);
         send_scancode(VK_ESCAPE, KeyUp);
         flush_inputs();
         return 1;
      }

      if (key == 'S') {
         if (keydown && physical_keydown[VK_LCONTROL]) {
            send_scancode(VK_LCONTROL, KeyUp);
            // send_scancode('L', KeyDown);

            if (!logical_keydown['L']) {
               send_scancode('L', KeyDown);
            } else {
               send_scancode('L', KeyUp);
            }

            flush_inputs();
            return 1; // swallow Ctrl+S
         }

         if (keydown) {
            send_scancode_champion_only_down('S');
            send_scancode('S', KeyDown);
            send_scancode('S', KeyUp);
            flush_inputs();
            return 1;
         }

         if (keyup) {
            send_scancode('S', KeyDown);
            send_scancode('S', KeyUp);
            send_scancode_champion_only_up('S');
            flush_inputs();
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
      bool send_scancode_champion_only_abilities = flip_abilities_champion_only_default ? physical_keydown[VK_LSHIFT] : !physical_keydown[VK_LSHIFT];
      for (int i = 0; i < count_of(abilities); i++) {
         WORD ability_key = abilities[i];
         if (key == ability_key) {

            if (keydown) {
               if (send_scancode_champion_only_abilities) {
                  send_scancode_champion_only_down(ability_key);
               }
               send_scancode(ability_key, KeyDown);
               flush_inputs();
               return 1;
            }

            if (keyup) {
               send_scancode(ability_key, KeyUp);
               send_scancode_champion_only_up(ability_key);
               flush_inputs();
               return 1;
            }
         }
      }
   }

end:
   return CallNextHookEx(hook, code, wParam, lParam);
}

bool is_hooks_on(void) { return (keyboard_hook != nullptr) && (mouse_hook != nullptr); }

void hooks_on(void) {
   if (keyboard_hook == nullptr) {
      keyboard_hook = SetWindowsHookEx(WH_KEYBOARD_LL, keyboard_procedure, curresnt_instance, 0);
   }
   if (mouse_hook == nullptr) {
      mouse_hook = SetWindowsHookEx(WH_MOUSE_LL, mouse_procedure, curresnt_instance, 0);
   }
   printf("Hooks on.\n");
}

void hooks_off(void) {
   if (keyboard_hook) {
      UnhookWindowsHookEx(keyboard_hook);
      keyboard_hook = nullptr;
   }

   if (mouse_hook) {
      UnhookWindowsHookEx(mouse_hook);
      mouse_hook = nullptr;
   }

   printf("Hooks off.\n");
   release_all_logical_keys();
}

void CALLBACK foreground_changed(HWINEVENTHOOK hook, DWORD event, HWND hwnd, LONG id_object, LONG id_child, DWORD id_event_thread, DWORD event_time) {
   (void)hook;
   (void)event;
   (void)id_object;
   (void)id_child;
   (void)id_event_thread;
   (void)event_time;

   BOOL before_active = InterlockedCompareExchange(&league_active, 0, 0);
   BOOL active = is_league_active();
   InterlockedExchange(&league_active, active);

   if (active != before_active) {
      if (active) {
         printf("%s Active\n", LEAGUE_PROCESS_NAME);
      } else {
         printf("%s Not active\n", LEAGUE_PROCESS_NAME);
         release_all_logical_keys();
      }
   }
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
            release_all_logical_keys();
         }
      }

      Sleep(60 * 2);
   }
}

int WINAPI WinMain(HINSTANCE hInst, HINSTANCE _1, LPSTR lpcmd, int _3) {
   curresnt_instance = hInst;
   // Calling "FreeConsole" makes any printf not appear anymore regardless if called from a shell
   if (0 == DEBUGGING) {
      FreeConsole();
   } else {
      AllocConsole();
      freopen("CONOUT$", "w", stdout);
      setvbuf(stdout, NULL, _IONBF, 0); // disable buffering
      printf("Consoled Working.\n");
   }

   HANDLE mutex = CreateMutexA(NULL,                   // default security
                               FALSE,                  // do NOT lock it immediately
                               "LeagueRemapsSingleton" // GLOBAL NAME
   );
   if (GetLastError() == ERROR_ALREADY_EXISTS) {
      printf("Executable Already started\n");
      exit(0);
   }

   for (int vk = 0; vk < count_of(scan_codes); vk++) {
      scan_codes[vk] = MapVirtualKey(vk, MAPVK_VK_TO_VSC);
   }

#if MULTITHREAD == 1
   init_input_sender();
#endif

   HWND fg = GetForegroundWindow();
   keyboard_layout = GetKeyboardLayout(GetWindowThreadProcessId(fg, NULL));

   hooks_on();

   const bool use_foreground_event = true;
   if (use_foreground_event) {
      SetWinEventHook(EVENT_SYSTEM_FOREGROUND, EVENT_SYSTEM_FOREGROUND, NULL, foreground_changed, 0, 0, WINEVENT_OUTOFCONTEXT);
   } else {
      // Start foreground monitor thread
      CreateThread(NULL, 0, foreground_monitor, NULL, 0, NULL);
   }

   MSG msg;
   while (GetMessage(&msg, NULL, 0, 0)) {
      printf("msg\n");
      TranslateMessage(&msg);
      DispatchMessage(&msg);
   }

   hooks_off();

   return 0;
}

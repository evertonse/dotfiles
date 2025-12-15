#Requires AutoHotkey v2.0
#SingleInstance Force

; DOCS: https://www.autohotkey.com/docs/v2/lib/GetKeyState.htm
; NOTE(Everton): For this to work correctly need powertoys to be one with the following remaps:
;     - Shift -> .


; A_HotkeyInterval := 0  ; This is the default value (milliseconds).
A_MaxHotkeysPerInterval := 2000000000
A_HotkeyModifierTimeout := -1

SetKeyDelay -1
SetMouseDelay -1
SendMode "Input"
; SetKeyDelay 0
; SetMouseDelay 0

; TODO: Test if setdelay -1 once solves the s up:: bug, where hold tagert champions only keep being down despite ksk being up
LEAGUE_PROCESS_NAME := "League of Legends (TM) Client"

#HotIf WinActive(LEAGUE_PROCESS_NAME)
WinWaitActive LEAGUE_PROCESS_NAME


active_pid := WinGetPID(LEAGUE_PROCESS_NAME)
; prio := "Realtime"
prio := "High"
if ProcessSetPriority(prio, active_pid) {
    ; MsgBox "Success: Its priority was changed to " prio active_pid
} else {
    MsgBox "Error: Its priority could not be changed to " prio " pid = " active_pid
}

; Show full thingy
l_down := False
$^s:: {
    global l_down
    if (GetKeyState("l")) {
    ; if (l_down) {
        Send "{l up}"
    } else {
        Send "{l down}"
    }
    l_down :=  not l_down
}

Esc::y
CapsLock::Esc

s::{
    Critical
    if (
        false
        || GetKeyState("Shift", "P")
        || GetKeyState(".", "P")
        ; || GetKeyState("RButton", "P")
    ) {
        ; MsgBox("sss", "Error", 48)
        Send "{s}{s}"
        ; Sleep 3000
        ; ToolTip  ; Turn off the tip.
    } else {
        ; MsgBox("ss2", "Error", 48)
        Send "{. down}{s}{s}{. up}"
    }
}

c::{
    Critical
    if (GetKeyState(".", "P") || GetKeyState("Shift", "P")) {
    ; if (GetKeyState(".", "P")) {
        Send "{u down}"
    } else {
        Send "{. down}{u down}{u down}"
    }
}

c Up::{
    Critical
    if (GetKeyState(".", "P") || GetKeyState("Shift", "P")) {
    ; if (GetKeyState(".", "P")) {
        Send "{u}{u up}"
        ; MsgBox("yes", "Error", 48)
    } else {
        Send "{u}{u up}{. up}"
        ; MsgBox("no", "Error", 48)
    }
}

; shift & e::{
;     Send "{. down}{Backspace}{u down}"
; }



; RButton::LButton
LButton::LButton
; RButton::LButton

*RButton::{
    Critical
    ; SetKeyDelay -1
    ; SetMouseDelay -1
    ; Critical "on"
    if (GetKeyState(".", "P") || GetKeyState("Shift", "P")) {
    ; if (GetKeyState("shift", "P")) {
        ; Send "{blind}"
        Send "{u}{u}"
    } else {
        ; Send "{blind}"
        ; Send "{. down}{u}{u}{. up}"
        Send "{. down}{u}{u}"
        Send "{no}"
    }
    ; Critical "off"
}

*RButton Up::{
    Critical
    ; SetKeyDelay -1
    ; SetMouseDelay -1
    ; Critical "on"
    if (GetKeyState(".", "P") || GetKeyState("Shift", "P")) {
    ; if (GetKeyState("shift", "P")) {
        ; Send "{blind}"
        Send "{u}"
    } else {
        ; Send "{blind}"
        Send "{u}{. up}"
    }
    ; Critical "off"
}

; RButton::u

; $RButton Up::{
;     ; Critical
;     ; ToolTip "No new threads will launch until after this ToolTip disappears."
;     ;   Sleep 3000
;     ;   ToolTip  ; Turn off the tip.
;     if (GetKeyState(".", "P")) {
;         Send "{u}{u}"
;     } else {
;         Send "{u}{u}{. up}"
;     }
;     ; Critical "off"
; }

; *Shift::{
;     Critical
;     if (GetKeyState("RButton", "P")) {
;     } else {
;         Send "{. down}"
;     }
;     Critical "off"
; }
;
; *Shift Up::{
;     Critical
;     if (GetKeyState("RButton", "P")) {
;     } else {
;         Send "{. up}"
;     }
;     Critical "off"
; }
;
~:: Shift


.::.
; HotKey("Shift", "off")



; *s up:: SendInput "{blind up}"
; *s:: SendInput "{blind down}{s}"

; RButton:: {
;     SendInput "{u}"
;     if (GetKeyState("Shift", "P")) {
;         SendInput "{u}"
;     } else {
;     }
; }



; RButton:: u



#HotIf ; Only active during league

#HotIf not WinActive(LEAGUE_PROCESS_NAME) ; Not evaluated eveytime aparrently
SendInput "{Shift up}"
SendInput "{. up}"

Esc::Esc
CapsLock::CapsLock
RButton::RButton
.::LShift
; SetCapsLockState "Off"
; SetCapsLockState("AlwaysOff")



; $(RAlt & c) :: {
;     if (GetKeyState("Shift", "P")) {
;         Send "{Ç}"
;     } else {
;         Send "{ç}"
;     }
; }
; See for key and meaning of things like <^>!, https://www.autohotkey.com/docs/v2/Hotkeys.htm


<^>!c::ç

NumpadDiv::_

; <^>!d::Send "{[}"


; Hotkey "<^>!i", "{}}"

$<^>!h::/
$+<^>!h::\
$^h::|

$<^>!z::|

; <^>!z::#\
<^>!j::=
<^>!k::_
+<^>!k::-
<^>!l::?
<^>!n::%
<^>!;::!
<^>!b::Send "{~}{space}{/}"

$<^>!a::$
$<^>!s::Send "{0}"
$<^>!d::$
$<^>!x::*
$<^>!f::&
<^>!g::#

; Invert aspas:
; '::"
; +'::'

$<^>!i::-
$<^>!u::+
<^>!o::*
<^>!p::/
<^>!+p::|
<^>!+o::|

$<^>!.::Send "{-}{>}"
$<^>!,::+

; <^>!i::#&
; <^>!+i::#$
;



; See: https://www.autohotkey.com/docs/v2/KeyList.htm#numpad


; '{' needs escaping with `

invert_brackets := False

; // This 'if' doesn't work. It's compile time or something
if invert_brackets {
    ; $<^>!8::`{
    ; $<^>!9::}
    ;
    ; $<^8::[
    ; $<^9::]
    ;
    ; $>^8::<
    ; $>^9::>
    ;
    ; +8::(
    ; +9::)
    ; +0::*
} else {
    $<^>!9::`{
    $<^>!0::}

    $<^9::[
    $<^0::]

    $>^9::<
    $>^0::>

    +9::(
    +0::)
}

; RControl & 9::#<
; RControl & 0::#>

<^>!+;::Send "{^}{space}"
; +~::=
; ~::_
;
; <^>!~::+
; ^~::-

; Stop annoyng change keyboard lang shortcut
#space::Send "{}"
<^>!space::^Backspace


; RAlt & a::{
;     if (GetKeyState("Shift", "P")) {
;         Send "{{}"
;     } else {
;         Send "{}}"
;     }
; }

#n:: {

    ; Get the current date
    current_date := FormatTime(,"yyyy-MM-dd")

    notes_file_path := "C:\Users\Administrator\OneDrive\Personal\docs\ObsidianVaults\ExCyber\Habits\Journal\" current_date  ".txt"
    ; Create the file and write the current date into it

    ; Check if the file already exists
    if !FileExist(notes_file_path) {
        ; If the file doesnkt exist, create it and write the current date into it
        FileAppend current_date, notes_file_path
    }

    ; Open the file in Notepad
    Run notes_file_path

}

FocusWindow(exe_name := "", window_title := "", window_class := "") {
    target_hwnd := 0
    
    ; Try to find window using provided parameters
    if (exe_name != "") {
        target_hwnd := WinExist("ahk_exe " . exe_name)
    }
    
    if (!target_hwnd && window_title != "") {
        target_hwnd := WinExist(window_title)
    }
    
    if (!target_hwnd && window_class != "") {
        target_hwnd := WinExist("ahk_class " . window_class)
    }
    
    if (target_hwnd) {
        ; Check if window is minimized and restore if needed
        if (WinGetMinMax(target_hwnd) == -1) {
            WinRestore(target_hwnd)
        }
        
        ; Activate first to prevent window snapping behavior
        WinActivate(target_hwnd)
        
        ; Small delay to ensure activation, then maximize if not already maximized
        Sleep(50)
        if (WinGetMinMax(target_hwnd) != 1) {
            WinMaximize(target_hwnd)
        }
        
        return true
    }
    
    return false
}

OpenApp(exe_path) {
    try {
        Run(exe_path)
        return true
    } catch {
        return false
    }
}

FocusOrOpen(exe_name := "", window_title := "", window_class := "", exe_path := "") {
    if (FocusWindow(exe_name, window_title, window_class)) {
        return true
    }
    ; If not found and exe_path provided, try to open it
    if (exe_path != "") {
        if (OpenApp(exe_path)) {
            ; Wait a bit for the app to start, then try to focus again
            Sleep(2000)
            return FocusWindow(exe_name, window_title, window_class)
        }
    }
    return false
}


; Hotkey examples
#1::
{
    if (!FocusWindow("zen.exe", "Zen Browser", "MozillaWindowClass")) {
        MsgBox("Zen Browser not found", "Error", 48)
    }
}

; #2::
; {
;     if (!FocusWindow("chrome.exe", "", "Chrome_WidgetWin_1")) {
;         MsgBox("Chrome not found", "Error", 48)
;     }
; }


#5::
{
    if (!FocusWindow("notepad.exe", "Notepad", "Notepad")) {
        MsgBox("Notepad not found", "Error", 48)
    }
}

; #1::
; {
;     ; Search for Zen Browser window
;     zen_hwnd := WinExist("ahk_exe zen.exe")
;     
;     if (!zen_hwnd) {
;         ; Try alternative window class/title patterns for Zen Browser
;         zen_hwnd := WinExist("Zen Browser")
;         if (!zen_hwnd) {
;             zen_hwnd := WinExist("ahk_class MozillaWindowClass")
;         }
;     }
;     
;     if (zen_hwnd) {
;         ; Check if window is minimized
;         if (WinGetMinMax(zen_hwnd) == -1) {
;             WinRestore(zen_hwnd)
;         }
;         
;         ; Check if window is maximized
;         if (WinGetMinMax(zen_hwnd) != 1) {
;             WinMaximize(zen_hwnd)
;         }
;         
;         ; Activate/focus the window
;         WinActivate(zen_hwnd)
;     }
;     else {
;         ; Zen Browser not found
;         MsgBox("Zen Browser not found", "Error", 48)
;     }
; }

#HotIf ; Only when league not active


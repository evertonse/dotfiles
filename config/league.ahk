; DOCS: https://www.autohotkey.com/docs/v2/lib/GetKeyState.htm
; NOTE(Everton): For this to work correctly need powertoys to be one with the following remaps:
;     - Shift -> k
;     - CapsLock -> y ; this one might be optional idk

SetCapsLockState "Off"

; A_HotkeyInterval := 0  ; This is the default value (milliseconds).
A_MaxHotkeysPerInterval := 2000000
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
prio := "Realtime"
if ProcessSetPriority(prio, active_pid) {
    ; MsgBox "Success: Its priority was changed to " prio 
} else {
    MsgBox "Error: Its priority could not be changed to " prio
}

l_down := False
$^s:: {
    global l_down
    if (l_down) {
        Send "{l up}"
    } else {
        Send "{l down}"
    }
    l_down :=  not l_down
}

CapsLock::y

; ^s::^s
; $s:: {
;     Send "{s down}{c}"
; }
 


s::s
$s::{
    ; SetKeyDelay -1
    ; SetMouseDelay -1
    if (GetKeyState("k")) {
        Send "{s}"
    } else {
        Send "{k down}{s}{k up}"
    }
}

u::u
$u::{
    ; SetKeyDelay -1
    ; SetMouseDelay -1
    if (GetKeyState("k")) {
        Send "{u}"
    } else {
        Send "{k down}{u}{k up}"
    }
}


; $Shift & RButton::{
;     Send "{u}"
; }

; Shift::k
':: Shift


; *s up:: SendInput "{blind up}"
; *s:: SendInput "{blind down}{s}"

; RButton:: {
;     SendInput "{u}"
;     if (GetKeyState("Shift", "P")) {
;         SendInput "{u}"
;     } else {
;     }
; }



RButton:: u
$RButton:: {
    SendInput "{k down}{u}"
    if (not GetKeyState("Shift", "P")) {
        SendInput "{k up}"
    }
}



SetCapsLockState "AlwaysOff"
#HotIf ; Only active during league

#HotIf not WinActive(LEAGUE_PROCESS_NAME) ; Not evaluated eveytime aparrently
; SetCapsLockState "Off"
SetCapsLockState("AlwaysOff")
; Define the hotkey (Ctrl+Shift+D in this example)
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

Esc::Esc
CapsLock::CapsLock
NumpadDiv::NumpadDiv
Shift::Shift
RButton::RButton

; $(RAlt & c) :: {
;     if (GetKeyState("Shift", "P")) {
;         Send "{Ç}"
;     } else {
;         Send "{ç}"
;     }
; }
; See for key and meaning of things like <^>!, https://www.autohotkey.com/docs/v2/Hotkeys.htm


<^>!c::ç

; <^>!d::Send "{[}"


; Hotkey "<^>!i", "{}}"

$<^>!h::/
$+<^>!h::\
$<^>!z::|

; <^>!z::#\
<^>!j::=
<^>!k::_
+<^>!k::-


$<^>!a::Send "{+}"
$<^>!s::Send "{-}"
$<^>!d::*
$<^>!f::%
<^>!g::&

; <^>!i::#&
; <^>!+i::#$
;
<^>!o::"
<^>!+o::'



; '{' needs escaping with `
$<^>!9::`{
$<^>!0::}

<^9::[
<^0::]

>^9::<
>^0::>
; RControl & 9::#<
; RControl & 0::#>

<^>!;::Send "{~}{space}"
<^>!+;::Send "{^}{space}"

; +~::=
; ~::_
;
; <^>!~::+
; ^~::-

<^>!space::Backspace


; RAlt & a::{
;     if (GetKeyState("Shift", "P")) {
;         Send "{{}"
;     } else {
;         Send "{}}"
;     }
; }



#HotIf ; Only when league not active


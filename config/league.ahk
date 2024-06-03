; DOCS: https://www.autohotkey.com/docs/v2/lib/GetKeyState.htm
; NOTE(Everton): For this to work correctly need powertoys to be one with the following remaps:
;     - Shift -> s
;     - CapsLock -> Esc

A_HotkeyInterval := 0  ; This is the default value (milliseconds).
A_MaxHotkeysPerInterval := 20000
A_HotkeyModifierTimeout := -1

SendMode "Input"

; TODO: Test if setdelay -1 once solves the s up:: bug, where hold tagert champions only keep being down despite 's' being up
LEAGUE_PROCESS_NAME := "League of Legends (TM) Client"
#HotIf WinActive(LEAGUE_PROCESS_NAME)

WinWaitActive LEAGUE_PROCESS_NAME

active_pid := WinGetPID(LEAGUE_PROCESS_NAME)
prio := "Realtime"
if ProcessSetPriority(prio, active_pid) {
    MsgBox "Success: Its priority was changed to " prio 
} else {
    MsgBox "Error: Its priority could not be changed to " prio
}

Esc:: {
  SendInput "{Esc}{y}"
}

CapsLock::j

; ^s::^s 
; $s:: {
;     Send "{s down}{c}"
; }
 

s::s

$s::{
    if (GetKeyState("s")) {
        SendInput "{c}"
    } else {
        SendInput "{s down}{c}{s up}"
    }
}

Shift::s

':: Shift

; *s up:: SendInput "{blind up}"
; *s:: SendInput "{blind down}{s}"


; s & RButton:: {
;     SendInput "{u}"
;     if (GetKeyState("Shift", "P")) {
;         SendInput "{u}"
;     } else {
;     }
; }



RButton:: u
RButton:: {
    if (GetKeyState("s")) {
        SendInput "{u}"
    } else {
        SendInput "{s down}{u}{s up}"
    }
}

RButton Up:: {
    KeyWait "s"
    KeyWait "Shift"
    SendInput "{s up}"
}

#HotIf ; Only active during league
SetCapsLockState "AlwaysOff"
#HotIf not WinActive(LEAGUE_PROCESS_NAME) ; Not evaluated eveytime aparrently
SetCapsLockState "AlwaysOff"
Esc::Esc
Shift::Shift
CapsLock::Esc
s::s

#HotIf ; Only when league not active 



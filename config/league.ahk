; DOCS: https://www.autohotkey.com/docs/v2/lib/GetKeyState.htm
; NOTE(Everton): For this to work correctly need powertoys to be one with the following remaps:
;     - Shift -> '
;     - CapsLock -> y

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

CapsLock::y

; ^s::^s 
; $s:: {
;     Send "{s down}{c}"
; }
 


s::s
s::{
    if (GetKeyState("'")) {
        Send "{s}"
    } else {
        Send "{' down}{s}{' up}"
    }
}

; $Shift & RButton::{
;     Send "{u}"
; }

Shift::'
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
    if (GetKeyState("'")) {
        SendInput "{u}"
    } else {
        SendInput "{' down}{u}{' up}"
    }
}

SetCapsLockState "AlwaysOff"
#HotIf ; Only active during league
SetCapsLockState "AlwaysOff"
#HotIf not WinActive(LEAGUE_PROCESS_NAME) ; Not evaluated eveytime aparrently

; Define the hotkey (Ctrl+Shift+D in this example)
#n:: {

    ; Get the current date
    current_date := FormatTime(,"yyyy-MM-dd")

    notes_file_path := "C:\Users\Administrator\OneDrive\Personal\docs\ObsidianVaults\ExCyber\Habits\Journal\" current_date  ".txt"
    ; Create the file and write the current date into it

    ; Check if the file already exists
    if !FileExist(notes_file_path) {
        ; If the file doesn't exist, create it and write the current date into it
        FileAppend current_date, notes_file_path
    }

    ; Open the file in Notepad
    Run notes_file_path
}

SetCapsLockState("AlwaysOff")
Esc::CapsLock
;Esc::Esc
Shift::Shift
CapsLock::Esc
s::s
'::'

#HotIf ; Only when league not active 



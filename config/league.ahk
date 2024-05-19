; DOCS: https://www.autohotkey.com/docs/v2/lib/GetKeyState.htm

A_HotkeyInterval := 5  ; This is the default value (milliseconds).
A_MaxHotkeysPerInterval := 1000
ShouldModRButton := False


#HotIf WinActive("League of Legends (TM) Client")
Shift::'
Esc::Esc
CapsLock::j
':: Shift
$s:: {
    ;Check if Shift key is pressed
    if (not GetKeyState("'", "P") and not GetKeyState("Shift", "P") and not GetKeyState("RButton", "P"))  {
        Send "{k down}{s}"
    } else  {
        Send "{s}"
    }
}

$s UP:: {
    ;Check if Shift key is pressed
    if (not GetKeyState("'", "P") and not GetKeyState("Shift", "P") and not GetKeyState("RButton", "P"))  {
        Send "{s}{k up}"
    } else  {
        Send "{s}"
    }
}

RButton:: {
    ;Check if uhift key iu preuued
    if (not GetKeyState("'", "P") and not GetKeyState("Shift", "P") and not GetKeyState("s", "P"))  {
        Send "{k down}{u}{k up}"
    } else  {
        Send "{u}"
    }
}

SetCapsLockState "AlwaysOff"
#HotIf ; Only active during league

#HotIf not WinActive("League of Legends (TM) Client") ; Not evaluated eveytime aparrently
SetCapsLockState "AlwaysOff"
Esc::Esc
CapsLock::Esc
#HotIf ; when league not active 

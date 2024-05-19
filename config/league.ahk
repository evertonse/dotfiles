; DOCS: https://www.autohotkey.com/docs/v2/lib/GetKeyState.htm

A_HotkeyInterval := 3  ; This is the default value (milliseconds).
A_MaxHotkeysPerInterval := 1000
ShouldModRButton := False


#HotIf WinActive("League of Legends (TM) Client")

Shift:: {
    if (not GetKeyState("k", "P") and not GetKeyState("s", "P"))  {
      if(GetKeyState("RButton", "P")) {
        Send "{k down}"
      } else {
        Send "{k down}"
      }
    } else  {
    }
}

Shift Up:: {
    if (not GetKeyState("k", "P") and not GetKeyState("s", "P"))  {
      if(GetKeyState("RButton", "P")) {
        Send "{k up}"
      } else {
        Send "{k up}"
      }
    } else  {
    }
}

Esc::Esc
CapsLock::j
':: Shift
\::Shift

s:: {
    ;Check if Shift key is pressed
    if (not GetKeyState("Shift", "P") and not GetKeyState("k", "P") and not GetKeyState("RButton", "P"))  {
        Send "{k down}{s}"
    } else  {
        Send "{s}"
    }
}

s UP:: {
    ;Check if Shift key is pressed
    if (not GetKeyState("Shift", "P") and not GetKeyState("k", "P") and not GetKeyState("RButton", "P"))  {
        Send "{s}{k up}"
    } else  {
        Send "{s}"
    }
}

RButton:: {
    ;Check if uhift key iu preuued
    if (not GetKeyState("'", "P") and not GetKeyState("Shift", "P") and not GetKeyState("k", "P")  and not GetKeyState("s", "P"))  {
        Send "{k down}{u down}{k up}"
    } else  {
        Send "{u down}"
    }
}

RButton Up:: {
    ;Check if uhift key iu preuued
    if (not GetKeyState("'", "P") and not GetKeyState("Shift", "P") and not GetKeyState("k", "P")  and not GetKeyState("s", "P"))  {
        Send "{k down}{u up}{k up}"
    } else  {
        Send "{u up}"
    }
}

SetCapsLockState "Off"
#HotIf ; Only active during league

#HotIf not WinActive("League of Legends (TM) Client") ; Not evaluated eveytime aparrently
SetCapsLockState "Off"
Esc::Esc
CapsLock::Esc
#HotIf ; when league not active 
SetCapsLockState "Off"
SetCapsLockState "AlwaysOff"

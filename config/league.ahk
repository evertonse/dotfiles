; DOCS: https://www.autohotkey.com/docs/v2/lib/GetKeyState.htm

A_HotkeyInterval := 2  ; This is the default value (milliseconds).
A_MaxHotkeysPerInterval := 2000


#HotIf WinActive("League of Legends (TM) Client")

Esc::Esc
CapsLock::j
':: Shift
\::Shift


$Shift:: {
    if (not GetKeyState("k", "P") and not GetKeyState("s", "P"))  {
      if(GetKeyState("RButton", "P")) {
        Send "{k down}"
      } else {
        Send "{k down}"
      }
    } else  {
    }
}
$Shift Up:: {
    if (not GetKeyState("k", "P") and not GetKeyState("s", "P"))  {
      if(GetKeyState("RButton", "P")) {
        Send "{k up}"
      } else {
        Send "{k up}"
      }
    } else  {
    }
}


$s:: {
    ;Check if Shift key is pressed
    if (not GetKeyState("Shift", "P") and not GetKeyState("k", "P"))  {
      if(GetKeyState("RButton", "P")) {
          Send "{k down}{s}"
      } else {
          Send "{k down}{s}"
      }
    } else  {
        Send "{s}"
    }
}
$s UP:: {
    ;Check if Shift key is pressed
    if (not GetKeyState("Shift", "P") and not GetKeyState("k", "P"))  {
      if (not GetKeyState("RButton", "P")) {
        Send "{s}{k up}"
      } else {
        Send "{s}{k up}"
      }
    } else  {
        Send ""
    }
}

; RButton:: {
;     ;Check if uhift key iu preuued
;     if (not GetKeyState("'", "P") and not GetKeyState("Shift", "P") and not GetKeyState("k", "P")  and not GetKeyState("s", "P"))  {
;         Send "{k down}{u down}"
;     } else  {
;         Send "{u down}"
;     }
; }
;
; RButton Up:: {
;     ;Check if uhift key iu preuued
;     if (not GetKeyState("'", "P") and not GetKeyState("Shift", "P") and not GetKeyState("k", "P")  and not GetKeyState("s", "P"))  {
;         Send "{u up}{k up}"
;     } else  {
;         Send "{u up}"
;     }
; }

$RButton:: {
      ;Check if uhift key iu preuued
      if (not GetKeyState("'", "P") and not GetKeyState("Shift", "P") and not GetKeyState("k", "P")  and not GetKeyState("s", "P"))  {
          Send "{k down}{u}{k up}"
      } else  {
          Send "{u}"
      }
}

; $RButton Up:: {
;       ;Check if uhift key iu preuued
;       if (not GetKeyState("'", "P") and not GetKeyState("Shift", "P") and not GetKeyState("k", "P")  and not GetKeyState("s", "P"))  {
;           Send "{u up}"
;       } else  {
;           Send "{u up}"
;       }
; }

SetCapsLockState "Off"
#HotIf ; Only active during league
#HotIf not WinActive("League of Legends (TM) Client") ; Not evaluated eveytime aparrently
#HotIf ; when league not active 

SetCapsLockState "AlwaysOff"
Esc::Esc
Shift::Shift
CapsLock::Esc

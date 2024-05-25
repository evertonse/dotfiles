; DOCS: https://www.autohotkey.com/docs/v2/lib/GetKeyState.htm
; NOTE(Everton): For this to work correctly need powertoys to be one with the following remaps:
;     - Shift -> k
;     - CapsLock -> Esc

A_HotkeyInterval := 0  ; This is the default value (milliseconds).
A_MaxHotkeysPerInterval := 20000


#HotIf WinActive("League of Legends (TM) Client")
Esc:: {
  Send "{Esc}{y}"
}

CapsLock::j
':: Shift

Shift:: k
Shift:: {
    if (not GetKeyState("k") and not GetKeyState("s", "P"))  {
        Send "{k down}"
    } else  {
        ; do nothing
    }
}
Shift Up:: {
    if (not GetKeyState("s", "P"))  {
        Send "{k up}"
    } else  {
       ; do nothing
    }
}

s:: {
    if (GetKeyState("Shift", "P") or GetKeyState("k"))  {
        Send "{s}"
    } else  {
        Send "{k down}{s}"
    }
}
s UP:: {
    if (GetKeyState("Shift", "P"))  {
      Send "{s}"
    } else  {
      if (GetKeyState("RButton", "P")) {
          Send "{k up}"
      }
      Send "{s}{k up}"
    }
}

RButton:: {
    if (GetKeyState("k") or GetKeyState("s") or GetKeyState("Shift")) {
        Send "{u}"
    } else {
        Send "{k down}{u}{k up}"
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

#HotIf ; Only active during league
#HotIf not WinActive("League of Legends (TM) Client") ; Not evaluated eveytime aparrently
#HotIf ; when league not active 

SetCapsLockState "AlwaysOff"
Esc::Esc
Shift::Shift
CapsLock::Esc

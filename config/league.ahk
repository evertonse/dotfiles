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
    if (GetKeyState("s", "P")) {
      ; do nothing
    } else  {
      Send "{k down}"
    }
}
Shift Up:: {
    if (not GetKeyState("s", "P"))  {
        Send "{k up}"
    } else  {
       ; do nothing
    }
}

' & s:: Send "{Shift down}{s}"
' & s up:: Send "{Shift up}"
s:: k
s:: {
    if (GetKeyState("Shift", "P")) {
        Send "{s}"
    } else  {
        Send "{k down}{s}"
    }
}
s UP:: {
    if (GetKeyState("Shift", "P")) {
      Send "{s}"
    } else  {
      Send "{s}{k up}"
    }
}

RButton:: {
    if (GetKeyState("k") or GetKeyState("s", "P") or GetKeyState("Shift", "P")) {
        Send "{u}"
    } else {
        Send "{k down}{u}{k up}"
    }
}

RButton UP::  {
    if (GetKeyState("s", "P") or GetKeyState("Shift", "P")) {
        ; do nothing
    } else {
        Send "{k up}"
    }
}


#HotIf ; Only active during league
#HotIf not WinActive("League of Legends (TM) Client") ; Not evaluated eveytime aparrently
#HotIf ; when league not active 

SetCapsLockState "AlwaysOff"
Esc::Esc
Shift::Shift
CapsLock::Esc

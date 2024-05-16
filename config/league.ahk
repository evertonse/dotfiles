; DOCS: https://www.autohotkey.com/docs/v2/lib/GetKeyState.htm
#HotIf WinActive("League of Legends (TM) Client")
Shift::'
Esc::Esc
CapsLock::j
':: Shift
$s::
{
    if (not GetKeyState("Shift", "P"))  ; Check if Shift key is pressed
    {
        Send "{k down}{s}{k up}"
    } else  
    {
	Send "{s}"
    }

}

;RButton::Send "{k down}{u}{k up}"
SetCapsLockState "AlwaysOff"
#HotIf ; Only active during league

#HotIf not WinActive("League of Legends (TM) Client") ; Not evaluated eveytime aparrently
SetCapsLockState "AlwaysOff"
#HotIf ; when league not active 

Esc::Esc
CapsLock::Esc


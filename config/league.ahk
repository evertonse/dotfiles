; DOCS: https://www.autohotkey.com/docs/v2/lib/GetKeyState.htm
#HotIf WinActive("League of Legends (TM) Client")
Shift::'
Esc::Esc
CapsLock::j
':: Shift
$s::
{
    if (not GetKeyState("Shift", "P") and not GetKeyState("RButton", "P"))  ; Check if Shift key is pressed
    {
        Send "{k down}{s}{k up}"
    } else  
    {
	Send "{s}"
    }

}
A_HotkeyInterval := 5  ; This is the default value (milliseconds).
A_MaxHotkeysPerInterval := 2000

ShouldModRButton := False


$RButton:: 
{
	if (GetKeyState("s", "P")) {
		Send "{k down}{u}"
		KeyWait "s", "L"
	} else if (not GetKeyState("Shift", "P") and not GetKeyState("s", "P")) {
            Send "{k down}{u}"
	    KeyWait "RButton"
	    Send "{k up}"
	
        } else {
	    Send "{RButton}"
        }
}

SetCapsLockState "AlwaysOff"
#HotIf ; Only active during league

#HotIf not WinActive("League of Legends (TM) Client") ; Not evaluated eveytime aparrently
SetCapsLockState "AlwaysOff"
#HotIf ; when league not active 

Esc::Esc
CapsLock::Esc




#Requires AutoHotkey v2.0
; AutoHotkey v2 script to replace broken middle mouse button
; Ctrl + Mouse Button 4 = Middle Click
; Hold Mouse Button 4 + Move Mouse = Scroll Wheel simulation

; Variables for scroll simulation
scrolling := false
startY := 0

; Adjust this value to change scroll sensitivity (lower = more sensitive).
; Also, word to the wise, it depends highly and your configuration on how much lines per scroll you have configured
sensitivity := 13.8

; ^XButton1::
; {
;     Click("Middle Down")  ; Press and hold middle button
;     KeyWait("XButton1")   ; Wait for Mouse Button 4 to be released
;     Click("Middle Up")    ; Release middle button
;     return
; }
;
; ^XButton2::
; {
;     Click("Middle Down")  ; Press and hold middle button
;     KeyWait("XButton2")   ; Wait for Mouse Button 4 to be released
;     Click("Middle Up")    ; Release middle button
;     return
; }


; *XButton1::
; {
;     Click("Middle Down")  ; Press and hold middle button
;     return
; }
;
; *XButton1 Up::
; {
;     Click("Middle Up")    ; Release middle button
;     return
; }

*XButton1::
{
    ; Check if Right Alt is pressed
    if GetKeyState("RAlt", "P")
    {
        ; Use normal XButton1 behavior
        Send("{XButton1}")
    }
    else
    {
        ; Emulate middle mouse button
        Click("Middle Down")
    }
    return
}

*XButton1 Up::
{
    ; Check if Right Alt is pressed
    if GetKeyState("RAlt", "P")
    {
        ; Use normal XButton1 behavior
        ; Send("{XButton1 up}")
    }
    else
    {
        ; Emulate middle mouse button
        Click("Middle Up")
    }
    return
}

; $*XButton1::
; {
;     Send("{MButton down}")
; }
;
; $*XButton1 Up::
; {
;     Send("{MButton up}")
; }

; Mouse Button 4 down - start scroll mode
; *XButton2::
; {
;     global scrolling, startY
;     
;     ; Get current mouse position
;     MouseGetPos(, &currentY)
;     startY := currentY
;     scrolling := true
;     
;     ; Wait for button release or mouse movement
;     while GetKeyState("XButton2", "P")
;     {
;         MouseGetPos(, &newY)
;         deltaY := startY - newY
;         
;         ; If mouse moved enough, scroll
;         if (Abs(deltaY) >= sensitivity)
;         {
;             if (deltaY > 0)
;             {
;                 ; Mouse moved up, scroll up
;                 Click("WheelDown")
;             }
;             else
;             {
;                 ; Mouse moved down, scroll down
;                 Click("WheelUp")
;             }
;             
;             ; Update start position for continuous scrolling
;             startY := newY
;         }
;         
;         ; Small delay to prevent excessive CPU usage
;         ; This inadvertently creates an upper bound on sensitivity, because while sleeping you wont cout the extra pixels the mouse moved.
;         ; Sleep(0.2)
;         Sleep(0.0)
;     }
;     
;     scrolling := false
;     return
; }

*XButton2::
{

    ; Check if Right Alt is pressed
    if GetKeyState("RAlt", "P")
    {
        ; Use normal XButton1 behavior
        Send("{XButton2}")
        return
    }

    global scrolling, startY
    
    ; Get current mouse position
    MouseGetPos(, &currentY)
    startY := currentY
    scrolling := true
    
    ; Wait for button release or mouse movement
    while GetKeyState("XButton2", "P")
    {
        MouseGetPos(, &newY)
        deltaY := startY - newY
        
        ; Check if Shift is pressed for faster scrolling
        isShiftPressed := GetKeyState("Shift", "P")
        scrollAmount := isShiftPressed ? 7 : 1  ; More scroll units with Shift
        
        ; If mouse moved enough, scroll
        if (Abs(deltaY) >= sensitivity) {
            if (deltaY > 0) {
                if (scrollAmount == 1) {
                    Click("WheelDown")
                }
                else {
                    Send("{WheelDown " . scrollAmount . "}")
                }
            }
            else
            {
                ; Mouse moved up, scroll up
                if (scrollAmount == 1) {
                    Click("WheelUp")
                }
                else {
                    Send("{WheelUp " . scrollAmount . "}")
                }
            }
            ; Update start position for continuous scrolling
            startY := newY
        }
        
        ; Small delay to prevent excessive CPU usage
        ; Sleep(0.0)
    }
    
    scrolling := false
    return
}

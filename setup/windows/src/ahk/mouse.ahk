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
$XButton1::
{
    Click("Middle Down")  ; Press and hold middle button
    return
}

$XButton1 Up::
{
    Click("Middle Up")    ; Release middle button
    return
}

^XButton2::
{
    Click("XButton2")
}

^XButton1::
{
    Click("XButton1")
}

; Mouse Button 4 down - start scroll mode
$XButton2::
{
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
        
        ; If mouse moved enough, scroll
        if (Abs(deltaY) >= sensitivity)
        {
            if (deltaY > 0)
            {
                ; Mouse moved up, scroll up
                Click("WheelDown")
            }
            else
            {
                ; Mouse moved down, scroll down
                Click("WheelUp")
            }
            
            ; Update start position for continuous scrolling
            startY := newY
        }
        
        ; Small delay to prevent excessive CPU usage
        ; This inadvertently creates an upper bound on sensitivity, because while sleeping you wont cout the extra pixels the mouse moved.
        ; Sleep(0.2)
        Sleep(0.0)
    }
    
    scrolling := false
    return
}

; Optional: Mouse Button 5 could be used for horizontal scrolling if needed
; Uncomment the lines below if you want horizontal scrolling with Mouse Button 5
/*
XButton2::
{
    global
    MouseGetPos(&startX, )
    
    while GetKeyState("XButton2", "P")
    {
        MouseGetPos(&newX, )
        deltaX := startX - newX
        
        if (Abs(deltaX) >= sensitivity)
        {
            if (deltaX > 0)
            {
                Click("WheelLeft")
            }
            else
            {
                Click("WheelRight")
            }
            startX := newX
        }
        Sleep(10)
    }
    return
}
*/

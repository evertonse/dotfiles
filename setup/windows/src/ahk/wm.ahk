#Requires AutoHotkey v2.0

FocusWindow(exe_name := "", window_title := "", window_class := "") {
    target_hwnd := 0
    
    ; Try to find window using provided parameters
    if (exe_name != "") {
        target_hwnd := WinExist("ahk_exe " . exe_name)
    }
    
    if (!target_hwnd && window_title != "") {
        target_hwnd := WinExist(window_title)
    }
    
    if (!target_hwnd && window_class != "") {
        target_hwnd := WinExist("ahk_class " . window_class)
    }
    
    if (target_hwnd) {
        ; Check if window is minimized and restore if needed
        if (WinGetMinMax(target_hwnd) == -1) {
            WinRestore(target_hwnd)
        }
        
        ; Activate first to prevent window snapping behavior
        WinActivate(target_hwnd)
        
        ; Small delay to ensure activation, then maximize if not already maximized
        Sleep(50)
        if (WinGetMinMax(target_hwnd) != 1) {
            WinMaximize(target_hwnd)
        }
        
        return true
    }
    
    return false
}

OpenApp(exe_path) {
    try {
        Run(exe_path)
        return true
    } catch {
        return false
    }
}

FocusOrOpen(exe_name := "", window_title := "", window_class := "", exe_path := "") {
    if (FocusWindow(exe_name, window_title, window_class)) {
        return true
    }
    
    ; If not found and exe_path provided, try to open it
    if (exe_path != "") {
        if (OpenApp(exe_path)) {
            ; Wait a bit for the app to start, then try to focus again
            Sleep(2000)
            return FocusWindow(exe_name, window_title, window_class)
        }
    }
    
    return false
}

LevenshteinDistance(s1, s2) {
    len1 := StrLen(s1)
    len2 := StrLen(s2)
    
    if (len1 == 0) {
        return len2
    }
    if (len2 == 0) {
        return len1
    }
    
    ; Create matrix
    matrix := []
    loop len1 + 1 {
        matrix.Push([])
        loop len2 + 1 {
            matrix[A_Index].Push(0)
        }
    }
    
    ; Initialize first row and column
    loop len1 + 1 {
        matrix[A_Index][1] := A_Index - 1
    }
    loop len2 + 1 {
        matrix[1][A_Index] := A_Index - 1
    }
    
    ; Fill matrix
    loop len1 {
        i := A_Index + 1
        loop len2 {
            j := A_Index + 1
            cost := (SubStr(s1, i-1, 1) == SubStr(s2, j-1, 1)) ? 0 : 1
            matrix[i][j] := Min(
                matrix[i-1][j] + 1,      ; deletion
                matrix[i][j-1] + 1,      ; insertion
                matrix[i-1][j-1] + cost  ; substitution
            )
        }
    }
    
    return matrix[len1 + 1][len2 + 1]
}

FuzzyMatch(search_term, window_title) {
    ; Convert to lowercase for case-insensitive matching
    search_lower := StrLower(search_term)
    title_lower := StrLower(window_title)
    
    ; Exact substring match gets highest priority
    if (InStr(title_lower, search_lower)) {
        return 1000 - InStr(title_lower, search_lower)
    }
    
    ; Fuzzy match using Levenshtein distance
    distance := LevenshteinDistance(search_lower, title_lower)
    max_len := Max(StrLen(search_lower), StrLen(title_lower))
    
    ; Convert distance to similarity score (higher is better)
    if (max_len == 0) {
        return 0
    }
    
    similarity := (max_len - distance) / max_len * 100
    return similarity
}

ShowFuzzyFinder() {
    ; Get all windows
    windows := []
    
    ; Enumerate all windows
    WinGet("List", &window_list)
    loop window_list.Length {
        hwnd := window_list[A_Index]
        title := WinGetTitle(hwnd)
        
        ; Skip windows without titles or system windows
        if (title != "" && !InStr(title, "Program Manager") && WinGetClass(hwnd) != "Shell_TrayWnd") {
            windows.Push({hwnd: hwnd, title: title})
        }
    }
    
    ; Create input box for search
    search_term := InputBox("Type window title to search:", "Fuzzy Window Finder", "w300 h100").Value
    
    if (search_term == "") {
        return
    }
    
    ; Find best matches
    matches := []
    for window in windows {
        score := FuzzyMatch(search_term, window.title)
        if (score > 10) {  ; Minimum threshold
            matches.Push({hwnd: window.hwnd, title: window.title, score: score})
        }
    }
    
    ; Sort by score (highest first)
    matches := SortMatches(matches)
    
    if (matches.Length > 0) {
        ; Focus the best match
        best_match := matches[1]
        
        if (WinGetMinMax(best_match.hwnd) == -1) {
            WinRestore(best_match.hwnd)
        }
        
        WinActivate(best_match.hwnd)
        Sleep(50)
        
        if (WinGetMinMax(best_match.hwnd) != 1) {
            WinMaximize(best_match.hwnd)
        }
    } else {
        MsgBox("No matching windows found for: " . search_term, "Fuzzy Finder", 48)
    }
}

SortMatches(matches) {
    ; Simple bubble sort by score (descending)
    n := matches.Length
    loop n - 1 {
        i := A_Index
        loop n - i {
            j := A_Index
            if (matches[j].score < matches[j + 1].score) {
                ; Swap
                temp := matches[j]
                matches[j] := matches[j + 1]
                matches[j + 1] := temp
            }
        }
    }
    return matches
}

; Hotkey examples with open functionality
#1::
{
    if (!FocusOrOpen("zen.exe", "Zen Browser", "MozillaWindowClass", "C:\Program Files\Zen Browser\zen.exe")) {
        MsgBox("Could not focus or open Zen Browser", "Error", 48)
    }
}

#2::
{
    if (!FocusOrOpen("chrome.exe", "", "Chrome_WidgetWin_1", "chrome.exe")) {
        MsgBox("Could not focus or open Chrome", "Error", 48)
    }
}

#3::
{
    if (!FocusOrOpen("firefox.exe", "", "MozillaWindowClass", "firefox.exe")) {
        MsgBox("Could not focus or open Firefox", "Error", 48)
    }
}

#4::
{
    if (!FocusOrOpen("Code.exe", "Visual Studio Code", "Chrome_WidgetWin_1", "code.exe")) {
        MsgBox("Could not focus or open VS Code", "Error", 48)
    }
}

#5::
{
    if (!FocusOrOpen("notepad.exe", "Notepad", "Notepad", "notepad.exe")) {
        MsgBox("Could not focus or open Notepad", "Error", 48)
    }
}

; Fuzzy finder hotkey
#n::
{
    ShowFuzzyFinder()
}

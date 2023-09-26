;streamer.ahk
; input and output
;
;

global stockfishPID := 999
;global fishlog := rel_path . "\engine\fishlog.txt"

FishlogRefresh()

AttachStockfish() {
  if not WinExist("ahk_exe stockfish.exe") {
    run C:\Users\Student\c\chess\stockfish\stockfish.exe , , , stockfishPID
  } else {
    winactivate ahk_exe stockfish.exe
  }
  winwaitactive ahk_exe stockfish.exe, , 0.2
  winget stockfishPID, PID, ahk_exe stockfish.exe
  dllcall("AttachConsole", "int", stockfishPID)
;  OutToFish("ucinewgame")
}

ActivateStockfish() {
  winactivate ahk_exe stockfish.exe
  winwaitactive ahk_exe stockfish.exe, , 0.2
}

FishlogRefresh() {
  filedelete % fishlog
  fileappend fishlog `n , % fishlog
}

GetConsoleText() {
  ActivateStockfish()
  ;winactivate ahk_exe stockfish.exe
  Send,{Shift Down}{Up}{Shift Up}{Ctrl Down}{Ins}{Ctrl Up}
  return clipboard
}

UpdateFishlog() {
  log_text := GetConsoleText()
  fileappend % log_text, % fishlog
}

GetFishLineNum() {
  loop read, % fishlog 
    last_line_num := A_Index
  return last_line_num
}

InFromFish() {
  UpdateFishlog()
  last_line_num := GetFishLineNum()
  FileReadLine fish_text, % fishlog, % last_line_num
  return fish_text
}

OutToFish(out_text) {
;  ActivateStockfish()
  clipboard := out_text
  WinMenuSelectItem ahk_exe stockfish.exe,, 0&, Edit, Paste
  ControlSend, , {Enter}, ahk_exe stockfish.exe

}

ExitStreamer() {
  WinClose, ahk_exe stockfish.exe
;  ExitApp
}


; 1::AttachStockfish()
; 2::OutToFish("P1/P1P3P1R1")

; ^+x::
;   ExitStreamer()
;   ExitApp



; GetConsoleTextOld() {
;   handle := DllCall("CreateFile","str","CONOUT$","uint",0xC0000000
;                     ,"uint",7,"uint",0,"uint",3,"uint",0,"uint",0)
;   VarSetCapacity(buffer_info, 40, 0)
;   DllCall("GetConsoleScreenBufferInfo"
;           ,"uint",handle,"uint",&buffer_info)
;   ConWinLeft := NumGet(buffer_info, 10, "Short")     ; info.srWindow.Left
;   ConWinTop := NumGet(buffer_info, 12, "Short")      ; info.srWindow.Top
;   ConWinRight := NumGet(buffer_info, 14, "Short")    ; info.srWindow.Right
;   ConWinBottom := NumGet(buffer_info, 16, "Short")   ; info.srWindow.Bottom
;   ConWinWidth := ConWinRight - ConWinLeft + 1
;   ConWinHeight := ConWinBottom - ConWinTop + 1
;   VarSetCapacity(output_text, ConWinWidth * ConWinHeight, 0)
;   DllCall("ReadConsoleOutputCharacter", "uint", handle
;           ,"str", output_text, "uint", 1200, "uint", 50)
;   return output_text
; }

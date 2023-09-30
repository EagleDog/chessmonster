;streamer.ahk
; input and output
;
;
global fishlog := rel_path . "\engine\fishlog.txt"
global stockfishPID := 999

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
}

ActivateStockfish() {
  winactivate ahk_exe stockfish.exe
  winwaitactive ahk_exe stockfish.exe, , 0.2
}

GetConsoleText() {
  ActivateStockfish()
  Send,{Shift Down}{Up}{Shift Up}{Ctrl Down}{Ins}{Ctrl Up}
  return clipboard
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
  clipboard := out_text
  WinMenuSelectItem ahk_exe stockfish.exe,, 0&, Edit, Paste
  ControlSend, , {Enter}, ahk_exe stockfish.exe

}

MoveStockfish() {
  WinMove, ahk_exe stockfish.exe, , 1280, 107, 1200, 750
}

FishlogRefresh() {
  filedelete % fishlog
  fileappend fishlog `n , % fishlog
}

UpdateFishlog() {
  log_text := GetConsoleText()
  fileappend % log_text, % fishlog
}

ExitStreamer() {
  WinClose, ahk_exe stockfish.exe
}

; 1::AttachStockfish()
; 2::OutToFish("P1/P1P3P1R1")
;
; ^+x::
;   ExitStreamer()
;   ExitApp

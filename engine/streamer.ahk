;streamer.ahk
; input and output
;

stockfish_commands := ["ucinewgame","isready","d","position startpos"
,"position fen","go movetime 1000", "stop", "flip"]


global stockfishPID := 999

AttachStockfish() {
  if not WinExist("ahk_exe stockfish.exe") {
    run C:\Users\Student\c\chess\stockfish\stockfish.exe , , , stockfishPID
  } else {
    winactivate ahk_exe stockfish.exe
  }
  winwaitactive ahk_exe stockfish.exe, , 0.2
  winget stockfishPID, PID, ahk_exe stockfish.exe
;  msgbox % stockfishPID
  dllcall("AttachConsole", "int", stockfishPID)
  fileappend ucinewgame`n, *
}






1::AttachStockfish()


^+x::ExitApp

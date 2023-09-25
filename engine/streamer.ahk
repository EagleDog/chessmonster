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
  dllcall("AttachConsole", "int", stockfishPID)
  SendIt("ucinewgame")
}

SendIt(info) {
;  ControlSend, , %info% {Enter} , ahk_class ConsoleWindowClass
   ControlSend, , %info% {Enter} , ahk_exe stockfish.exe
}

GetConsoleText() {
  handle := DllCall("CreateFile","str","CONOUT$","uint",0xC0000000
                    ,"uint",7,"uint",0,"uint",3,"uint",0,"uint",0)

  VarSetCapacity(buffer_info, 40, 0)

  DllCall("GetConsoleScreenBufferInfo"
          ,"uint",handle,"uint",&buffer_info)

  ConWinLeft := NumGet(buffer_info, 10, "Short")     ; info.srWindow.Left
  ConWinTop := NumGet(buffer_info, 12, "Short")      ; info.srWindow.Top
  ConWinRight := NumGet(buffer_info, 14, "Short")    ; info.srWindow.Right
  ConWinBottom := NumGet(buffer_info, 16, "Short")   ; info.srWindow.Bottom
  ConWinWidth := ConWinRight - ConWinLeft + 1
  ConWinHeight := ConWinBottom - ConWinTop + 1

  VarSetCapacity(output_text, ConWinWidth * ConWinHeight, 0)

  DllCall("ReadConsoleOutputCharacter","uint",handle
          ,"str",output_text,"uint",1000,"uint",0,"uint*")

  msgbox % output_text
}

FileReadLine(file,lineNum) {
  filereadline info, %file%, %lineNum%
  return info
}

ExitSequence() {
  WinClose, ahk_exe stockfish.exe
  ExitApp
}

1::AttachStockfish()
2::SendIt("isready")
3::GetConsoleText()

^+x::ExitSequence()

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
  ; fileappend ucinewgame`n, *
  SendIt("ucinewgame")
;  fileappend ucinewgame`n, CONOUT$
;  fileappend isready`n, CONOUT$
  ; filereadline info, CONOUT$, 1
;  msgbox %info%
}

SendIt(info) {
  ControlSend, , %info% {Enter} , ahk_exe stockfish.exe

;  fileappend %info%, CONOUT$
}

SendEnter() {
  ControlSend, , {Enter} , ahk_exe stockfish.exe
;  Send asdf
}
ReceiveIt() {
  handle:=DllCall("CreateFile","str","CONOUT$","uint",0xC0000000 ,"uint",7,"uint",0,"uint",3,"uint",0,"uint",0)

  buffer_info := 0

  capacity_1 := VarSetCapacity(buffer_info, 40, 0)

  handle_info := DllCall("GetConsoleScreenBufferInfo","uint",handle,"uint",&buffer_info)
;  handle_info := DllCall("GetConsoleScreenBufferInfo", "Ptr", handle, "str", "CONOUT$" )
;  handle_info := DllCall("GetConsoleScreenBufferInfo", "Ptr", handle, "HRESULT", info )


  ConWinLeft := NumGet(buffer_info, 10, "Short")     ; info.srWindow.Left
  ConWinTop := NumGet(buffer_info, 12, "Short")      ; info.srWindow.Top
  ConWinRight := NumGet(buffer_info, 14, "Short")    ; info.srWindow.Right
  ConWinBottom := NumGet(buffer_info, 16, "Short")   ; info.srWindow.Bottom
  ConWinWidth := ConWinRight - ConWinLeft + 1
  ConWinHeight := ConWinBottom - ConWinTop + 1

;  capacity_2 := VarSetCapacity(output_text, 1000, 0)
  capacity_2 := VarSetCapacity(output_text, ConWinWidth * ConWinHeight, 0)

  DllCall("ReadConsoleOutputCharacter","uint",handle,"str",output_text
            ,"uint",1000,"uint",0,"uint*",numCharsRead)


  ; DllCall("ReadConsoleOutputCharacter","uint",handle,"str",output_text
  ;           ,"uint",ConWinWidth*ConWinHeight,"uint",0,"uint*",numCharsRead)

  ;output_info := DllCall("ReadConsoleOutput", "str", "CONOUT$", "Ptr", handle, "int", 3, "int", 3, "Ptr", "2 2 2 2"  )

;  handle := DllCall("CreateFileA", "int", "output.txt", "int", "GENERIC_READ | GENERIC_WRITE", "int", 0, , , "int", 5, "int", "FILE_ATTRIBUTE_NORMAL"  )

;  FileRead, info, CONIN$
;  stdin  := FileOpen("*", "r `n")
;  info := DllCall( "ReadFile", Ptr,hStdOutRd, Ptr,&sTemp, UInt,nTot, PtrP,nSize, Ptr,0 )
;  ControlGetText, info, Select , ahk_exe stockfish.exe
;  info := FileReadLine(CONIN$, 1)
  msgbox % ConWinWidth " " ConWinHeight " " numCharsRead " " capacity_1 " " capacity_2 " " handle " " handle_info " " info " " output_text
;  return info
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
3::ReceiveIt()
;4::SendEnter()

^+x::ExitSequence()

;toolbox.ahk
;
;

OnMessage(0x44, "Move_MsgBox")

Move_MsgBox(P) {
  if (P = 1027) {
    Process, Exist
    DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
    if WinExist("ahk_class #32770 ahk_pid " ErrorLevel)
      WinMove, 500, 400
    DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
  }
}

FlipBoard() {
  LogMain0("FlipBoard()"), sleep, 50
  if (my_color == "black") {
    my_color := "black"
  }
}

PauseMatch() {
  if paused {
    paused := false
  } else {
    paused := true
  }
}

PauseDisplay() {
  LogMain0("           ready")
  LogMain("1 new match")
  LogTimer("2 continue")
  LogVolume("r rematch")
}

ColToFile(col) {
  file := Chr(96 + col) ; col > a-h
  return file
}

Chill() {
  sleep 100
}

Print(outout_text) {
  fileappend % output_text " ", *
}


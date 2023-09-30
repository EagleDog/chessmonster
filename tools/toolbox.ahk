;toolbox.ahk
;
;

FlipBoard() {
  LogMain0("FlipBoard()"), sleep, 50
  if (my_color == "black") {
    my_color := "black"
  }
}

PauseDisplay() {
  LogMain0("           ready")
  LogMain("1 new match")
  LogTimer("2 continue")
  LogVolume("r rematch")
}

PauseMatch() {
  if paused {
    paused := false
;    GoLoop()
  } else {
    paused := true
  }
}

ColToFile(col) {
  file := Chr(96 + col) ; col > a-h
  return file
}

Chill() {
  sleep 10
}

Print(outout_text) {
  fileappend % output_text " ", *
}


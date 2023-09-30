;toolbox.ahk
;
;

FlipBoard() {
  LogMain0("FlipBoard()"), sleep, 50
  if (my_color == "black") {
    my_color := "black"
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


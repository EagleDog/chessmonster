;toolbox.ahk
;
;

OnMessage(0x44, "Move_MsgBox")

Move_MsgBox(P) {
  if (P = 1027) {
    Process, Exist
    DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
    if WinExist("ahk_class #32770 ahk_pid " ErrorLevel)
      WinMove, 500, 200
;      WinMove, , , 800, 300, 300, 500
    DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
  }
}

DelayMove() {
  random extra_delay, 1000, move_delay_max
  delay := 1000 + extra_delay
  while ( delay > -0.4 ) {
    LogField1("delay " Floor(delay/1000))
    sleep, 1000
    delay := delay - 1000
  }
}

ClearLogFields() {
  LogField1("")
  LogField2("")
  LogField3("")
  LogField4("")
  LogField5("")
  LogField6("")
}

FlipBoard() {
  LogField1("FlipBoard()"), sleep, 50
  if (my_color == "black") {
    my_color := "black"
  }
}

PauseMatch() {
  ; if paused {
  ;   paused := false
  ; } else {
    paused := true
  ; }
}

PauseDisplay() {
  LogField1("ready")
  LogField2("1 new match")
  LogField3("2 continue")
  LogField4("r rematch")
}

ColToFile(col) {
  file := Chr(96 + col) ; col > a-h
  return file
}

Chill() {
  sleep 100
}

Beep() {
  SoundBeep, 448, 600 ; [ Freq, Duration]
  sleep 500
}

HideGui() {
  gui hide
  ActivateChess()
}
ShowGui(){
  gui show
  ActivateChess()
}

LogOpp1(log_text) {
  if ( opp_color == "black" ) {
    LogField3(log_text)
  } else {
    LogField5(log_text)
  }
}

LogOpp2(log_text) {
  if ( opp_color == "black" ) {
    LogField4(log_text)
  } else {
    LogField6(log_text)
  }
}

LogMine1(log_text) {
  if ( my_color == "black" ) {
    LogField3(log_text)
  } else {
    LogField5(log_text)
  }
}

LogMine2(log_text) {
  if ( my_color == "black" ) {
    LogField4(log_text)
  } else {
    LogField6(log_text)
  }

}


Print(outout_text) {
  fileappend % output_text " ", *
}

ScrollUp() {
  send {WheelUp}
  send {WheelUp}
}

RandomChoice(max=2) {
  random, choice, 1, max
  if (choice = 1) {
    return true
  } else {
    return false
  }
}


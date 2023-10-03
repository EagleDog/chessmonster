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

ClearLogFields() {
  LogField1("")
  LogField2("")
  LogField3("")
  LogField4("")
  LogField5("")
}


HideCursor(){
  mousemove 1500, 900, 0
}

; ShowCursor() {
;    ; BlockInput MouseMoveOff
;    ; DllCall("ShowCursor", Int, 1)
; }

FlipBoard() {
  LogField1("FlipBoard()"), sleep, 50
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
  LogField1("           ready")
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

Print(outout_text) {
  fileappend % output_text " ", *
}

ScrollUp() {
  send {WheelUp}
  send {WheelUp}
}



SystemCursor(OnOff := 1) {  ; INIT = "I","Init"; OFF = 0,"Off"; TOGGLE = -1,"T","Toggle"; ON = others
 ; https://www.autohotkey.com/boards/viewtopic.php?t=6167
 Static AndMask, XorMask, $, h_cursor
  , b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13   ; Blank cursors
  , h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13   ; Handles of default cursors
  , c := StrSplit("32512,32513,32514,32515,32516,32642,32643,32644,32645,32646,32648,32649,32650", ",")
 If (OnOff = "Init" || OnOff = "I" || $ = "") {  ; Init when requested or at first call
  $ = h                                          ; Active default cursors
  VarSetCapacity(h_cursor,4444, 1), VarSetCapacity(AndMask, 32*4, 0xFF), VarSetCapacity(XorMask, 32*4, 0)
  For each, cursor in c {
   h_cursor := DllCall("LoadCursor", "Ptr",0, "Ptr", cursor)
   h%each%  := DllCall("CopyImage", "Ptr", h_cursor, "UInt", 2, "Int", 0, "Int", 0, "UInt", 0)
   b%each%  := DllCall("CreateCursor", "Ptr", 0, "Int", 0, "Int", 0
                     , "Int", 32, "Int", 32, "Ptr", &AndMask, "Ptr", &XorMask)
  }
 }
 $ := OnOff = 0 || OnOff = "Off" || $ = "h" && (OnOff < 0 || OnOff = "Toggle" || OnOff = "T") ? "b" : "h"
 For each, cursor in c {
  h_cursor := DllCall("CopyImage", "Ptr", %$%%each%, "UInt", 2, "Int", 0, "Int", 0, "UInt", 0)
  DllCall("SetSystemCursor", "Ptr", h_cursor, "UInt", cursor)
 }
}

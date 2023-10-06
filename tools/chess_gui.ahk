; chess_gui.ahk
;

; Gui, 1: +AlwaysOnTop +Border -Caption +Owner
; Gui, 1: Color, 99B0B9

; Gui, Show, , Border Example

; Gui, Add, Text, xp yp wp hp Center +0x0200 BackgroundTrans, CHESSMONSTER ; 0x0200 centers single-line text vertically
; gui show, x851 y106 w340 h680, chessmonster info, NoActivate ; Border Example ;, NoActivate avoids deactivating the currently active window.



gui add, Text, w280 h10 center, 
GuiAddBorder("Black", 10, "0 10 w400 h80")
gui font, s14 w1000, Courier New
gui add, Text, xp-40 yp-5 wp hp Center +0x0200 BackgroundTrans, CHESSMONSTER ; 0x0200 centers single-line text vertically
gui +AlwaysOnTop +ToolWindow -SysMenu
gui color, 0x888877     ; BACKGROUND COLOR  <-------

gui add, Text, w280 h20 x20 y110 right Vfield_1, % field_1_text
gui add, Text, w280 h20 x20 y135 center Vfield_2, % field_2_text

gui add, Text, w280 h20 x20 y165 center Vfield_3, % field_3_text
gui add, Text, w280 h20 x20 y192 center Vfield_4, % field_4_text
gui add, Text, w280 h20 x20 y219 center Vfield_5, % field_5_text

gui add, Text, w280 h20 x20 y270 center Vblack_title_field, % black_title_text
gui add, Text, w280 h200 x30 y290 right Vpositions_field, % positions_text
gui add, Text, w280 h20 x20 y500 center Vwhite_title_field, % white_title_text

gui add, Text, w280 h20 x20 y550 center Vmoves_field, % moves_text
gui add, Text, w280 h20 x20 y590 center Vcastle_field, % castle_text
gui add, Text, w280 h40 x34 y620 center Vmy_color_field, % my_color_text

; gui add, Text, w280 h20 x20 y500 center Vnum_pieces_field, % num_pieces_text


ZoomGui()
RefreshGui()
MoveGui1()
MoveGui2()
; ShakeGui()


RefreshGui() {
  LogField1("initialize")
  LogField2("a1 white rook")
  LogField3("A for positions")
  LogField4("1 to start")
  LogField5("R for rematch")
  LogBlackTitle("black")
  LogPositions("positions")
  LogWhiteTitle("white")
  ; LogNumPieces("white 16  black 16")
  ; LogMoves("move_num == " . move_num)
  LogMoves(1)
  LogCastle("KQkq")
  LogMyColor("WHITE")
}

CreateGui() {
  LogField1("initialize")
  sleep 50
}

LogField1(field_1_text) {
  GuiControl,, field_1, % field_1_text " "
}
LogField2(field_2_text) {
  GuiControl,, field_2, % field_2_text
}
LogField3(field_3_text) {
  GuiControl,, field_3, % field_3_text
}
LogField4(field_4_text) {
  GuiControl,, field_4, % field_4_text
}
LogField5(field_5_text) {
  GuiControl,, field_5, % field_5_text
}
;
LogBlackTitle(black_title_text) {
  GuiControl,, black_title_field, % "black  " black_title_text  " pieces"
}
LogPositions(positions_text) {
  GuiControl,, positions_field, % positions_text
}
LogWhiteTitle(white_title_text) {
  GuiControl,, white_title_field, % "white  " white_title_text " pieces"
}
;
LogMoves(moves_text) {
  GuiControl,, moves_field, % moves_text . "  move_num "
}
LogCastle(castle_text) {
  GuiControl,, castle_field, % "fen info: " castle_text
}
LogMyColor(my_color_text) {
  GuiControl,, my_color_field, % my_color_text
}

MoveGui1() {
  gui show, x1151 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  gui show, x1051 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  gui show, x951 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  gui show, x901 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  gui show, x851 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  LogField2("1 MoveGui1()")
  ActivateChess()
}
MoveGui2() {
  gui, show, x870 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  gui, show, x970 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  gui, show, x1070 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  gui, show, x1170 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  gui, show, x1251 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  LogField2("2 MoveGui2()")
  ActivateChess()
}
MoveGui3() {
  gui show, x1251 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  gui show, x1151 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  gui show, x1051 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  gui show, x1001 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  gui show, x951 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  LogField2("3 MoveGui3()")
  ActivateChess()
}
ShakeGui() {
  gui show, x851 y106 w340 h680, chessmonster info, NoActivate
  sleep 5
  gui show, x840 y98 w340 h680, chessmonster info, NoActivate
  sleep 5
  gui show, x851 y109 w340 h680, chessmonster info, NoActivate
  sleep 5
  Gui, Show, x864 y97 w340 h680, chessmonster info, NoActivate
  sleep 5
  Gui, Show, x838 y105 w340 h680, chessmonster info, NoActivate
  sleep 5
  Gui, Show, x872 y102 w340 h680, chessmonster info, NoActivate
  sleep 5
  Gui, Show, x842 y96 w340 h680, chessmonster info, NoActivate
  sleep 5
  Gui, Show, x867 y108 w340 h680, chessmonster info, NoActivate
  sleep 5
  gui show, x851 y106 w340 h680, chessmonster info, NoActivate
  sleep 50
}
ZoomGui() {
  gui show, x980 y140 w255 h510, chessmonster info, NoActivate
  sleep 10
  gui show, x945 y135 w270 h540, chessmonster info, NoActivate
  sleep 10
  gui show, x910 y130 w280 h560, chessmonster info, NoActivate
  sleep 10
  gui show, x888 y125 w290 h580, chessmonster info, NoActivate
  sleep 10
  gui show, x875 y120 w300 h600, chessmonster info, NoActivate
  sleep 10
  gui show, x865 y115 w310 h620, chessmonster info, NoActivate
  sleep 10
  gui show, x860 y110 w320 h640, chessmonster info, NoActivate
  sleep 20
  gui show, x855 y108 w330 h660, chessmonster info, NoActivate
  sleep 20
  gui show, x851 y106 w340 h680, chessmonster info, NoActivate
  sleep 20
}
ZoomGui2() {
  gui show, x1080 y140 w255 h510, chessmonster info, NoActivate
  sleep 10
  gui show, x1010 y130 w280 h560, chessmonster info, NoActivate
  sleep 10
  gui show, x975 y120 w300 h600, chessmonster info, NoActivate
  sleep 10
  gui show, x960 y110 w320 h640, chessmonster info, NoActivate
  sleep 20
  gui show, x951 y106 w340 h680, chessmonster info, NoActivate
  sleep 20
}


GuiAddBorder(Color, Width, PosAndSize) {
   ; -------------------------------------------------------------------------------------------------------------------------------
   ; Color        -  border color as used with the 'Gui, Color, ...' command, must be a "string"
   ; Width        -  the width of the border in pixels
   ; PosAndSize   -  a string defining the position and size like Gui commands, e.g. "xm ym w400 h200".
   ;                 You should not pass other control options!
   ; -------------------------------------------------------------------------------------------------------------------------------
   LFW := WinExist() ; save the last-found window, if any
   DefGui := A_DefaultGui ; save the current default GUI
   ; Gui, Add, Text, y80 h200 +hwndHTXT
   Gui, Add, Text, %PosAndSize% +hwndHTXT
   GuiControlGet, T, Pos, %HTXT%
   Gui, New, +Parent%HTXT% +LastFound -Caption ; create a unique child Gui for the text control
   Gui, Color, %Color%
   X1 := Width
   X2 := TW - Width
   Y1 := Width
   Y2 := TH - Width
   WinSet, Region, 0-0 %TW%-0 %TW%-%TH% 0-%TH% 0-0   %X1%-%Y1% %X2%-%Y1% %X2%-%Y2% %X1%-%Y2% %X1%-%Y1%
   Gui, Show, x0 y0 w%TW% h%TH%
   Gui, %DefGui%:Default ; restore the default Gui
   If (LFW) ; restore the last-found window, if any
      WinExist(LFW)
}




; GuiTest() {
;   GuiOutput("hello")
; }

; sleep, 1000
; gui_text := "BBBB"
; GuiControl,, VarDisplay, % gui_text

; sleep, 1000
; gui_text := "CCCC"
; GuiControl,, VarDisplay, % gui_text


; Gui, Add, Text, , pawn gobbler
; Gui, Add, Edit, w150 hwndmyedit, updateable

;Gui, Show, NoActivate

;return

; GuiControl, , Edit1, %my_color% ; this will put the content of the variable in the editbox (edit1 is taken by the winspy)
; Gui, Submit, NoHide ; save the changes and not hide the windows)
; Return


; ControlSetText,, %my_color%, ahk_id %myedit%

; UpdateOSD:
; MouseGetPos, MouseX, MouseY
; GuiControl,, MyText, X%MouseX%, Y%MouseY%
; return



; f1::my_color := "bluerange"


; ^F2::
; var1 = hello

; Gui, Add, Edit, x6 y7 w210 h70 hwndmyedit, Editme
; ; Generated using SmartGUI Creator 4.0
; Gui, Show, w225 h85, New GUI Window

; ControlSetText,, %var1%, ahk_id %myedit%

; Return


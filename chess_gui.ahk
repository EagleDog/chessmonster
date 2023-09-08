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

gui add, Text, w280 h20 x20 y130 left Vmain0_field, % main0_text
gui add, Text, w280 h20 x20 y150 center Vmain_field, % main_text
gui add, Text, w280 h20 x20 y170 center Vtimer_field, % timer_text
gui add, Text, w280 h20 x20 y190 center Vvolume_field, % volume_text
gui add, Text, w280 h200 x20 y260 center Vpositions_field, % positions_text
gui add, Text, w280 h20 x20 y500 center Vnum_pieces_field, % num_pieces_text
gui add, Text, w280 h20 x20 y560 center Vmoves_field, % moves_text

LogMain0("    press 1 to start")
LogMain("press r for rematch")
LogTimer(".")
LogPositions("press A for positions")
LogNumPieces("white 16  black 16")
LogMoves("Move # 0")

ZoomGui()
; ShakeGui()

CreateGui() {
  LogMain("CreateGui()")
  sleep 200
}

LogMain0(main0_text) {
  GuiControl,, main0_field, % main0_text
}
LogMain(main_text) {
  GuiControl,, main_field, % main_text
}
LogTimer(timer_text) {
  GuiControl,, timer_field, % timer_text
}
LogVolume(volume_text) {
  GuiControl,, volume_field, % "volume: " . volume_text
}
LogPositions(positions_text) {
  GuiControl,, positions_field, % positions_text
}
LogNumPieces(num_pieces_text) {
  GuiControl,, num_pieces_field, % num_pieces_text
}
LogMoves(moves_text) {
  GuiControl,, moves_field, % moves_text
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
  LogMain("1 MoveGui1()")
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
  gui, show, x1220 y106 w340 h680, chessmonster info, NoActivate
  sleep 15
  LogMain("2 MoveGui2()")
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


; chess_gui.ahk
;

; Gui, 1: +AlwaysOnTop +Border -Caption +Owner
; Gui, 1: Color, 99B0B9

; Gui, Show, , Border Example


Gui, Add, Text, w280 h10 center, 
GuiAddBorder("Black", 10, "0 10 w400 h80")
; Gui, Add, Text, xp yp wp hp Center +0x0200 BackgroundTrans, CHESSMONSTER ; 0x0200 centers single-line text vertically
Gui, Font, s14 w1000, Courier New
Gui, Add, Text, xp-40 yp-5 wp hp Center +0x0200 BackgroundTrans, CHESSMONSTER ; 0x0200 centers single-line text vertically

Gui, Color, 0x888877     ; BACKGROUND COLOR  <-------

Gui, +AlwaysOnTop +ToolWindow -SysMenu

Gui, Add, Text, w280 h20 x20 y150 center Vmain_field, % main_text

Gui, Add, Text, w280 h20 x20 y170 center Vtimer_field, % timer_text

Gui, Add, Text, w280 h20 x20 y190 center Vvolume_field, % volume_text



Gui, Add, Text, w280 h200 x20 y260 center Vpositions_field, % positions_text


Gui, Add, Text, w280 h20 x20 y500 center Vnum_pieces_field, % num_pieces_text

Gui, Add, Text, w280 h20 x20 y560 center Vmoves_field, % moves_text

LogMain("press 1 to start")
LogTimer(".")
LogPositions("press A for positions")
LogNumPieces("W  1      B  1")
LogMoves("Move # 0")

;            X   Y
Gui, Show, x1220 y106 w340 h680, chessmonster info, NoActivate ; Border Example ;, NoActivate avoids deactivating the currently active window.
; Gui, Show, x851 y82 w340 h680, chessmonster info, NoActivate ; Border Example ;, NoActivate avoids deactivating the currently active window.


LogTimer(timer_text) {
  GuiControl,, timer_field, % timer_text
}
LogMain(main_text) {
  GuiControl,, main_field, % main_text
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


; chess_gui.ahk
;

Gui, +AlwaysOnTop +ToolWindow -SysMenu ; +Disabled ;-SysMenu ; +NoActivate ; +Owner ; +Disabled +Resize ; +MinSize300x200 ; +Owner avoids a taskbar button.
Gui, Color, 0xaaaaaa
Gui, Font, s14 w1000, Courier New
Gui, Add, Text, w280 h20 y+14 center, __CHESSMONSTER__
Gui, Add, Text, w280 h20 center Vtimer_field, % gui_text
Gui, Add, Text, w280 h20 center Vmain_field, % gui_text
Gui, Add, Text, w280 h20 center Vvolume_field, % gui_text
Gui, Add, Text, w280 h200 center Vpositions_field, % gui_text
Gui, Add, Text, w280 h20 center Vmoves_field, % gui_text

LogTimer(" ---timer--- ")
LogMain("press 1 to start")
LogPositions("press A for positions")
LogMoves("Move # 0")

Gui, Show, x1240 y40 w340 h500, chessmonster info, NoActivate ;, NoActivate avoids deactivating the currently active window.

LogTimer(gui_text) {
  GuiControl,, timer_field, % gui_text
}
LogMain(gui_text) {
  GuiControl,, main_field, % gui_text
}
LogVolume(gui_text) {
  GuiControl,, volume_field, % "volume: " . gui_text
}
LogPositions(gui_text) {
  GuiControl,, positions_field, % gui_text
}
LogMoves(gui_text) {
  GuiControl,, moves_field, % gui_text
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


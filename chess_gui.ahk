; chess_gui.ahk


Gui, +AlwaysOnTop -SysMenu ; +NoActivate ; +Owner ; +Disabled +Resize ; +MinSize300x200 ; +Owner avoids a taskbar button.
Gui, Add, Text, , pawn gobbler
Gui, Add, Edit, w150 hwndmyedit, updateable


Gui, Show, x1200 y100 w300 h200, chessmonster info  ;NoActivate, NoActivate avoids deactivating the currently active window.

return

; GuiControl, , Edit1, %my_color% ; this will put the content of the variable in the editbox (edit1 is taken by the winspy)
; Gui, Submit, NoHide ; save the changes and not hide the windows)
; Return


; ControlSetText,, %my_color%, ahk_id %myedit%

; UpdateOSD:
; MouseGetPos, MouseX, MouseY
; GuiControl,, MyText, X%MouseX%, Y%MouseY%
; return



f1::my_color := "bluerange"


; ^F2::
; var1 = hello

; Gui, Add, Edit, x6 y7 w210 h70 hwndmyedit, Editme
; ; Generated using SmartGUI Creator 4.0
; Gui, Show, w225 h85, New GUI Window

; ControlSetText,, %var1%, ahk_id %myedit%

; Return

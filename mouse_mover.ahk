;mouse_mover.ahk
;
; MovePiece(source, target)
; ClickDrag(s,t)
; DriftMouse()
; 


MovePiece(source, target) {
  ClickDrag(source, target)
  ; MouseMove, board[source].x, board[source].y
  ; Click, Down
  ; MouseMove, board[target].x, board[target].y
  ; Click, Up
}

ClickDrag(s, t) {  ; s-source t-target b-board L-Left 2-Speed 0-100
  MouseClickDrag, L, b[s].x, b[s].y, b[t].x, b[t].y, 2
}

DriftMouse() {
  Random, x, 0, 80
  Random, y, 0, 80  
  Random, speed, 1, 7 
  MouseMove, x - 40, y - 40, speed, Relative
}


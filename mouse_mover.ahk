;mouse_mover.ahk
;
; MovePiece(spot, target)
; ClickDrag(s,t)
; DriftMouse()
; 


MovePiece(spot, target) {
  ClickDrag(spot, target)
  UpdateTwoPositions(spot, target)
  ; MouseMove, board[spot].x, board[spot].y
  ; Click, Down
  ; MouseMove, board[target].x, board[target].y
  ; Click, Up
}

ClickDrag(s, t) {  ; s-spot t-target b-board L-Left 2-Speed 0-100
  MouseClickDrag, L, b[s].x, b[s].y, b[t].x, b[t].y, 2
}

DriftMouse() {
  Random, x, 0, 80
  Random, y, 0, 80  
  Random, speed, 1, 7 
  MouseMove, x - 40, y - 40, speed, Relative
}


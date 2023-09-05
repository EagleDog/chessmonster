;mouse_mover.ahk
;
; MovePiece(spot, target)
; ClickDrag(s,t)
; DriftMouse()
; 


MovePiece(spot, target) {
  ClickDrag(spot, target)
  UpdatePosition(spot)
  UpdatePosition(target)
  move_num += 1
  LogMoves("Move # " . move_num)
  ; MouseMove, board[spot].x, board[spot].y
  ; Click, Down
  ; MouseMove, board[target].x, board[target].y
  ; Click, Up
}

ClickDrag(spot, target) {  ; L-Left b-board 2-Speed 0-100
  MouseClickDrag, L, b[spot].x, b[spot].y, b[target].x, b[target].y, 2
}

DriftMouse() {
  Random, x, 0, 80
  Random, y, 0, 80  
  Random, speed, 1, 7 
  MouseMove, x - 40, y - 40, speed, Relative
}

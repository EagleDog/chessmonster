;
;
;   ______move_maker.ahk______
;          formerly mouse_mover.ahk
;   MovePieceOld(s,t)
;
;     ClickDrag(s,t)
;     DriftMouse()
;     MoveClick(x,y)
;     GoClick(spot)
;
;     MovePiece(spot,target)
;
;     fail
;
global fail := false

MovePiece(spot, target) {
LogMain("MovePiece: " . piece_type . " '" . spot . "'" . " to '" . target . "'" )
sleep 200
  ID1 := positions[spot].piece
  ClickDrag(spot, target)
  sleep 80
  UpdatePosition(spot)
  sleep 50
  UpdatePosition(target)
  sleep 50
  ID2 := positions[spot].piece

  if ( ID2 = ID1 ) {
    fail := true
  } else {
    move_num += 1
    LogMoves(move_num)
    UpdatePositionsHistory()
  }
}

MoveMouse(x, y, speed=0) {
  mousemove x, y, speed
}
GoSpot(spot) {
  MoveMouse(board[spot].x, board[spot].y)
}
ClickSpot(spot) {
  MoveMouse(board[spot].x, board[spot].y)
  Click
  ; MouseMove, board[spot].x, board[spot].y
}
MoveClick(x, y) {
  MoveMouse(x, y)
  Click
  ; MouseMove, x, y
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

MovePieceOld() {
  MouseMove, board[spot].x, board[spot].y
  Click, Down
  MouseMove, board[target].x, board[target].y
  Click, Up  
}


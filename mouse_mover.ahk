;
;
;   ______mouse_mover.ahk______
;
;     GoClick(spot)
;     MovePiece(spot,target)
;     ClickDrag(s,t)
;     DriftMouse()
;
;   MovePieceOld(s,t)
;
;
;


GoClick(spot) {
  MouseMove, board[spot].x, board[spot].y
  Click
}

MovePiece(spot, target) {
  ID1 := positions[spot].piece
  ClickDrag(spot, target)
  sleep 50
  UpdatePosition(spot)
  sleep 50
  UpdatePosition(target)
  sleep 50
  ID2 := positions[spot].piece
  ;
  ;  current work: failed move detection
  ;
  if ( ID2 = ID1 ) {
    LogMain("ID2: " . ID2 . "  ID1: " . ID1 . " failed move")
    sleep 1000
  } else {
    move_num += 1
    LogMoves("Move # " . move_num)
  }
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


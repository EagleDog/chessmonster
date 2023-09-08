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

global failed_moves := 0


GoClick(spot) {
  MouseMove, board[spot].x, board[spot].y
  Click
}
MoveClick(x, y) {
  MouseMove, x, y
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
  sleep 50

  ;
  ;  current work: failed move detection
  ;
  if ( ID2 = ID1 ) {
    LogMain("ID2: " . ID2 . "  ID1: " . ID1 . " failed move")
    sleep 500
    FailedMove()
  } else {
    move_num += 1
    LogMoves("Move # " . move_num)
  }
}

FailedMove() {
  LogMain("" . failed_moves . " FailedMove()")
  sleep, 200
  failed_moves += 1
  LogMain("" . failed_moves . " FailedMove()")
  sleep, 200
  if ( failed_moves >= 5 ) {
    failed_moves := 0
    LogMain("reset fails")
    sleep, 200
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


;
;
;   ______move_maker.ahk______
;          formerly mouse_mover.ahk
;   MovePieceOld(s,t)
;
;     MovePiece(spot,target)
;     MoveMouse(x,y,speed=0)
;     GoSpot(spot)
;     ClickSpot(spot)
;     MoveClick(x,y)
;     ClickDrag(spot,target)
;     DriftMouse()
;
;     fail
;
global fail := false

MovePiece(spot, target) {
LogMain("MovePiece:  '" spot "' to '" target "'" )
Chill()
  MoveAndFailCheck(spot, target)
  if !fail {
    Chill()
    move_num += 1
    UpdateSnapshots()  ; <== UpdateSnapshots()
    LogMoves(move_num)
;    sleep 500
  }
}

MoveAndFailCheck(spot, target) {
  ID1 := positions[spot].piece
  sleep 50
  ClickDrag(spot, target)  ; <==== click and drag
  sleep 150
  UpdatePosition(spot)  ; <== UpdatePosition(spot)
  sleep 50
  UpdatePosition(target)  ; <== UpdatePosition(spot)
  sleep 50
  ID2 := positions[spot].piece
  if ( ID2 == ID1 ) {  ; <=== fail check
    msgbox FAIL
    fail := true
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


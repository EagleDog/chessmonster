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
    IncreaseMoveNum()   ; <== UpdateSnapshots() included
;    move_num += 1
;    UpdateSnapshots()
;    LogMoves(move_num)
    WhichZones()
;    LogVolume(period)
  }
}

MoveAndFailCheck(spot, target) { ; Pawn Promotion too!
  ID1 := positions[spot].piece
  sleep 50
  ClickDrag(spot, target)  ; <==== click and drag
  sleep 200
  UpdatePosition(spot)  ; <== UpdatePosition(spot)
  snapshots[move_num][spot] := positions[spot].Clone() ; non-redundant
  sleep 50
  UpdatePosition(target)  ; <== UpdatePosition(spot)
  snapshots[move_num][target] := positions[target].Clone() ; non-redundant
  sleep 50
  ID2 := positions[spot].piece
;  msgbox % target " ID1: " ID1 "  " spot " ID2: " ID2
  if ( ID2 == ID1 ) {  ; <=== fail check
    msgbox FAIL
    fail := true
  }
  PromotePawn(spot, piece, target)   ; <== PromotePawn(spot,piece,target)
;  DidCastlersMove()    ; <== DidCastlersMove()
}

PromotePawn(spot, piece_type, target) {
  if ( (piece_type = "pawn") AND (target contains 8) ) {
    sleep 250
    mouseclick Left    ;  Promotion  choose queen
    sleep 150
    UpdatePosition(spot)
  }
}

Chill() {
  sleep 500
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
}

MoveClick(x, y) {
  MoveMouse(x, y)
  Click
}

ClickDrag(spot, target) {  ; L-Left b-board 2-Speed 0-100
  MouseClickDrag, L, b[spot].x, b[spot].y, b[target].x, b[target].y, 3
}

DriftMouse() {
  Random, x, 0, 80
  Random, y, 0, 80  
  Random, speed, 1, 7 
  MouseMove, x - 40, y - 40, speed, Relative
}

ResetMoves() {
  move_num := 1
  LogMoves(move_num)
}

IncreaseMoveNum() {
  move_num += 1
  LogMoves(move_num)
  UpdateSnapshots()
}

DecreaseMoveNum() {
  move_num -= 1
  LogMoves(move_num)
  UpdateSnapshots()
}



; MovePieceOld() {
;   MouseMove, board[spot].x, board[spot].y
;   Click, Down
;   MouseMove, board[target].x, board[target].y
;   Click, Up  
; }


;
;   ______move_maker.ahk______
;
;     MovePiece(spot,target)
;     MoveMouse(x,y,speed=0)
;     GoSpot(spot)
;     ClickSpot(spot)
;     MoveClick(x,y)
;     ClickDrag(spot,target)
;     DriftMouse()
;

global fail := false

MovePiece(spot, target) {
LogField5("move  '" spot "' to '" target "'" )
;Chill()
  fail := MoveAndFailCheck(spot, target)
  if !fail {
    IncreaseMoveNum()   ; <== UpdateSnapshots() included
;    move_num += 1
;    UpdateSnapshots()
;    LogMoves(move_num)
    WhichZones()
;    LogField4(period)
  } else {
    UpdateSnapshots()
  }
}

MoveAndFailCheck(old_spot, target) { ; Pawn Promotion too!
  ID2 := positions[old_spot].piece
  piece := ID2
  sleep 50
  ClickDrag(old_spot, target)  ; <==== click and drag
  sleep 200
  UpdatePosition(old_spot)  ; <== UpdatePosition(old_spot)
  snapshots[move_num][old_spot] := positions[old_spot].Clone() ; non-redundant
  sleep 50
  UpdatePosition(target)  ; <== UpdatePosition(target)
  snapshots[move_num][target] := positions[target].Clone() ; non-redundant
  sleep 50
  ID1 := positions[old_spot].piece  ; msgbox % target " ID2: " ID2 "  " spot " ID1: " ID1
  if ( ID2 == ID1 ) {  ; <=== fail check
    MsgBox, , % "FAIL", % "FAIL", % 1.5
    fail := true
  } else {
    PromotePawn(spot, piece, target)   ; <== PromotePawn(spot,piece,target)
    fail := false
  }
  return fail
}

ClickDrag(spot, target) {  ; L-Left b-board 2-Speed 0-100
;  ShowCursor()
  x1 := board[spot].x, y1 := board[spot].y
  x2 := board[target].x, y2 := board[target].y
  mousemove x1, y1, 0
  MouseClickDrag, L, x1, y1, x2, y2 + 8, 2
;  HideCursor()
}



PromotePawn(spot, piece, target) {
  if ( (my_color == "white") and (piece == "pawn") and (target contains 8) ) 
  or ( (my_color == "black") and (piece == "pawn") and (target contains 1) ) {
    GoSpot(spot), sleep 50
    mouseclick Left    ;  Promotion  choose queen
    sleep 50
    UpdatePosition(spot)
  }
}

MoveMouse(x, y, speed=0) {
;  mousemove x, y, speed
}
GoSpot(spot) {
  MoveMouse(board[spot].x, board[spot].y)
}
ClickSpot(spot) {
  MoveMouse(board[spot].x, board[spot].y)
  Click
}

MoveClick(x, y) {
  mousemove x, y
  Click
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


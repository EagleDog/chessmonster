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
    MsgBox, , % "FAIL", % "FAIL", % 0.5
    fail := true
  } else {
    PromotePawn(old_spot, piece, target)   ; <== PromotePawn(spot,piece,target)
    fail := false
    UndoPreMove(old_spot, target)
  }
  return fail
}

redtest(){
  red1 := 0x4361B5
  red2 := 0x7F8BEE
  x1 := 440
  y1 := 410
  x2 := x1 + 3
  y2 := y1 - 3
  if ( CheckColorCoords(x1, y1, x2, y2, red1)
  or CheckColorCoords(x1, y1, x2, y2, red2) ) {
    msgbox red
  }
}

UndoPreMove(spot, target) {
  red1 := 0x4361B5
  red2 := 0x7F8BEE
  x1 := board[spot].x + 38
  y1 := board[spot].y - 38
  x2 := x1 + 3
  y2 := y1 - 3
  red_check_1 := CheckColorCoords(x1, y1, x2, y2, red1)
  red_check_2 := CheckColorCoords(x1, y1, x2, y2, red2)
  ; msgbox % x1 ", " y1 "  red1: " red_check_1 "  red2: " red_check_2
  if ( CheckColorCoords(x1, y1, x2, y2, red1)
  or CheckColorCoords(x1, y1, x2, y2, red2) ) {
    sleep 200
    mouseclick right
    sleep 200
    DidSquareChange(spot, positions[spot].color)
    DidSquareChange(target, positions[target].color)
  }
}

ClickDrag(spot, target) {  ; L-Left b-board 2-Speed 0-100
;  ShowCursor()
  x1 := board[spot].x, y1 := board[spot].y
  x2 := board[target].x, y2 := board[target].y
  mousemove x1, y1, 0
  MouseClickDrag, L, x1, y1, x2, y2 + 5, 3
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
  half_moves += 1
  LogMoves(move_num)
  UpdateSnapshots()
}

DecreaseMoveNum() {
  move_num -= 1
  LogMoves(move_num)
  UpdateSnapshots()
}


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
;     PromotePawn(old_spot, piece, target)
;

global fail := false

MovePiece(spot, target) {
  fail := MoveAndFailCheck(spot, target)
  if fail {
    UpdateSnapshots()
  } else {
    PromotePawn(spot, piece, target)   ; <== PromotePawn(spot,piece,target)
    UndoPreMove(spot, target)
    UpdateHalfMoves(spot)
    IncreaseMoveNum()   ; <== UpdateSnapshots() included
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
    ; MsgBox, , % "FAIL", % "FAIL", % 0.5
    fail := true
  } else {
    fail := false
  }
  return fail
}

RedTest(){
  red1 := 0x4361B5
  red2 := 0x7F8BEE
  x1 := 140
  y1 := 250
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
  click x1 y1 left down
;  mouseclick left, x1, y1, , , D
  mousemove x2, y2, 3
  sleep 50
  click x2 y2 left up

;  MouseClickDrag, L, x1, y1, x2, y2 + 5, 3
;  HideCursor()
}

PromotePawn(old_spot, piece, target) {
  if ( (my_color == "white") and (piece == "pawn") and (target contains 8) ) 
  or ( (my_color == "black") and (piece == "pawn") and (target contains 1) ) {
    GoSpot(target), sleep 50
    mouseclick Left    ;  Promotion  choose queen
    sleep 50
    UpdatePosition(old_spot)
    UpdatePosition(target)
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
  UpdateCastleRightsAll()
  ; LogMoves(move_num)
}

IncreaseMoveNum() {
  move_num += 1
  UpdateCastleRightsAll()
  ; LogMoves(move_num)
  UpdateSnapshots()
}

DecreaseMoveNum() {
  move_num -= 1
  UpdateCastleRightsAll()
  ; LogMoves(move_num)
  UpdateSnapshots()
}


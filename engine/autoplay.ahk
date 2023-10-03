;autoplay.ahk
;
;




;
;           GO LOOP           GO LOOP           GO LOOP
;
GoLoop() {                   ; GoLoop() main chessmonster loop
LogField1("GoLoop()")
Chill()
  paused := false
  ActivateChess()
  loop {
    UpdateSnapshots()  ; <== UpdateSnapshots()
    spot := ChooseSquare()
    spot_color := SqStat(spot)
;    spot_color := UpdatePosition(spot)

    spot := FindMyGuys(spot, spot_color)    ; return spot   ( color = my_color )

    piece_type := positions[spot].piece  ;       <<============
    UseSpecificPiece() ; does nothing, for testing piece movements
    target := MoveWhichPiece(spot, piece_type)

    if target {
      MovePiece(spot, target)  ; from move_maker.ahk
      if !fail {
        PromotePawn(spot, piece_type, target)
        PollOpp()
      }
    }
;      Listen()
;      PollZone(zones["zone_1"])
    if (paused = true) {
      PauseDisplay()
      break
    }
  }
}
;
;------------------------------------------------------------------------

UseSpecificPiece() { ; for testing piece movements
  ; if ( (piece_type != "bishop") ) {
  ;   TryMove()
  ; }
}

MoveWhichPiece(spot, piece_type) {
  switch piece_type {
    case "pawn": target := MovePawn(spot)
    case "knight": target := MoveKnight(spot)
    case "bishop": target := MoveBishop(spot)
    case "rook": target := MoveRook(spot)
    case "queen": target := MoveQueen(spot)
    case "king": target := MoveKing(spot)
  }
  return target
}

FindMyGuys(spot, spot_color) {
  while (spot_color != my_color) {   ; find my guys
    piece := positions[spot].piece
    spot := ChooseSquare()
    spot_color := SqStat(spot)
;    spot_color := UpdatePosition(spot)
    GoSpot(spot)
  }
  return spot
}

ChooseSquare() {
  LogField2("ChooseSquare()")
  if fail {    ; fail from move_maker.ahk
    fail := false
    spot := FailChoose()
  } else if ( RandomChoice() ) {
    spot := ChooseMySpots()
  } else {
    spot := RandomSquare()
    LogField2("ChooseSquare() " . spot . " rand square")
    Chill()
  }
  return spot
}

FailChoose() {
  LogField2("FailChoose()")
  if RandomChoice(3) {      ; 1:3 odds move my_spots
    spot := ChooseMySpots()
  } else {
    spot := WhereIsMyKing() ; 2:3 odds move king
  }
  return spot
}

ChooseMySpots() {
    LogField2( "ChooseMySpots()" )
    my_spots := GetMySpots()
    length_my_spots := my_spots.length()
    Random, spot_num, 1, length_my_spots
    spot := my_spots[spot_num]
    return spot
}

RandomSquare() {
  random, col, 1, 8
  random, rank, 1, 8
  file := Chr(96 + col)   ; file > a-h
  spot := file . rank
  return spot
}


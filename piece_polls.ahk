;piece_polls.ahk
; HowManyPieces()


global last_spot := "a6"
global last_piece := "empty"
global prev_opp_pieces_spots := {}


DoNothing() {
  nothing := "nothing"
  return nothing
}

FindOppPieces() {  ; from prev snapshot
  snapshot := snapshots[move_num - 2]
  opp_pieces := {}
  pawns := [], knights := [], bishops := [], rooks := [], queens := [], kings := []
  loop 64 {
    spot := all_spots[n]   ; all_spots is global array
    snapspot := snapshot[spot]
    n := A_Index + 1
    if ( (snapspotspot.color == opp_color) and (snapspot.piece == "pawns") ) {
      pawns.push(spot)
    }
    if ( (snapspotspot.color == opp_color) and (snapspot.piece == "knight") ) {
      knights.push(spot)
    }
    if ( (snapspotspot.color == opp_color) and (snapspot.piece == "bishop") ) {
      bishops.push(spot)
    }
    if ( (snapspotspot.color == opp_color) and (snapspot.piece == "rook") ) {
      rooks.push(spot)
    }
    if ( (snapspotspot.color == opp_color) and (snapspot.piece == "queen") ) {
      queens.push(spot)
    }
    if ( (snapspotspot.color == opp_color) and (snapspot.piece == "king") ) {
      kings.push(spot)
    }
  }
  opp_pieces := { pawns: pawns, knights: knights, bishops: bishops, rooks: rooks, queens: queens, kings: kings }
  return opp_pieces
}

SameSpotCheck(spot) {
  ; was piece here previous move?
  ; ... but ... what if it got missed?...
}

CheckAntecedents(spot, piece) {
;  opp_pieces := FindOppPieces()
;  first check for change in color, else...
  switch piece {
    case "empty":
      DoNothing()
    case "pawn":
      if ( board[spot].rank < 7 ) {
        CheckPawnAntecedents(spot)
      }
    case "knight":
      CheckKnightAntecedents(spot)
    case "bishop":
      CheckBishopAntecedents(spot)
    case "rook":
      CheckRookAntecedents(spot)
    case "queen":
      CheckQueenAntecedents(spot)
    case "king":
      CheckKingAntecedents(spot)
  }
}

  ; if ( ( piece == "pawn" ) and ( board[spot].rank < 7 ) ) {
  ;   CheckPawnAntecedents(spot) ;, opp_pieces["pawns"])
  ; } else if ( piece == "knight" ) {
  ;   CheckKnightAntecedents(spot) ;, opp_pieces["knights"])
  ; } else if ( piece == "bishop" ) {
  ;   CheckBishopAntecedents(spot) ;, opp_pieces["knights"])
  ; } else if ( piece == "rook" ) {
  ;   CheckRookAntecedents(spot) ;, opp_pieces["knights"])
  ; } else if ( piece == "queen" ) {
  ;   CheckQueenAntecedents(spot) ;, opp_pieces["knights"])
  ; } else if ( piece == "king" ) {
  ;   CheckKingAntecedents(spot) ;, opp_pieces["knights"])
  ; }

CheckAntecedentSources(spot, sources) {
  position := positions[spot]
  spot := position.spot
  spot_col := position.col
  spot_rank := position.rank
  n := 1
  while sources[n] {
    col := spot_col + sources[n][1]
    rank := spot_rank + sources[n][2]
    n := A_Index + 1
    file := FindFile(col)
    spot := file . rank
    UpdatePosition(spot)
    GoSpot(spot)
;    Debug(spot)
  }
}

CheckPawnAntecedents(spot) { ;, pawns)
  back_one := [ 0, 1 ]
  back_two := [ 0, 2 ]
  back_diag_1 := [ 1, 1 ]
  back_diag_2 := [ -1, 1 ]
  sources := [ back_one, back_diag_1, back_diag_2 ]
  if (board[spot].rank == 5) {
    sources.push(back_two)
  }
  CheckAntecedentSources(spot, sources)
}

CheckKnightAntecedents(spot) { ;, knights)
  jump_1 := [ 1, 2 ]
  jump_2 := [ 2, 1 ]
  jump_3 := [ 2, -1 ]
  jump_4 := [ 1, -2 ]
  jump_5 := [ -1, -2 ]
  jump_6 := [ -2, -1 ]
  jump_7 := [ -2, 1 ]
  jump_8 := [ -1, 2 ]
  sources := [ jump_1, jump_2, jump_3, jump_4, jump_5, jump_6, jump_7, jump_8 ]
  CheckAntecedentSources(spot, sources)
}

CheckBishopAntecedents(spot) {
  up_left_1 := [ -1, -1 ]
  up_left_2 := [ -2, -2 ]
  up_right_1 := [ 1, -1 ]
  up_right_2 := [ 2, -2 ]
  down_right_1 := [ 1, 1 ]
  down_right_2 := [ 2, 2 ]
  down_left_1 := [ -1, 1 ]
  down_left_2 := [ -2, 2 ]
  sources :=  [ up_left_1, up_left_2, up_right_1, up_right_2, down_right_1, down_right_2, down_left_1, down_left_2 ]
  CheckAntecedentSources(spot, sources)
}
CheckRookAntecedents(spot) {
  left_1 := [ -1, 0 ]
  left_2 := [ -2, 0 ]
  up_1 := [ 0, -1 ]
  up_2 := [ 0, -2 ]
  right_1 := [ 1, 0 ]
  right_2 := [ 2, 0 ]
  down_1 := [ 0, 1 ]
  down_2 := [ 0, 2 ]
  sources := [ left_1, left_2, up_1, up_2, right_1, right_2, down_1, down_2 ]
  CheckAntecedentSources(spot, sources)
}
CheckQueenAntecedents(spot) {
  up_left_1 := [ -1, -1 ]
  up_left_2 := [ -2, -2 ]
  up_right_1 := [ 1, -1 ]
  up_right_2 := [ 2, -2 ]
  down_right_1 := [ 1, 1 ]
  down_right_2 := [ 2, 2 ]
  down_left_1 := [ -1, 1 ]
  down_left_2 := [ -2, 2 ]
  left_1 := [ -1, 0 ]
  left_2 := [ -2, 0 ]
  up_1 := [ 0, -1 ]
  up_2 := [ 0, -2 ]
  right_1 := [ 1, 0 ]
  right_2 := [ 2, 0 ]
  down_1 := [ 0, 1 ]
  down_2 := [ 0, 2 ]
  sources :=  [up_left_1,up_left_2,up_right_1,up_right_2,down_right_1,down_right_2,down_left_1,down_left_2,left_1,left_2,up_1,up_2,right_1,right_2,down_1,down_2]
  CheckAntecedentSources(spot, sources)
}
CheckKingAntecedents(spot) {
  up_left_1 := [ -1, -1 ]
  up_right_1 := [ 1, -1 ]
  down_right_1 := [ 1, 1 ]
  down_left_1 := [ -1, 1 ]
  left_1 := [ -1, 0 ]
  up_1 := [ 0, -1 ]
  right_1 := [ 1, 0 ]
  down_1 := [ 0, 1 ]
  sources :=  [ up_left_1, up_right_1, down_right_1, down_left_1, left_1, up_1, right_1, down_1 ]
  CheckAntecedentSources(spot, sources)
}


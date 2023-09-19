;antecedents_watcher.ahk
;
; DoNothing()
; FindOppPieces()
; DidSquareChange()
; Antecedents
; Antecedents
; Antecedents

;global last_spot := "a6"
;global last_piece := "empty"
;global prev_opp_pieces_spots := {}

DidSquareChange(spot) {
  if ( move_num == 1 ) {
    return
  }
  sleep 50
  position := positions[spot]
  snapshot := snapshots[move_num - 1] ;[move_num - 1]
  snap_spot := snapshot[spot]
  piece := position.piece
  color := position.color
  abbr := position.abbr
  prev_piece := snap_spot.piece
  prev_color := snap_spot.color
  prev_abbr := snap_spot.abbr
  if ( ( prev_piece == piece ) and ( prev_color == color ) ) {
    return false
  } else {
    GoSpot(spot)
    return true
;    known problem: loops with null snap_spot. Why??
;    snap_spot := { piece: piece, color: color, abbr: abbr } ; non-redundant
;    LogDebug(prev_color " " prev_piece ", " color " " piece)
  }
}

RunAntecedentsEngine(spot, antecedents) {
  position := positions[spot]
;  spot := position.spot
  spot_col := position.col
  spot_rank := position.rank
  n := 1
  while antecedents[n] {
    col := spot_col + antecedents[n][1]
    rank := spot_rank + antecedents[n][2]
    n := A_Index + 1
    file := FindFile(col)
    spot := file . rank
    UpdatePosition(spot)
    GoSpot(spot)
;    Debug(spot)
  }
}

CheckAntecedents(spot) {
;  first check DidSquareChange(), else...
  LogMain("CheckAntecedents( " . spot . " )")
  piece := positions[spot].piece
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

CheckPawnAntecedents(spot) { ;, pawns)
  back_one := [ 0, 1 ]
  back_two := [ 0, 2 ]
  back_diag_1 := [ 1, 1 ]
  back_diag_2 := [ -1, 1 ]
  antecedents := [ back_one, back_diag_1, back_diag_2 ]
  if (board[spot].rank == 5) {
    antecedents.push(back_two)
  }
  RunAntecedentsEngine(spot, antecedents)
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
  antecedents := [ jump_1, jump_2, jump_3, jump_4, jump_5, jump_6, jump_7, jump_8 ]
  RunAntecedentsEngine(spot, antecedents)
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
  antecedents :=  [ up_left_1, up_left_2, up_right_1, up_right_2, down_right_1, down_right_2, down_left_1, down_left_2 ]
  RunAntecedentsEngine(spot, antecedents)
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
  antecedents := [ left_1, left_2, up_1, up_2, right_1, right_2, down_1, down_2 ]
  RunAntecedentsEngine(spot, antecedents)
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
  antecedents :=  [up_left_1,up_left_2,up_right_1,up_right_2,down_right_1,down_right_2,down_left_1,down_left_2,left_1,left_2,up_1,up_2,right_1,right_2,down_1,down_2]
  RunAntecedentsEngine(spot, antecedents)
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
  antecedents :=  [ up_left_1, up_right_1, down_right_1, down_left_1, left_1, up_1, right_1, down_1 ]
  RunAntecedentsEngine(spot, antecedents)
}


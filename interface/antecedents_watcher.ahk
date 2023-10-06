;antecedents_watcher.ahk
;
; DoNothing()
; FindOppPieces()
; DidSquareChange()
; Antecedents
; Antecedents
; Antecedents

DidSquareChange(spot, color) {  ; returns true or false
  snapshot := snapshots[move_num]
  snap_spot := snapshot[spot]
  prev_piece := snap_spot.piece
  prev_color := snap_spot.color
  if ( prev_color == color ) {
    return false
  }
  UpdatePosition(spot)   ;  <== UpdatePosition(spot)
  position := positions[spot]
  piece := position.piece
  if ( prev_piece == piece ) {
    return false  ; square is same
  } else {  ; square changed
    return true
  }
}

CheckAntecedents(spot) {
  LogField2("CheckAntecedents( " . spot . " )")
  piece := positions[spot].piece
  hybrid_color := positions[spot].color
  switch piece {
    case "empty":
      hybrid_color := CheckDescendents(spot)
;      msgbox empty square
    case "pawn": CheckPawnSuccessors(spot)
    case "knight": CheckKnightAntecedents(spot)
    case "bishop": SearchSuccessors(spot, bishop_patterns)
    case "rook": SearchSuccessors(spot, rook_patterns)
    case "queen": SearchSuccessors(spot, queen_patterns)
    case "king": CheckKingAntecedents(spot)
  }
  CheckOppCastling(spot)
  snapshots[move_num][spot] := positions[spot].Clone() ; non-redundant
;  msgbox % spot "  return h_color: " hybrid_color
  return hybrid_color
}

RunAntecedentsEngine(spot, antecedents) {
  position := positions[spot]
  spot_col := position.col
  spot_rank := position.rank
  n := 1
  while antecedents[n] {
    col := spot_col + antecedents[n][1]
    rank := spot_rank + antecedents[n][2]
    file := ColToFile(col)
    spot := file . rank

    UpdatePosition(spot) ; ImageSearch not needed on all squares?
    GoSpot(spot)
    n := A_Index + 1
  }
}

CheckPawnAntecedents(spot) {   ; pawn
  back_one := [ 0, 1 ]
  back_two := [ 0, 2 ]
  back_diag_1 := [ 1, 1 ]
  back_diag_2 := [ -1, 1 ]
  antecedents := [ back_one, back_two, back_diag_1, back_diag_2 ]
  ; if (board[spot].rank == 5) {
  ;   antecedents.push(back_two)
  ; }
  RunAntecedentsEngine(spot, antecedents)
}

CheckKnightAntecedents(spot) {  ; knight
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

CheckBishopAntecedents(spot) {  ; bishop
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
CheckRookAntecedents(spot) {  ; rook
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
CheckQueenAntecedents(spot) {  ; queen
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
CheckKingAntecedents(spot) {  ; king
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



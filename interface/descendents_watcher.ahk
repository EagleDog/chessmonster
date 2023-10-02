;descnedents_watcher.ahk
;
;  STEP 1 -- rook, bishop, queen
;  STEP 2 -- antecedents
;  STEP 3 -- empty (descendents)
;  STEP 4 -- pawn, knight, king
;  STEP 5 -- refine
;

go_up :=      [  0, -1 ]
go_right :=   [  1,  0 ]
go_down :=    [  0,  1 ]
go_left :=    [ -1,  0 ]

up_left :=    [ -1, -1 ]
up_right :=   [  1, -1 ]
down_right := [  1,  1 ]
down_left :=  [ -1,  1 ]

global rook_patterns := [go_up, go_right, go_down, go_left]
global bishop_patterns := [up_left, up_right, down_right, down_left]
global queen_patterns := CombineArrays(rook_patterns, bishop_patterns)

CheckDescendents(spot) { 
LogField3("CheckDescendents( " spot " )")
  prev_piece := snapshots[move_num][spot].piece
  prev_color := snapshots[move_num][spot].color
  piece := positions[spot].piece
  move_patterns := AssignMovePatterns(spot, prev_piece)
  SearchSuccessors(spot, move_patterns)
  ; CheckOppCastling(spot, piece, prev_piece)
  return prev_color
}

AssignMovePatterns(spot, prev_piece) {
  switch prev_piece {
    case "empty": DoNothing()
    case "pawn": CheckPawnSuccessors(spot)
    case "knight": CheckKnightAntecedents(spot)
    case "bishop": move_patterns := bishop_patterns
    case "rook": move_patterns := rook_patterns
    case "queen": move_patterns := queen_patterns
    case "king": CheckKingAntecedents(spot)
  }
  return move_patterns
}

SearchSuccessors(spot, move_patterns) {
  position := positions[spot]
  spot_col := position.col
  spot_row := position.row
  piece := "empty"
  color := "empty"
  n := 1
  while move_patterns[n] {
    row := spot_row
    col := spot_col
    while ( ( row < 9 ) and ( col < 9 ) and ( row > 0 ) and ( col > 0 ) ) {
      row := row + move_patterns[n][2]
      col := col + move_patterns[n][1]
      file := ColToFile(col)
      rank := row
      spot := file . rank
      GoSpot(spot)
      color := SqStat(spot)
      if DidSquareChange(spot, color) {
        snapshots[move_num][spot] := positions[spot].Clone() ; non-redundant
      }
      if ( color == opp_color ) {
        break
      }
    }
    n := A_Index + 1
  }
}

CheckPawnDescendents(spot) {   ; pawn
  forward_one := [ 0, -1 ]
  forward_two := [ 0, -2 ]
  forward_diag_1 := [ 1, -1 ]
  forward_diag_2 := [ -1, -1 ]
  descendents := [ forward_one, forward_two, forward_diag_1, forward_diag_2 ]
  ; if (board[spot].rank == 7) {
  ;   descendents.push(forward_two)
  ; }
  RunAntecedentsEngine(spot, descendents)
}

CheckPawnSuccessors(spot) {
  CheckPawnAntecedents(spot)
  CheckPawnDescendents(spot)
}


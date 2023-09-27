;piece_mover.ahk
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


ExtendMovePatterns(spot) {
  position := positions[spot]
  while (row < 8) {
    n := A_Index
    GenericMovePatternSequence(spot, n, move_pattern)
  }
}


AssignMovePatterns(piece, prev_piece) {
  if ( piece == "rook" ) {
    move_patterns := rook_patterns
  } else if ( piece == "bishop" ) {
    move_patterns := bishop_patterns
  } else if ( piece == "queen" ) {
    move_patterns := CombineArrays(rook_patterns, bishop_patterns)
  }
}




PredecessorSequence(spot, n, move_pattern) {
  position := positions[spot]
  piece := position.piece
  col := position.col
  row := position.row

  while ( row < 8 ) and ( col < 8 ) and ( row > 1 ) and ( col > 1 )
      and ( ( piece == "empty" ) or ( color != opp_color ) ) {

    col += move_pattern[1]
    row += move_pattern[2]
    file := FindFile(col)
    rank := row
    spot := file . rank
    color := SqStat(spot)
    GoSpot(spot)
    if ( DidSquareChange(spot) ) {
      UpdatePosition(spot)
    }
  }
}




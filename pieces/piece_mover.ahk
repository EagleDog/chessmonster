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

CheckDescendents(spot) { ; LogMain("CheckDescendents( " . spot . " )")
  ; snapshot := snapshots[move_num]
  ; snap_spot := snapshot[spot]
  ; prev_piece := snap_spot.piece
  prev_piece := snapshots[move_num][spot].piece
  move_patterns := AssignMovePatterns(prev_piece)
;  msgbox % move_patterns[1][1] " - moooove"
  SearchSuccessors(spot, move_patterns)
}


AssignMovePatterns(prev_piece) {
  msgbox % prev_piece " -- prev_piece"
  switch prev_piece {
    case "empty": DoNothing()
    case "pawn": DoNothing()
    case "knight": DoNothing()
    case "bishop": move_patterns := bishop_patterns
    case "rook": move_patterns := rook_patterns
    case "queen": move_patterns := CombineArrays(rook_patterns, bishop_patterns)
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

        fileappend % "__n:__" n "__  ", *

        while ( ( row < 9 ) and ( col < 9 ) and ( row > 0 ) and ( col > 0 ) ) {

            row := row + move_patterns[n][2]
            col := col + move_patterns[n][1]
            file := ColToFile(col)
            rank := row
            spot := file . rank

            fileappend % "row: " row " ", *
            fileappend % "col: " col "   ", *
            fileappend % "spot: " spot "   ", *

            GoSpot(spot)
            color := SqStat(spot)
            if DidSquareChange(spot, color) {
                msgbox % "piece: " positions[spot].piece
                snapshots[move_num][spot] := positions[spot].Clone() ; non-redundant
            }
            if ( color == opp_color ) {
                break
            }
        }
        n := A_Index + 1
    }
}




; SearchDependents(spot, move_patterns) {
;   position := positions[spot]
;   spot_col := position.col
;   spot_row := position.row
;   piece := "empty"
;   color := "empty"

;   fileappend % "spot: " spot " ", *

;   n := 1
;   while move_patterns[n] {
; ;    move_pattern := move_patterns[n]

; ;    nn := 1
;     row := spot_row
;     col := spot_col


; ;    msgbox % "n: " n

; ;    if ( row < 8 )
; ;    msgbox % "piece - " piece "`n row - "  row "`n col - " col ""
; ;    msgbox % col " - col"

;     while ( ( row < 9 ) and ( col < 9 ) and ( row > 0 ) and ( col > 0 )
;         and ( ( piece == "empty" ) or ( color != opp_color ) ) ) {

;       ; msgbox % "nn: " nn
;       fileappend % "spot: " spot " ", *
;       fileappend % "row: " row " ", *
;       fileappend % "move_patterns[n][1]: " move_patterns[n][1] " ", *
;       fileappend % "move_patterns[n][2]: " move_patterns[n][2] " ", *

;       col := col + move_patterns[n][1]
;       row := row + move_patterns[n][2]
;       file := ColToFile(col)
;       rank := row
;       spot := file . rank
;       color := SqStat(spot)

;       GoSpot(spot)
;       msgbox % "spot: " spot " " color
;       fileappend % "n: " n "  spot: " spot " ", *

; ;       if ( DidSquareChange(spot, color) ) {
; ;         snapshots[move_num][spot] := positions[spot].Clone() ; non-redundant
; ; ;        UpdatePosition(spot)
; ;         return true

; ;       } else {

;       piece := position.piece
;       n := A_Index + 1
; ;      }

;     nn := A_Index + 1
;     }
;   }
; }


CheckPredecessors(spot) {
  position := positions[spot]
  piece := position.piece
}




;positions_class.ahk
;
;
; #Include positions_watcher.ahk
; #Include positions_poller.ahk
; #Include chess_gui.ahk
; #Include board_watcher.ahk

#Include chessmonster.ahk


class PositionsSet {
  __New() {
  ;  positions := {}
    positions_set := MakeEmptyPositionsSet()
    empty_row_abbrs := [".",".",".",".",".",".",".","."]
    e := empty_row_abbrs
    abbrs := [e,e,e,e,e,e,e,e]
    PopulateRows(abbrs)
    OutputPositions()
    LogMain("new positions set")
  }
}

PopulateRows(abbrs) {
  loop, 8 {
    row := A_Index
    color := "empty"
    GenericColumnsLoop(row, color, abbrs)
  }  
}

MakeEmptyPositionsSet() {
  positions_set := {}
  Loop, 8 {
    rank := A_Index
    row := rank
    Loop, 8 {
      col := A_Index
      file := Chr(96 + col)     ; a_index > a-h
      spot := file . rank
      positions_set[spot] := {spot: spot, col: col, file: file, row: row, rank: rank, piece: "empty", color: "blank", p_abbr: "- " }
    }

    text_rows[A_index] := p_text
    p_text := ""
  }
}


class Place {
  col := 1
  file := "a"
  row := 1
  rank := 1
  spot := ""
  color := "white"
  piece := "rook"
  p_abbr := "R "
}


;0::positions_1 := new PositionsSet()





; class PositionsSet {
;   white_row_abbrs := ["R", "N", "B", "Q", "K", "B", "N", "R"]
;   pawn_row_abbrs := ["p", "p", "p", "p", "p", "p", "p", "p"]
;   black_row_abbrs := ["R", "N", "B", "K", "Q", "B", "N", "R"]
;   wh := white_row_abbrs
;   p := pawn_row_abbrs
;   bl := black_row_abbrs
; ;    abbrs := empty_row_abbrs

;   __New() {
;   positions := {}
;   empty_row_abbrs := [".", ".", ".", ".", ".", ".", ".", "."]
;   e := empty_row_abbrs
;     abbrs := [e,e,e,e,e,e,e,e]
;     ; if (my_color = "white") {
;     ;   abbrs := [wh, p, e, e, e, e, p, wh]
;     ; } else {
;     ;   abbrs := [bl, p, e, e, e, e, p, bl]
;     ; }
;     PopulateRows(abbrs)
;     OutputPositions()
;     LogMain("new positions set")
;   }
; }


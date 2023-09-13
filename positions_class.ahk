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
    empty_row_abbrs := [".", ".", ".", ".", ".", ".", ".", "."]
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


0::positions_1 := new PositionsSet()





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


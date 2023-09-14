;positions_history.ahk
;
;

global positions_history := []

ResetPositionsHistory() {
  positions_history := []
}

UpdatePositionsHistory() {
;  GetTempPositions()
  

  positions_history.push(positions)

}

GetTempPositions() {
;  positions_set := new(PositionsSet)
  Loop, 8 {
    rank := A_Index
    row := rank
    Loop, 8 {
      col := A_Index
      file := Chr(96 + col)     ; a_index > a-h
      spot := file . rank
      p_abbr := positions[spot].p_abbr
      piece := 
    }

    text_rows[A_index] := p_text
    p_text := ""
  }

  LogPositions(p_text)

  num_pieces_both := HowManyPieces()
  num_pieces_opp := num_pieces_both[2]
  num_pieces_mine := num_pieces_both[1]
  LogOppTitle( opp_color . "  " . num_pieces_opp . " pieces" )
  LogMyTitle( my_color . "  " . num_pieces_mine . " pieces" )
}

GetPositionsHistory0(move_number=1) {
  positions := positions_history[move_number]
  OutputPositions()
  msgbox % positions_history[move_number]["d3"].color
}


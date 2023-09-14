;snapshots.ahk
;
;

global snapshots := []

ResetSnapshots() {
  snapshots := []
}

UpdateSnapshots() {
  GetSnapshot()
;  positions_history.push(positions)
}

GetSnapshot() {
  snapshots[move_num] := {}
  snapshot := snapshots[move_num]
  Loop, 8 {
    rank := A_Index
    row := rank
    Loop, 8 {
      col := A_Index
      file := Chr(96 + col)     ; a_index > a-h
      spot := file . rank
      color := positions[spot].color
      piece := positions[spot].piece
      p_abbr := positions[spot].p_abbr
      snapshot[spot] := { spot: spot, piece: piece, color: color, p_abbr: p_abbr, col: col, file: file, row: row, rank: rank } ; , x: x, y: y
    }
  }
  snapshot["num_pieces_opp"] := positions["num_pieces_opp"]
  snapshot["num_pieces_mine"] := positions["num_pieces_mine"]
}

OutputSnapshot(move_number) {
  snapshot := snapshots[move_number]
  p_text := ""
  p_abbr := ""
  text_rows := ["","","","","","","",""]
  Loop, 8 {
    rank := A_Index
    row := rank
    Loop, 8 {
      col := A_Index
      file := Chr(96 + col)     ; a_index > a-h
      spot := file . rank
      p_abbr := snapshot[spot].p_abbr
      p_text := % "" . p_text . p_abbr . " "
    }
    text_rows[A_index] := p_text
    p_text := ""
  }
  p_text := "`n" . text_rows[8] . "`n" . text_rows[7] . "`n" . text_rows[6] . "`n" . text_rows[5] . "`n" . text_rows[4] . "`n" . text_rows[3] . "`n" . text_rows[2] . "`n" . text_rows[1] . "`n"

  LogPositions(p_text)
  num_pieces_opp := snapshot["num_pieces_opp"]
  num_pieces_mine := snapshot["num_pieces_mine"]
  LogOppTitle( opp_color . "  " . num_pieces_opp . " pieces" )
  LogMyTitle( my_color . "  " . num_pieces_mine . " pieces" )
  LogMoves(move_number)
}


DebugSnapshots() {
  n := 1
  while (snapshots[n]) {
    n := A_Index
    snapshot := snapshots[n]
    p_text := ""
    p_abbr := ""
    text_rows := ["","","","","","","",""]
    Loop, 8 {
      rank := A_Index
      row := rank
      Loop, 8 {
        col := A_Index
        file := Chr(96 + col)     ; a_index > a-h
        spot := file . rank
        p_abbr := snapshot[spot].p_abbr
        p_text := % "" . p_text . p_abbr . " "
      }
      text_rows[A_index] := p_text
      p_text := ""
    }
    p_text := "`n" . text_rows[8] . "`n" . text_rows[7] . "`n" . text_rows[6] . "`n" . text_rows[5] . "`n" . text_rows[4] . "`n" . text_rows[3] . "`n" . text_rows[2] . "`n" . text_rows[1] . "`n"
    num_pieces_opp := snapshot["num_pieces_opp"]
    num_pieces_mine := snapshot["num_pieces_mine"]
    Debug("move_num: " . n)
    Debug(p_text)
    Debug( opp_color . "  " . num_pieces_opp . " pieces" )
    Debug( my_color . "  " . num_pieces_mine . " pieces" )
  }
}

















GetPositionsHistory0(move_number=1) {
  positions := positions_history[move_number]
  OutputPositions()
  msgbox % positions_history[move_number]["d3"].color
}


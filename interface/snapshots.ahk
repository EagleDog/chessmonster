;snapshots.ahk
;
;

global snapshots := []

ResetSnapshots() {
  snapshots := []
  UpdateSnapshots()
}

UpdateSnapshots() {
  CreateSnapshot()
}

CreateSnapshot() {
  snapshots[move_num] := positions.Clone()
}

OutputSnapshot() {
  snapshot := snapshots[move_num] ;[move_num - 1]
  pos_text := ""
  abbr := ""
  text_rows := ["","","","","","","",""]
  Loop, 8 {
    rank := A_Index
    row := rank
    Loop, 8 {
      col := A_Index
      file := Chr(96 + col)     ; a_index > a-h
      spot := file . rank
      abbr := snapshot[spot].abbr
      pos_text := % "" . pos_text . abbr . " "
    }
    text_rows[A_index] := pos_text
    pos_text := ""
  }
  pos_text := "`n" . text_rows[8] . "`n" . text_rows[7] . "`n" . text_rows[6] . "`n" . text_rows[5] . "`n" . text_rows[4] . "`n" . text_rows[3] . "`n" . text_rows[2] . "`n" . text_rows[1] . "`n"

  LogPositions(pos_text)
  num_pieces_opp := snapshot["num_pieces_opp"]
  num_pieces_mine := snapshot["num_pieces_mine"]
  snap_move_num := snapshot["move_number"]
  LogOppTitle( opp_color . "  " . num_pieces_opp . " pieces" )
  LogMyTitle( my_color . "  " . num_pieces_mine . " pieces" )
  LogMoves(snap_move_num)
}

DebugSnapshots() {
  n := 1
  while (snapshots[n]) {
    snapshot := snapshots[n]
    n := A_Index
;    n := A_Index + 1
    pos_text := ""
    abbr := ""
    text_rows := ["","","","","","","",""]
    Loop, 8 {
      rank := A_Index
      row := rank
      Loop, 8 {
        col := A_Index
        file := Chr(96 + col)     ; a_index > a-h
        spot := file . rank
        abbr := snapshot[spot].abbr
        pos_text := % "" . pos_text . abbr . " "
      }
      text_rows[A_index] := pos_text
      pos_text := ""
    }
    pos_text := "`n" . text_rows[8] . "`n" . text_rows[7] . "`n" . text_rows[6] . "`n" . text_rows[5] . "`n" . text_rows[4] . "`n" . text_rows[3] . "`n" . text_rows[2] . "`n" . text_rows[1] . "`n"
    num_pieces_opp := snapshot["num_pieces_opp"]
    num_pieces_mine := snapshot["num_pieces_mine"]
    Debug("move_num: " . n)
    Debug(pos_text)
    Debug( opp_color . "  " . num_pieces_opp . " pieces" )
    Debug( my_color . "  " . num_pieces_mine . " pieces" )
  }
}

; GetSnapshot() {   ; deprecated by clone in CreateSnapshot()
;   snapshots[move_num] := {}
;   snapshot := snapshots[move_num]
;   Loop, 8 {
;     rank := A_Index
;     row := rank
;     Loop, 8 {
;       col := A_Index
;       file := Chr(96 + col)     ; a_index > a-h
;       spot := file . rank
;       color := positions[spot].color
;       piece := positions[spot].piece
;       abbr := positions[spot].abbr
;       snapshot[spot] := { spot: spot, piece: piece, color: color, abbr: abbr, col: col, file: file, row: row, rank: rank }
;     }
;   }
;   snapshot["num_pieces_opp"] := positions["num_pieces_opp"]
;   snapshot["num_pieces_mine"] := positions["num_pieces_mine"]
; }


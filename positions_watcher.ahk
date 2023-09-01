;positions_watcher.ahk
; UpdatePosition(spot)
; GetPositions()
; OutputPositions()
; GetAbbr(piece)

global positions := {}
global p := positions

UpdatePosition(spot) {
  color := SquareStatus(spot)
  piece := IDPiece(spot, color)
  p_abbr := GetAbbr(piece)
  if (color = "black") {
    p_abbr := p_abbr . "*"
  } else {
    p_abbr := p_abbr . " "
  }
  positions[spot] := { spot: spot, piece: piece, color: color, p_abbr: p_abbr }
;  MsgBox, % "spot: " . spot . " p_abbr: " . p_abbr . " color: " . color . ""
  OutputPositions()
  p := positions
}
UpdateTwoPositions(spot, target) {
  Sleep, 10
  UpdatePosition(target)
  Sleep, 50
  UpdatePosition(spot)
  Sleep, 10
  ; OutputPositions()
  ; Sleep, 10
}

GetPositions() {
  LogMain("Getting positions.....")
  ; gui_text := "Getting positions....."
  ; GuiControl,, gui_output, % gui_text
  piece := ""
  spot_color := ""
  p_abbr := ""
  Loop, 8 {       ; ranks (rows)
    rank := A_Index
    row := rank
    Loop, 8 {     ; files (columns)
      col := A_Index
      file := Chr(96 + col)     ; a_index > a-h
      spot := file . rank
      spot_color := SquareStatus(spot)
      piece := IDPiece(spot, spot_color)  ; <<==========   <<======
      p_abbr := GetAbbr(piece)
      if (spot_color = "black") {
        p_abbr := p_abbr . "*"
      } else {
        p_abbr := p_abbr . " "
      }
      positions[spot] := { spot: spot, piece: piece, color: spot_color, p_abbr: p_abbr } ; , x: x, y: y, rank: rank, file: file, col: col }
    }
  }
  p := positions
  OutputPositions()
  LogMain(" ")
}

OutputPositions() {
  p := positions  ; {positions}
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
      p_abbr := p[spot].p_abbr
      p_text := % "" . p_text . p_abbr . " "
    }
    text_rows[A_index] := p_text
    p_text := ""
  }
  p_text := "`n" . text_rows[8] . "`n" . text_rows[7] . "`n" . text_rows[6] . "`n" . text_rows[5] . "`n" . text_rows[4] . "`n" . text_rows[3] . "`n" . text_rows[2] . "`n" . text_rows[1] . "`n"

  LogPositions(p_text)
  ; gui_text := p_text
  ; GuiControl,, gui_output, % p_text
}


GetAbbr(piece) {
  switch piece {
    case "empty":
      p_abbr := "."
    case "pawn":
      p_abbr := "p"
    case "knight":
      p_abbr := "N"
    case "bishop":
      p_abbr := "B"
    case "rook":
      p_abbr := "R"
    case "queen":
      p_abbr := "Q"
    case "king":
      p_abbr := "K"
    default:
      p_abbr := "`"
  }
  return p_abbr
}

GetStartingPositions() {
  LogMain("Get Starting positions.....")
  ; gui_text := "Getting positions....."
  ; GuiControl,, gui_output, % gui_text
  row1 := [R, N, B, Q, K, B, N, R]

  if (my_color = "white") {
    piece := ""
    spot_color := ""
    p_abbr := ""
    rank := 1
    row := rank
    Loop, 8 {     ; files (columns)
      col := A_Index
      file := Chr(96 + col)     ; a_index > a-h
      spot := file . rank
      spot_color := "white"
      piece := IDPiece(spot, spot_color)  ; <<==========   <<======
      p_abbr := GetAbbr(piece)
      if (spot_color = "black") {
        p_abbr := p_abbr . "*"
      } else {
        p_abbr := p_abbr . " "
      }
      positions[spot] := { spot: spot, piece: piece, color: spot_color, p_abbr: p_abbr } ; , x: x, y: y, rank: rank, file: file, col: col }
    }

  }

  p := positions
  OutputPositions()
}




;positions_watcher.ahk
; UpdatePosition(spot)
; GetPositions()
; OutputPositions()
; GetAbbr(piece)

global positions := {}

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
  OutputPositions()
  LogMain(" ")
}

OutputPositions() {
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
      p_abbr := positions[spot].p_abbr
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
GetFullName(abbr) {
  switch abbr {
    case ".":
      fullname := "empty"
    case "p":
      fullname := "pawn"
    case "N":
      fullname := "knight"
    case "B":
      fullname := "bishop"
    case "R":
      fullname := "rook"
    case "Q":
      fullname := "queen"
    case "K":
      fullname := "king"
    default:
      fullname := "`"
  }
  return fullname
}


GetStartingPositions() {
  LogMain("Get Starting positions.....")
  white_row_abbrs := ["R", "N", "B", "Q", "K", "B", "N", "R"]
  pawn_row_abbrs := ["p", "p", "p", "p", "p", "p", "p", "p"]
  empty_row_abbrs := [".", ".", ".", ".", ".", ".", ".", "."]
  black_row_abbrs := ["R", "N", "B", "K", "Q", "B", "N", "R"]
  wh := white_row_abbrs
  p := pawn_row_abbrs
  e := empty_row_abbrs
  bl := black_row_abbrs
  if (my_color = "white") {
    abbrs := [wh, p, e, e, e, e, p, wh]
  } else {
    abbrs := [bl, p, e, e, e, e, p, bl]
  }

  loop, 2 {     ; bottom 2 rows
    row := A_Index
    color := my_color
    GenericColumnsLoop(row, color, abbrs)
  }
  loop, 2 {     ; top 2 rows
    row := A_Index + 6
    color := opp_color
    GenericColumnsLoop(row, color, abbrs)
  }
  loop, 4 {     ; empty rows
    row := A_Index + 2
    color := "empty"
    GenericColumnsLoop(row, color, abbrs)
  }
  OutputPositions()
  LogMain("Begin Match")
}


GenericColumnsLoop(row, color, abbrs) {
  loop, 8 {       ; columns
    col := A_Index
    file := Chr(96 + col)
    row := row
    rank := row
    spot := file . rank
    p_abbr := abbrs[row][col]
    piece := GetFullName(p_abbr)
    if (color = "black") {
      p_abbr := p_abbr . "*"
    } else {
      p_abbr := p_abbr . " "
    }
    positions[spot] := { spot: spot, piece: piece, color: color, p_abbr: p_abbr }
  }
}






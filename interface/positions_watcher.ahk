;positions_watcher.ahk
; UpdatePosition(spot)
; GetPositions()
; OutputPositions()
; GetAbbr(piece)
;
;  piece_types := ["empty","pawn","knight","bishop","rook","queen","king"]
;
global prev_positions := {}  ; deprecated ???
global positions := {}
global my_spots := []
global opp_spots := []


;------------------------------------------------------------------
;                                                  UPDATE POSITION
UpdatePosition(spot) {  ; LogMain("UpdatePosition()")
;  if DidSquareChange(spot) {}
  color := SquareStatus(spot)
  piece := IDPiece(spot, color)
  abbr := GetAbbr(piece, color)
  position := positions[spot]
  col := position.col
  file := position.file
  row := position.row
  rank := position.rank
  positions[spot] := { spot: spot, piece: piece, color: color, abbr: abbr, col: col, file: file, row: row, rank: rank }
  ; if ( color != my_color ) {  ; Don't check my antecedents
  ;    if DidSquareChange(spot) {
  ;     CheckAntecedents(spot)   ; <<== WEIRD LOOP CAUSE
  ;   }
  ; }
  OutputPositions()
  LogMain0("                  " . spot . "  " . abbr . "")
  return color
}
;
;------------------------------------------------------------------
;                                                 OUTPUT POSITIONS
OutputPositions() {
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
      abbr := positions[spot].abbr
      pos_text := % "" . pos_text . abbr . " "
    }
    text_rows[A_index] := pos_text
    pos_text := ""
  }
  pos_text := "`n" . text_rows[8] . "`n" . text_rows[7] . "`n" . text_rows[6] . "`n" . text_rows[5] . "`n" . text_rows[4] . "`n" . text_rows[3] . "`n" . text_rows[2] . "`n" . text_rows[1] . "`n"

  LogPositions(pos_text)

  num_pieces_both := HowManyPieces()
  num_pieces_opp := num_pieces_both[1]
  num_pieces_mine := num_pieces_both[2]
  LogOppTitle( opp_color . "  " . num_pieces_opp . " pieces" )
  LogMyTitle( my_color . "  " . num_pieces_mine . " pieces" )
  LogMoves(move_num)

  positions["num_pieces_opp"] := num_pieces_opp
  positions["num_pieces_mine"] := num_pieces_mine
  positions["move_number"] := move_num

  UpdateSnapshots()

  DidCastlersMove()    ; <== DidCastlersMove()
}
;
;-------------------------------------------------------
;                                          GET POSITIONS
GetPositions(speed="fast") {
  LogMain("Getting positions.....")
  piece := ""
  color := ""
  abbr := ""
  Loop, 8 {       ; ranks (rows)
    rank := A_Index
    row := rank
    Loop, 8 {     ; files (columns)
      col := A_Index
      file := ColToFile(col)  ; a-h
      spot := file . rank
      color := SqStat(spot)
      GoSpot(spot)
      if ( speed == "fast" ) {
        DidSquareChange(spot, color)       ; <== UpdatePosition(spot)
      } else {
        UpdatePosition(spot)
      }
      piece := positions[spot].piece
      abbr := GetAbbr(piece, color)
      positions[spot] := { spot: spot, piece: piece, color: color, abbr: abbr, col: col, file: file, row: row, rank: rank } ; , x: x, y: y
    }
  }
  UpdateSnapshots()
  OutputPositions()
}
;
;------------------------------------------------------------------
;                                           GET STARTING POSITIONS
GetStartingPositions() {
LogMain0("GetStartingPositions()")
  GetMyColor()
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
    abbrs := [wh, p, e, e, e, e, p, wh]
    ; abbrs := [bl, p, e, e, e, e, p, bl]
  }

  loop, 2 {     ; bottom 2 rows
    row := A_Index
    color := "white"
    ; color := my_color
    GenericColumnsLoop(row, color, abbrs)
  }
  loop, 2 {     ; top 2 rows
    row := A_Index + 6
    color := "black"
    ; color := opp_color
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
    abbr := abbrs[row][col]
    abbr := AddAbbrBlack(abbr, color)
    piece := GetFullName(abbr)
    positions[spot] := { spot: spot, piece: piece, color: color, abbr: abbr, col: col, file: file, row: row, rank: rank }
  }
}

AddAbbrBlack(abbr, color) {
  if (color = "black") {
    abbr := abbr . "*"
  } else {
    abbr := abbr . " "
  }
  return abbr
}

GetAbbr(piece, color) {
  switch piece {
    case "empty":
      abbr := "."
    case "pawn":
      abbr := "p"
    case "knight":
      abbr := "N"
    case "bishop":
      abbr := "B"
    case "rook":
      abbr := "R"
    case "queen":
      abbr := "Q"
    case "king":
      abbr := "K"
    default:
      abbr := "`"
  }
  abbr := AddAbbrBlack(abbr, color)
  return abbr
}
GetFullName(abbr) {
  abbr := SubStr(abbr, 1, 1)
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


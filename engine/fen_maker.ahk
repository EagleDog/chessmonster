;fen_maker.ahk
;
;   still needs whose turn, castling rights, en passant target,
;   half-move clock for fifty move rule, full moves completed
;

global positions := {}
global fishlog := A_ScriptDir . "\fishlog.txt"
global empty_squares_num := 0

FishlogRefresh()
GetStartingPositions()


FishlogRefresh() {
  filedelete % fishlog
  fileappend fishlog `n , % fishlog
}

FenLog(output_text) {
  fileappend % output_text "`n", % fishlog
}

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

  FenLog(pos_text)
  ; LogPositions(pos_text)

  ; num_pieces_both := HowManyPieces()
  ; num_pieces_opp := num_pieces_both[1]
  ; num_pieces_mine := num_pieces_both[2]
  ; LogOppTitle( opp_color . "  " . num_pieces_opp . " pieces" )
  ; LogMyTitle( my_color . "  " . num_pieces_mine . " pieces" )
  ; LogMoves(move_num)

  ; positions["num_pieces_opp"] := num_pieces_opp
  ; positions["num_pieces_mine"] := num_pieces_mine
  ; positions["move_number"] := move_num
}

GetStartingPositions() {
FenLog("GetStartingPositions()")
;Chill()
;  GetMyColor()
  my_color := "white"
  opp_color := "black"
  FenLog("Get Starting positions.....")
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
  OutputFen()
;  OutputPositions()
  FenLog("Begin Match")
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

OutputFen() {
  fen_text := ""
  abbr := ""
  text_rows := ["","","","","","","",""]
  Loop, 8 {
    rank := A_Index
    row := rank
    empty_squares_num := 0
    Loop, 8 {
      col := A_Index
      file := Chr(96 + col)     ; a_index > a-h
      spot := file . rank
      abbr := positions[spot].abbr


      abbr := GetFenAbbr(abbr)
      abbr := EmptySquareCounter(abbr)

      fen_text := % "" . fen_text . abbr . ""
    }
    if ( empty_squares_num != 0 ) {
      fen_text := fen_text . empty_squares_num
    }
    if ( A_index != 1 ) {
      fen_text := fen_text . "/"
    }
    text_rows[A_index] := fen_text

    fen_text := ""
  }
  fen_text := text_rows[8] text_rows[7] text_rows[6] text_rows[5] text_rows[4] text_rows[3] text_rows[2] text_rows[1]

  FenLog(fen_text)
}



EmptySquareCounter(abbr) {
  if ( abbr == " " ) {
    empty_squares_num += 1
    return ""
;    return empty_squares_num
  } else {
    empty_num := empty_squares_num
    empty_squares_num := 0
;    msgbox % abbr
    if ( empty_num != 0 ) {
      abbr := empty_num . abbr
    }
    return abbr
  }
}

GetFenAbbr(abbr) {
;  abbr := SubStr(abbr, 1, 1)
  ; if ( abbr is integer ) {
  ;   return abbr
  ; } else {
    switch abbr {
      case "p ": fenabbr := "P"
      case "N ": fenabbr := "N"
      case "B ": fenabbr := "B"
      case "R ": fenabbr := "R"
      case "Q ": fenabbr := "Q"
      case "K ": fenabbr := "K"

      case ". ": fenabbr := " "

      case "p*": fenabbr := "p"
      case "N*": fenabbr := "n"
      case "B*": fenabbr := "b"
      case "R*": fenabbr := "r"
      case "Q*": fenabbr := "q"
      case "K*": fenabbr := "k"

      case 1: fenabbr := "1"
      case 2: fenabbr := "2"
      case 3: fenabbr := "3"
      case 4: fenabbr := "4"
      case 5: fenabbr := "5"
      case 6: fenabbr := "6"
      case 7: fenabbr := "7"
      case 8: fenabbr := "8"

      default: fenabbr := "-"
    }
  return fenabbr
  }
;}

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


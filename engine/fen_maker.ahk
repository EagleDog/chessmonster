;fen_maker.ahk
;
;   still needs en passant target and
;   half-move clock for fifty move rule
;

global empty_squares_num := 0

FenLog(output_text) {
  fileappend % output_text "`n", % fishlog
}

CreateFen() {
  fen_text := ""
  abbr := ""
  text_rows := ["","","","","","","",""]
  Loop, 8 {
    rank := A_Index
    row := rank
    empty_squares_num := 0
    Loop, 8 {
      col := A_Index
      file := ColToFile(col)     ; => a-h
      spot := file . rank
      abbr := positions[spot].abbr
      abbr := GetFenAbbr(abbr)   ; calls GetFenAbbr(abbr)
      abbr := EmptySquareCounter(abbr)  ; calls EmptySquareCounter(abbr)
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
  ; fen_index := " " my_color_abbr " " c_rights_all " " en_passant "  0 " . move_num
  fen_index := " " my_color_abbr " " c_rights_all " - 0 " . move_num
  ; fen_index := " " my_color_abbr " KQkq - 0 " . move_num
  fen_text := fen_text . fen_index

  FenLog(fen_text)
  Print(fen_text)
  return fen_text
}

EmptySquareCounter(abbr) {
  if ( abbr == " " ) {
    empty_squares_num += 1
    return ""
;    return empty_squares_num
  } else {
    empty_num := empty_squares_num
    empty_squares_num := 0
    if ( empty_num != 0 ) {
      abbr := empty_num . abbr
    }
    return abbr
  }
}

GetFenAbbr(abbr) {
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

    default: fenabbr := "-"
  }
return fenabbr
}


;castling.ahk
;
; includes en passant and half-move counter
;

global c_rights_1 := "K"
global c_rights_2 := "Q"
global c_rights_3 := "k"
global c_rights_4 := "q"
global c_rights_all := "KQkq"

global en_passant := "-"
global half_moves := 0

CheckOppEnPassant(spot) {
  file := SubStr(spot, 1, 1)
  row := SubStr(spot, 2, 1)
  piece := positions[spot].piece
  color := positions[spot].color

  ; if ( piece == "pawn") {
  ;   ResetHalfMoves()

  if ( ( row == 4 ) or ( row == 5 ) ) {
    if ( row == 4 ) {
      ant_row := 2
    } else {
      ant_row := 7
    }
    ant_spot := file . ant_row
    ant_piece := snapshots[move_num][ant_spot].piece
    ant_color := snapshots[move_num][ant_spot].color

    if ( ( ant_piece == "pawn" ) and ( ant_color == color ) ) {
      GoSpot(spot)
      msgbox, , en passant, % "en passant: " spot, 0.5
                       ; . "`n" "ant_piece: " ant_piece
                       ; . "`n" "ant_color: " ant_color, 1
      en_passant := spot
    } else {
      ; msgbox, , NON passant, % "NON passant: " spot
      ;                   . "`n" "ant_piece: " ant_piece
      ;                   . "`n" "ant_color: " ant_color, 1
      en_passant := "-"
    }
  }

  ; } else {
  ;   IncreaseHalfMoves()
  ;   en_passant := "-"
  ; }
}

CheckMyEnPassant(bestmove) {
  file1 := SubStr(bestmove, 1, 1)
  row1 := SubStr(bestmove, 2, 1)
  file2 := SubStr(bestmove, 3, 1)
  row2 := SubStr(bestmove, 4, 1)
  spot := file2 . row2
  piece := positions[spot].piece
  if ( piece == "pawn") {
    ResetHalfMoves()
    if ( ( my_color == "black" )
    and ( row2 == 5 ) and ( row1 == 7) ) {
      ; msgbox, , en passant, % "en passant: " spot, 1
      ResetHalfMoves()
      en_passant := spot
    } else if ( ( my_color == "white" ) and ( piece == "pawn" )
    and ( row2 == 4 ) and ( row1 == 2) ) {
      ; msgbox, , en passant, % "en passant: " spot, 1
      ResetHalfMoves()
      en_passant := spot
    } else {
      IncreaseHalfMoves()
      en_passant := "-"
    }
  } else {
    IncreaseHalfMoves()
    en_passant := "-"
  }
}

ResetHalfMoves() {
  half_moves := 0
}

IncreaseHalfMoves() {
  half_moves += 1
}

ResetEnPassant() {
  en_passant := "-"
}

CheckMyCastling(bestmove) { ; also check if piece is king?
  if ( ( bestmove == "e8g8" )
  or   ( bestmove == "e8c8" ) ) {
    SearchCastleZoneBlack()
  } else if ( ( bestmove == "e1g1" )
         or   ( bestmove == "e1c1" ) ) {
    SearchCastleZoneWhite()
  }
}

CheckOppCastling(spot) {  ; need to check empties as well
  piece := positions[spot].piece
  prev_piece := snapshots[move_num][spot].piece
  if ( opp_color == "black" ) {
    ; msgbox, , castling BLACK, % "spot: " spot "`npiece: " piece "`nprev_piece: " prev_piece, 4
    if ( ( spot == "a8" ) and ( prev_piece == "rook" ) )
    or ( ( spot == "c8" ) and ( piece == "king" ) )
    or ( ( spot == "d8" ) and ( piece == "rook" ) )
    or ( ( spot == "e8" ) and ( prev_piece == "king" ) )
    or ( ( spot == "f8" ) and ( piece == "rook" ) )
    or ( ( spot == "g8" ) and ( piece == "king" ) )
    or ( ( spot == "h8" ) and ( prev_piece == "rook" ) ) {
      SearchCastleZoneBlack()
    }
  } else {
    ; msgbox, , castling WHITE, % "spot: " spot "`npiece: " piece "`nprev_piece: " prev_piece, 4
    if ( ( spot == "a1" ) and ( prev_piece == "rook" ) )
    or ( ( spot == "c1" ) and ( piece == "king" ) )
    or ( ( spot == "d1" ) and ( piece == "rook" ) )
    or ( ( spot == "e1" ) and ( prev_piece == "king" ) )
    or ( ( spot == "f1" ) and ( piece == "rook" ) )
    or ( ( spot == "g1" ) and ( piece == "king" ) )
    or ( ( spot == "h1" ) and ( prev_piece == "rook" ) ) {
      SearchCastleZoneWhite()
    }
  }
}

SearchCastleZoneBlack() {
  castle_zone_black := ["a8","b8","c8","d8","e8","f8","g8","h8"]
  SearchCastleZone(castle_zone_black)
}

SearchCastleZoneWhite() {
  castle_zone_white := ["a1","b1","c1","d1","e1","f1","g1","h1"]
  SearchCastleZone(castle_zone_white)
}

SearchCastleZone(castle_zone) {
  n := 1 
  while castle_zone[n] {
    spot := castle_zone[n]
    color := SqStat(spot)
    DidSquareChange(spot, color) ; <== UpdatePosition()
    GoSpot(spot)
    n := A_Index + 1
  }  
}

UpdateCastleRightsAll() {
  c_rights_all := "" . c_rights_1 . c_rights_2 . c_rights_3 . c_rights_4
  if ( c_rights_all == "" ) {
    c_rights_all := "-"
  }
  LogCastle(c_rights_all " " en_passant " " half_moves)
}

ResetCastleRights() {
  c_rights_1 := "K"
  c_rights_2 := "Q"
  c_rights_3 := "k"
  c_rights_4 := "q"
  UpdateCastleRightsAll()
}

DidCastlersMove() {
  ; check positions a1, e1, h1, a8, e8, h8 (d1/d8?)
  if ( positions["a1"].piece != "rook" ) {
    c_rights_2 := ""
  }
  if ( positions["h1"].piece != "rook" ) {
    c_rights_1 := ""
  }
  if ( positions["e1"].piece != "king" ) {
    c_rights_1 := ""
    c_rights_2 := ""
  }
  if ( positions["a8"].piece != "rook" ) {
    c_rights_4 := ""
  }
  if ( positions["h8"].piece != "rook" ) {
    c_rights_3 := ""
  }
  if ( positions["e8"].piece != "king" ) {
    c_rights_3 := ""
    c_rights_4 := ""
  }
  UpdateCastleRightsAll()
}


; CastleRights1() {  ; white king
;   if ( c_rights_1 == "K" ) {
;     c_rights_1 := ""
;   } else {
;     c_rights_1 := "K"
;   }
;   UpdateCastleRightsAll()
; }

; CastleRights2() {  ; white queen
;   if ( c_rights_2 == "Q" ) {
;     c_rights_2 := ""
;   } else {
;     c_rights_2 := "Q"
;   }
;   UpdateCastleRightsAll()
; }

; CastleRights3() {  ; black king
;   if ( c_rights_3 == "k" ) {
;     c_rights_3 := ""
;   } else {
;     c_rights_3 := "k"
;   }
;   UpdateCastleRightsAll()
; }

; CastleRights4() {  ; black queen
;   if ( c_rights_4 == "q" ) {
;     c_rights_4 := ""
;   } else {
;     c_rights_4 := "q"
;   }
;   UpdateCastleRightsAll()
; }

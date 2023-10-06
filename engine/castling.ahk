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

EnPassantEligibility(spot) {
  file := SubStr(spot, 1, 1)
  row := SubStr(spot, 1, 2)
  piece := positions[spot].piece
  if ( piece == "pawn") {
    if ( ( row == 4 ) or ( row == 5 ) ) {
      if ( row == 4 ) {
        ant_row := 2
      } else {
        ant_row := 7
      }
    }
    ant_spot := file . ant_row
    ant_piece := snapshots[move_num][ant_spot].piece
    if ( ant_piece == "pawn" ) {
      msgbox % "en passant eligible: " spot
      return spot
    } else {
      return "-"
    }
  }
}

CheckMyCastling(bestmove) { ; also check if piece is king?
  if ( ( bestmove == "e8g8" )
  or   ( bestmove == "e8b8" ) ) {
    SearchCastleZoneBlack()
  } else if ( ( bestmove == "e1g1" )
         or   ( bestmove == "e1b1" ) ) {
    SearchCastleZoneWhite()
  }
}

CheckOppCastling(spot) {
  piece := positions[spot].piece
  prev_piece := snapshots[move_num][spot].piece
  if opp_color == "black" {
    if ( ( spot == "a8" ) and ( prev_piece == "rook" ) )
    or ( ( spot == "b8" ) and ( piece == "king" ) )
    or ( ( spot == "c8" ) and ( piece == "rook" ) )
    or ( ( spot == "e8" ) and ( prev_piece == "king" ) )
    or ( ( spot == "f8" ) and ( piece == "rook" ) )
    or ( ( spot == "g8" ) and ( piece == "king" ) )
    or ( ( spot == "h8" ) and ( prev_piece == "rook" ) ) {
      SearchCastleZoneBlack()
    } else if ( ( spot == "a8" ) and ( prev_piece == "rook" ) )
    or ( ( spot == "b8" ) and ( piece == "king" ) )
    or ( ( spot == "c8" ) and ( piece == "rook" ) )
    or ( ( spot == "e8" ) and ( prev_piece == "king" ) )
    or ( ( spot == "f8" ) and ( piece == "rook" ) )
    or ( ( spot == "g8" ) and ( piece == "king" ) )
    or ( ( spot == "h8" ) and ( prev_piece == "rook" ) ) {
      SearchCastleZoneWhite()
  }
}

SearchCastleZoneBlack() {
  castle_zone_black := ["a8","b8","c8","e8","f8","g8","h8"]
  SearchCastleZone(castle_zone_black)
}

SearchCastleZoneWhite() {
  castle_zone_white := ["a1","b1","c1","e1","f1","g1","h1"]
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

CastleRights1() {  ; white king
  if ( c_rights_1 == "K" ) {
    c_rights_1 := ""
  } else {
    c_rights_1 := "K"
  }
  UpdateCastleRightsAll()
}

CastleRights2() {  ; white queen
  if ( c_rights_2 == "Q" ) {
    c_rights_2 := ""
  } else {
    c_rights_2 := "Q"
  }
  UpdateCastleRightsAll()
}

CastleRights3() {  ; black king
  if ( c_rights_3 == "k" ) {
    c_rights_3 := ""
  } else {
    c_rights_3 := "k"
  }
  UpdateCastleRightsAll()
}

CastleRights4() {  ; black queen
  if ( c_rights_4 == "q" ) {
    c_rights_4 := ""
  } else {
    c_rights_4 := "q"
  }
  UpdateCastleRightsAll()
}

UpdateCastleRightsAll() {
  c_rights_all := "" . c_rights_1 . c_rights_2 . c_rights_3 . c_rights_4
  if ( c_rights_all == "" ) {
    c_rights_all := "-"
  }
  LogCastle(c_rights_all)
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

;castle_rights.ahk
;
;

global c_rights_1 := "K"
global c_rights_2 := "Q"
global c_rights_3 := "k"
global c_rights_4 := "q"
global c_rights_all := "KQkq"

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
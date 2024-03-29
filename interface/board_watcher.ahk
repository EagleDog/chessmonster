;board_watcher.ahk
; IDPiece(spot)
; WhichPiece(x1, y1, x2, y2)
; ImageMatches(x1, y1, x2, y2, img_path)
; SquareStatus(spot)
; SqStat(spot)
; CheckColor(spot, the_color)
; GetMyColor()
; ImageMatches(x1, y1, x2, y2, img_path)

global black := 0x525356
global white := 0xF8F8F8
global board_gr := 0x549977
global board_wh := 0xCCEDE9
global board_ylw := 0x44CCBB ;BBCC44

IDPiece(spot, spot_color) {       ;    <<==========
  x := board[spot].x
  y := board[spot].y - 30
  x1 := x - 20
  y1 := y - 35
  x2 := x + 20
  y2 := y + 10
  img_x := 0
  img_y := 0
;  Sleep, 50
;  spot_color := p_color  ;SqStat(spot)
  if ((spot_color = "empty") OR (spot_color = "not sure")) {
    MoveMouse(x, y)
    return "empty"
  } else if (spot_color = "white") {
    MoveMouse(x, y)
    return WhichPiece(x1, y1, x2, y2, "white")  ;   <<=======
  } else {
    MoveMouse(x, y)
    return WhichPiece(x1, y1, x2, y2, "black")  ;   <<=======
  }
;  return WhichPiece(x1, y1, x2, y2)
}

WhichPiece(x1, y1, x2, y2, piece_color="white") {
;  empty_images := ["e_wh.png", "e_wh.png", "e_gr.png", "e_gr.png"]
  if (piece_color = "white") {
    pawn_images := ["p_wh_wh.png", "p_wh_gr.png"]
    knight_images := ["N_wh_wh.png", "N_wh_gr.png"]
    bishop_images := ["B_wh_wh.png", "B_wh_gr.png"]
    rook_images := ["R_wh_wh.png", "R_wh_gr.png"]
    queen_images := ["Q_wh_wh.png", "Q_wh_gr.png"]
    king_images := ["K_wh_wh.png", "K_wh_gr.png"]
    piece_names := ["pawn", "knight", "bishop", "rook", "queen", "king"]
  } else {
    pawn_images := ["p_bl_wh.png", "p_bl_gr.png"]
    knight_images := ["N_bl_wh.png", "N_bl_gr.png"]
    bishop_images := ["B_bl_wh.png", "B_bl_gr.png"]
    rook_images := ["R_bl_wh.png", "R_bl_gr.png"]
    queen_images := ["Q_bl_wh.png", "Q_bl_gr.png"]
    king_images := ["K_bl_wh.png", "K_bl_gr.png"]
    piece_names := ["pawn", "knight", "bishop", "rook", "queen", "king"]
  }
  piece_images := [pawn_images, knight_images, bishop_images, rook_images, queen_images, king_images]

  piece_name := ""

  Loop, 6 {
    piece_name := piece_names[A_Index]
    image_set := piece_images[A_Index]
    Loop, 2 {
      piece_img := image_set[A_Index]
      img_path := "" assets_path . piece_img . ""
      if ( ImageMatches(x1, y1, x2, y2, img_path) ) {
        MoveMouse( x1 + 20, y1 + 35) ;, 10 )
;        MsgBox, %piece_name%
        return piece_name
      ; } else {
      ;   return "empty"
      }
    }
  }
}

ColorTest() {
  x1 := 180, y1 := 110
  x2 := 280, y2 := 180
  ; x3 := 180, y3 := 900
  ; x4 := 280, y4 := 970
  eag_path := assets_path "eag.png"
  eag2_path := assets_path "eag2.png"
  if ( ImageMatches(x1, y1, x2, y2, eag_path)
  or   ImageMatches(x1, y1, x2, y2, eag2_path) ) {
    msgbox found eag
    MyColorIsBlack()
  } else {
    msgbox not found
    ; Beep()
    MyColorIsWhite()
  }
  LogColor()
}

GetMyColor() {
  ActivateChess()
  sleep 50
  x1 := 180, y1 := 110
  x2 := 280, y2 := 180
  eag_path := assets_path "eag.png"
  eag2_path := assets_path "eag2.png"
  if ( ImageMatches(x1, y1, x2, y2, eag_path)
  or   ImageMatches(x1, y1, x2, y2, eag2_path) ) {
    MyColorIsBlack()
  } else {
    MyColorIsWhite()
  }
  LogColor()
}

LogColor() {
  StringUpper my_color_text, my_color
  LogField1(my_color_text "  my color  " my_color_text " ")
  LogMyColor(my_color_text "  my color  " my_color_text)
}

MyColorIsBlack() {
  my_color := "black"
  opp_color := "white"
  my_color_abbr := "b"
  LogColor()
}

MyColorIsWhite() {
  my_color := "white"
  opp_color := "black"
  my_color_abbr := "w"
  LogColor()
}

ImageMatches(x1, y1, x2, y2, img_path) {
  ImageSearch, img_x, img_y, x1, y1, x2, y2, *100 %img_path%
  if (img_x) {
    return true
  } else {
    return false
  }
}

SquareStatus(spot) {
  ; LogField1(spot)
  if CheckColor(spot, white) {
    sq_contains := "white"
  } else if CheckColor(spot, black) {
    sq_contains := "black"
  } else {
    sq_contains := "empty"
  }
  return sq_contains
}

SqStat(spot) {
  return SquareStatus(spot)
}

CheckColor(spot, the_color) {
  x1 := board[spot].x - 3
  y1 := board[spot].y - 3
  x2 := board[spot].x + 3
  y2 := board[spot].y + 3
  changed := CheckColorCoords(x1, y1, x2, y2, the_color)
  return changed
}

CheckColorCoords(x1, y1, x2, y2, the_color) {
  PixelSearch, found_x, found_y , x1, y1, x2, y2, the_color, 30, Fast
  if found_x {
    return true
  } else {
    return false
  } 
}

GetMyColorOld() {
  spots := ["b1","c1","d1","e1","f1","g1","h1"]
  spot := "a1"
  color := SqStat(spot)
  while ( !BlackOrWhite(color) AND spots[A_Index]) {
    n:= A_Index
    spot := spots[n]
    color := SqStat(spot)
  }
  GoSpot(spot)
  return my_color
}

BlackOrWhite(color) {
  if ( color == "white" ) {
    my_color := "white"
    opp_color := "black"
    my_color_abbr := "w"
    opening_moves := opening_moves_white
    return true
  } else if ( color == "black" ) {
    my_color := "black"
    opp_color := "white"
    my_color_abbr := "b"
    opening_moves := opening_moves_black
    return true
  } else {
    return false
  }
}

GetColor(spot) {
  x := board[spot].x
  y := board[spot].y
  PixelGetColor, spot_color, x, y
  MsgBox, % "spot_color is:  " . spot_color . ""
}

SqStatTest() {
  square_status := SqStat("e2")
  MsgBox, %square_status%
  id_test := IDPiece("f1", "black")
  MsgBox, %id_test%
}


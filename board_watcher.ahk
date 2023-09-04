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

CheckForGameEnd() {
;  three_spot := [400, 475]
  three_spot := [400, 555]
  three_image := "three.png"
  img_path := rel_path . three_image
  x := three_spot[1]
  y := three_spot[2]
  x1 := x - 25
  y1 := y - 25
  x2 := x + 25
  y2 := y + 25
;  MsgBox, % img_path
  if ImageMatches(x1, y1, x2, y2, img_path) {
    MouseMove, x, y
    Click, x, y
    Sleep, 1000
    NewGame()
  } else {
    MouseMove, x, y
  }
}

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
    MouseMove, x, y
    return "empty"
  } else if (spot_color = "white") {
    return WhichPiece(x1, y1, x2, y2, "white")  ;   <<=======
  } else {
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
      img_path := "" rel_path . piece_img . ""
      if ( ImageMatches(x1, y1, x2, y2, img_path) ) {
        MouseMove, x1 + 20, y1 + 35
;        MsgBox, %piece_name%
        return piece_name
      }
    }
  }
}

SquareStatus(spot) {
  if CheckColor(spot, white) {
    sq_contains := "white"
  } else if CheckColor(spot, black) {
    sq_contains := "black"
  } else if CheckColor(spot, board_gr) {
    sq_contains := "empty"
    ; sq_contains := "board green"
  } else if CheckColor(spot, board_wh) {
    sq_contains := "empty"
    ; sq_contains := "board light"
  } else {
    sq_contains := "not sure"
  }
;  MsgBox, % sq_contains
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
  PixelSearch, found_x, found_y , x1, y1, x2, y2, the_color, 30, Fast
  if found_x {
    return true
  } else {
    return false
  } 
}

GetMyColor() {
  if SquareStatus("a1") = "white" {
    my_color := "white"
    opp_color := "black"
  } else {
    my_color := "black"
    opp_color := "white"
  }
}

ImageMatches(x1, y1, x2, y2, img_path) {
  ImageSearch, img_x, img_y, x1, y1, x2, y2, *100 %img_path%
  if (img_x) {
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
  id_test := IDPiece("e2", "white")
  MsgBox, %id_test%
}


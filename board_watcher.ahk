;board_watcher.ahk
; SpotTest()
; IDTest()
; GetMyColor()
; IDPiece(spot)
; WhichPiece(x1, y1, x2, y2)
; ImageMatches(x1, y1, x2, y2, img_path)
; SquareStatus(spot)
; SqStat(spot)
; GetColor(spot, the_color)

global black := 0x525356
global white := 0xF8F8F8
global board_gr := 0x549977
global board_wh := 0xCCEDE9

GetMyColor() {
  if SquareStatus("a1") = "white" {
    my_color := "white"
    opp_color := "black"
  } else {
    my_color := "black"
    opp_color := "white"
  }
}

; SpotTest() {
;   x := board["a2"].x
;   y := board["a2"].y
;   MsgBox, % "" . x . "   " . y . ""
;   Output()
; }

; IDTest() {
;   x := board["a2"].x
;   y := board["a2"].y
;   MouseMove, x, y
;   MsgBox, %img_path%
;   IDPiece("a2")
; ;  MsgBox, % "" . IDPiece("a2") . ""
;   Sleep, 100
; ;  IsPawn()
; }

IDPiece(spot) {
  x := board[spot].x
  y := board[spot].y - 30
  x1 := x - 50
  y1 := y - 50
  x2 := x + 50
  y2 := y + 50
  img_x := 0
  img_y := 0
  Sleep, 50
  return WhichPiece(x1, y1, x2, y2)
}

WhichPiece(x1, y1, x2, y2) {
  pawn_images := ["p_wh_wh.png", "p_wh_gr.png", "p_bl_wh.png", "p_bl_gr.png"]
  knight_images := ["N_wh_wh.png", "N_wh_gr.png", "N_bl_wh.png", "N_bl_gr.png"]
  bishop_images := ["B_wh_wh.png", "B_wh_gr.png", "B_bl_wh.png", "B_bl_gr.png"]
  rook_images := ["R_wh_wh.png", "R_wh_gr.png", "R_bl_wh.png", "R_bl_gr.png"]
  queen_images := ["Q_wh_wh.png", "Q_wh_gr.png", "Q_bl_wh.png", "Q_bl_gr.png"]
  king_images := ["K_wh_wh.png", "K_wh_gr.png", "K_bl_wh.png", "K_bl_gr.png"]

  piece_names := ["pawn", "knight", "bishop", "rook", "queen", "king"]
  piece_images := [pawn_images, knight_images, bishop_images, rook_images, queen_images, king_images]

  Loop, 6 {
    piece_name := piece_names[A_Index]
    image_set := piece_images[A_Index]
    Loop, 4 {
      piece_img := image_set[A_Index]
      img_path := "" rel_path . piece_img . ""

      if (ImageMatches(x1, y1, x2, y2, img_path)) {
        MouseMove, x1 + 50, y1 + 50
        return piece_name
      ; } else {
      ;   MouseMove, x1 + 50, y1 + 50
      }
    }
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

SquareStatus(spot) {
  if GetColor(spot, white) {
    sq_contains := "white"
  } else if GetColor(spot, black) {
    sq_contains := "black"
  } else if GetColor(spot, board_gr) {
    sq_contains := "empty"
    ; sq_contains := "board green"
  } else if GetColor(spot, board_wh) {
    sq_contains := "empty"
    ; sq_contains := "board light"
  } else {
    sq_contains := "not sure"
  }
  return sq_contains
}
SqStat(spot) {
  return SquareStatus(spot)
}


GetColor(spot, the_color) {
  x1 := board[spot].x - 2
  y1 := board[spot].y - 2
  x2 := board[spot].x
  y2 := board[spot].y
  PixelSearch, found_x, found_y , x1, y1, x2, y2, the_color, 10, Fast
  if found_x {
    return true
  } else {
    return false
  } 
}





; GetColor(spot) {
;   x := board[spot].x
;   y := board[spot].y
;   PixelGetColor, spot_color, x, y
;   MsgBox, % "spot_color is:  " . spot_color . ""
; }

; CheckColor(spot, the_color, color_name) {
;   x1 := board[spot].x - 2
;   y1 := board[spot].y - 2
;   x2 := board[spot].x
;   y2 := board[spot].y

;   PixelSearch, color_x, color_y , x1, y1, x2, y2, the_color, 10, Fast
;   MouseMove, x2, y2
;   If color_x {
;     MsgBox, %color_name%
;   } Else {
;     MsgBox, Not %color_name%
;   }
; ;  GetColor(spot)
; }





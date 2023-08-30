;board_watcher.ahk
; GetMyColor()
; GetPositions()
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

global positions := {}
global p := positions

GetMyColor() {
  if SquareStatus("a1") = "white" {
    my_color := "white"
    opp_color := "black"
  } else {
    my_color := "black"
    opp_color := "white"
  }
}

GetPositions() {
;  MsgBox, Begin GetPositions().
  p_text := ""
  p_abbr := ""
  piece := ""
  text_rows := ["","","","","","","",""]
  Loop, 8 {       ; Ranks (rows)
    rank := A_Index
    row := rank
    Loop, 8 {     ; Files (columns)
      column := A_Index
      file := Chr(96 + column)     ; a_index > a-h
      spot := file . rank

      x := (column - 1) * sq_width + x_start
      y := (row - 1) * sq_height + y_start
      piece := IDPiece(spot)
      
      positions[spot] := { piece: piece, x: x, y: y, rank: rank, file: file, column: column }
      p_abbr := GetAbbr(piece)
;      MsgBox, %p_abbr%
      p_text := % "" . p_text . p_abbr . " "
    }
  text_rows[A_index] := p_text
;  MsgBox, % "" . text_rows[A_index] . ""
  p_text := ""
  }
  p := positions
  p_text := "`n" . text_rows[8] . "`n" . text_rows[7] . "`n" . text_rows[6] . "`n" . text_rows[5] . "`n" . text_rows[4] . "`n" . text_rows[3] . "`n" . text_rows[2] . "`n" . text_rows[1] . "`n"

  ; MsgBox, %p_text%
  ; MsgBox, I have gotten the positions.

  gui_text := p_text
  GuiControl,, gui_output, % p_text

  return
}

GetAbbr(piece) {
  switch piece {
    case "empty":
      p_abbr := ". "
    case "pawn":
      p_abbr := "p "
    case "knight":
      p_abbr := "N "
    case "bishop":
      p_abbr := "B "
    case "rook":
      p_abbr := "R "
    case "queen":
      p_abbr := "Q "
    case "king":
      p_abbr := "K "
    default:
      p_abbr := "`"
  }
  return p_abbr
}



IDPiece(spot) {
  x := board[spot].x
  y := board[spot].y - 30
  x1 := x - 20
  y1 := y - 35
  x2 := x + 20
  y2 := y + 10
  img_x := 0
  img_y := 0
;  Sleep, 50
  spot_color := SqStat(spot)
  if ((spot_color = "empty") OR (spot_color = "not sure")) {
    MouseMove, x, y
    return "empty"
  } else if (spot_color = "white") {
    return WhichPiece(x1, y1, x2, y2, "white")
  } else {
    return WhichPiece(x1, y1, x2, y2, "black")
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

      if (ImageMatches(x1, y1, x2, y2, img_path)) {
        MouseMove, x1 + 20, y1 + 35
;        MsgBox, %piece_name%
        return piece_name
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





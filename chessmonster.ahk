;ChessMonster
;resolution: HP second screen
;browser zoom: 80%
;board_scope := "147, 205  to  849, 908" ;(702 x 761 )
;square_size := "87 by 95"  ;87 x 87

;#Include VA.ahk

#Include piece_moves.ahk

global rel_path := "" . A_ScriptDir . "\assets\"
;global img_path := %rel_path%p_wh_wh.png

;  global img_path := "" . rel_path . "p_wh_wh.png"


; Exit
; Pause On

global board := {}

global x_start := 195
global y_start := 880
global sq_width := 87
global sq_height := -88


global black := 0x525356
global white := 0xF8F8F8
global board_gr := 0x549977
global board_wh := 0xCCEDE9

move1 := ["e2", "e4"] ; e pawn
move2 := ["g1", "f3"] ; g Nnight
move3 := ["f1", "c4"] ; f Bishop (light)
move4 := ["d2", "d3"] ; d pawn
move5 := ["b1", "c3"] ; b Nnight
move6 := ["c1", "e3"] ; c Bishop (dark)
move7 := ["e1", "h1"] ; O-O
move8 := ["d1", "d2"] ; d Queen
move9 := ["a2", "a3"] ; a pawn
move10 := ["c4", "b3"] ; f bishop (light)


global moves := [move1, move2, move3, move4, move5, move6, move7, move8, move9, move10]
global next_move := 1

global my_color := "white"
global opp_color := "black"


; MAIN LOOP =====================      MAIN LOOP      MAIN LOOP

;make_new_position()
CreateBoard()
;GetMyColor()
;Output()

SpotTest() {
  x := board["a2"].x
  y := board["a2"].y
  MsgBox, % "" . x . "   " . y . ""
  Output()
}

IDTest() {
  x := board["a2"].x
  y := board["a2"].y
  MouseMove, x, y
  MsgBox, %img_path%
  IDPiece("a2")
;  MsgBox, % "" . IDPiece("a2") . ""
  Sleep, 100
;  IsPawn()

}

FindMyGuys() {
  source := RandomSquare()   ;source is a spot
  ; if (SquareStatus(source) = my_color) {
  ; } else {
    while (SquareStatus(source) != my_color) {
      sleep, 50
      MouseMove, board[source].x, board[source].y
;      MsgBox, % "Source: " . source . "  ID: " . SquareStatus(source) . "   my_color: " . my_color . ""
      sleep, 50
      source := RandomSquare()
    }
    sleep, 50
    guy_spot := source
    MouseMove, board[source].x, board[source].y
    MsgBox, % "Found my guy.  Source: " . source . "  ID: " . SquareStatus(source) . "   my_color: " . my_color . ""

    MsgBox, % "" . IDPiece(guy_spot) . ""

;  }
}

TryMove() {
  Sleep, 10
  source := RandomSquare()
  while (SquareStatus(source) != my_color) {   ; find my guys
    sleep, 10
    ; MsgBox, % "Source: " . source . " SquareStatus source:  " . SquareStatus(source) . "   my_color:  " . my_color . ""
    MouseMove, board[source].x, board[source].y
    sleep, 10
    source := RandomSquare()
  }
  sleep, 10
  guy_spot := source        ; found my guy
  MouseMove, board[guy_spot].x, board[guy_spot].y
  piece_type := IDPiece(guy_spot)
  MsgBox, % "" . piece_type . ""  ; piece_type

  if (piece_type = "pawn") {
    target := FindMove(guy_spot, piece_type)
    MovePiece(guy_spot, target)
  }

;  target := RandomSquare()
  ; while (SquareStatus(target) = my_color) {
  ;   target := RandomSquare()
  ; }
  ; x1 := board[source].x
  ; y1 := board[source].y
  ; x2 := board[target].x
  ; y2 := board[target].y
  ;        ; Left button, x1, y1, x2, y2 [, speed 0-100, relative]
  ; MouseClickDrag, Left, x1, y1, x2, y2, 3
  Sleep, 10
}

FindMove(spot, piece_type) {      ; "e3", "pawn"
  source_rank := board[spot].rank
  source_column := board[spot].column
  source_file := board[spot].file

  target_rank := source_rank + 1
  target_column := source_column
  target_file := Chr(96 + target_column)  ; num > a-h

  target_spot := "" . target_file . target_rank . ""

  MsgBox %target_spot%
  MovePawn1("e3")
  return target_spot
}

PawnMove1() {
  
}


MovePiece(source, target) {
  MouseMove, board[source].x, board[source].y
  Click, Down
  MouseMove, board[target].x, board[target].y
  Click, Up
}

DriftMouse() {
  Random, x, 0, 80
  Random, y, 0, 80  
  Random, speed, 1, 7 
  MouseMove, x - 40, y - 40, speed, Relative
}

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
  pawn_images := ["p_wh_wh.png", "p_wh_gr.png", "p_bl_wh.png", "p_wh_gr.png"]
  knight_images := ["N_wh_wh.png", "N_wh_gr.png", "N_bl_wh.png", "N_wh_gr.png"]
  bishop_images := ["B_wh_wh.png", "B_wh_gr.png", "B_bl_wh.png", "B_wh_gr.png"]
  rook_images := ["R_wh_wh.png", "R_wh_gr.png", "R_bl_wh.png", "R_wh_gr.png"]
  queen_images := ["Q_wh_wh.png", "Q_wh_gr.png", "Q_bl_wh.png", "Q_wh_gr.png"]
  king_images := ["K_wh_wh.png", "K_wh_gr.png", "K_bl_wh.png", "K_wh_gr.png"]

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







MakeMove() {
  if (next_move >= 11) {
    TryMove()
    ; MsgBox, No more moves.
    ; next_move := 1
  } else {
    MovePiece(moves[next_move].1, moves[next_move].2)
    ; MsgBox, % " the_move: " . moves[next_move].1 . "  " . moves[next_move].2 . ""
    next_move += 1
  }
}


ChooseMove() {
  MsgBox, % RandomSquare()
}

RandomSquare() {
  Random, rank, 1, 8
  Random, file, 1, 8
;  rank := rand_num1
  file := Chr(96 + file)   ; file > a-h
  spot := file . rank
  return spot
}



CreateBoard() {             ; populate with x y coords 64 squares

  Loop, 8 {       ; Ranks (rows)
    rank := A_Index
    row := rank
    Loop, 8 {     ; Files (columns)
      column := A_Index
      file := Chr(96 + column)     ; a_index > a-h
      spot := file . rank

      x := (column - 1) * sq_width + x_start
      y := (row - 1) * sq_height + y_start
      
      board[spot] := {  x: x, y: y, rank: rank, file: file, column: column }
    }
  }
  return
}

NewGame() {
  next_move := 1
  GetMyColor()
  FlipBoard()
}

FlipBoard() {
  if (my_color = "white") {
    my_color := "white"
  } else {
    my_color := "black"
  }
}



Output() {
  MsgBox, % "a1:  x: " . board["a1"].x . "  y: " . board["a1"].y . ""
  MsgBox, % "a2:  x: " . board["a2"].x . "  y: " . board["a2"].y . ""
  MsgBox, % "b1:  x: " . board["b1"].x . "  y: " . board["b1"].y . ""
  MsgBox, % "b2:  x: " . board["b2"].x . "  y: " . board["b2"].y . ""
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

SquareStatus(spot) {
  if GetColor(spot, white) {
    sq_contains := "white"
  } else if GetColor(spot, black) {
    sq_contains := "black"
  } else if GetColor(spot, board_gr) {
    sq_contains := "board green"
  } else if GetColor(spot, board_wh) {
    sq_contains := "board light"
  } else {
    sq_contains := "not sure"
  }
  return sq_contains
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




;======= KEYBOARD SHORTCUTS ===================

^+z::Pause           ; ctrl + shift + z
^+x::ExitApp            ; ctrl + shift + x





1::NewGame()
2::TryMove()

3::DriftMouse()
4::FindMyGuys()


;0::SpotTest()
;0::IDTest()
;0::MsgBox, % "" . IDPiece("a2") . ""

0::FindMove("e3", "pawn")

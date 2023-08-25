;ChessMonster
;resolution: HP second screen
;browser zoom: 80%

; Exit
; Pause On

board_scope := "147, 205  to  849, 908" ;(702 x 761 )
square_size := "87 by 95"
boards_squares := [  ]

  ; global x_start
  ; global y_start
  ; global x_incr
  ; global y_incr
  ; global x_pos
  ; global y_pos
  ; global b1


global x_begin := 191
global y_begin := 861
global x_start := 191
global y_start := 861
global x_incr := 87
global y_incr := -95

global a1 := [191, 861]
global b1 := [0, 0]

global x_pos := 0
global y_pos := 0

global board := {}  ; object for square coordinates

global sq_width := 87
global sq_height := -87

; global black_piece := 0x565352
global black_piece := 0x525356
global white_piece := 0xF8F8F8
; global green_board := 0x779954
global green_board := 0x549977
; global white_board := 0xEDEDCC
global white_board := 0xCCEDE9

move1 := ["e2", "e4"]
move2 := ["b1", "c3"]
move3 := ["g1", "f3"]
move4 := ["d2", "d3"]
move5 := ["c1", "e3"]
move6 := ["f1", "e2"]
move7 := ["e1", "h1"]
move8 := ["d1", "d2"]
move9 := ["a2", "a3"]

global moves := [move1, move2, move3, move4, move5, move6, move7, move8, move9]
global the_move := 1

; MAIN LOOP =====================

;LoopTest()
;make_new_position()
CreateBoard()

;Output()


;      END MAIN LOOP ============

CreateBoard() {             ; populate with x y coords 64 squares

  Loop, 8 {       ; Ranks (rows)
    rank := A_Index
    row := rank
    Loop, 8 {     ; Files (columns)
      column := A_Index
      file := Chr(96 + column)     ; a_index > a-h
      spot := file . rank
      
      ; Calculate x and y coordinates based on square position
      x := (column - 1) * sq_width + x_start
      y := (row - 1) * sq_height + y_start
      
      ; Create an object for the square and store its coordinates
      board[spot] := { x: x, y: y }
;      MsgBox, % "board info: " . board[a1].x . ""
    }
  }
  return
}


Output() {
;  MsgBox, % "a1 info: " . a1[1] . " " . a1[2] . ""
;  MsgBox, % "b1 info: " . b1[1] . " " . b1[2] . ""
  MsgBox, % "a1:  x: " . board["a1"].x . "  y: " . board["a1"].y . ""
  MsgBox, % "b1:  x: " . board["b1"].x . "  y: " . board["b1"].y . ""
  ; MsgBox, % "board info c1:" . board["c1"].x . " " . board["c1"].y . ""
  ; MsgBox, % "board info d1:" . board["d1"].x . " " . board["d1"].y . ""

  MsgBox, % "a2:  x: " . board["a2"].x . "  y: " . board["a2"].y . ""
  MsgBox, % "b2:  x: " . board["b2"].x . "  y: " . board["b2"].y . ""
  ; MsgBox, % "board info c2:" . board["c2"].x . " " . board["c2"].y . ""
  ; MsgBox, % "board info d2:" . board["d2"].x . " " . board["d2"].y . ""
}


make_new_position() {

  x_pos := x_start + x_incr
  y_pos := y_start + y_incr
  b1 := [x_pos, y_pos]
}



; global rank := 0
; global file := 0








LoopTest() {
  Loop, 2 ; Outermost loop (z)
  {
      MsgBox, Outer Loop: %A_Index%
      
      Loop, 3 ; Outer loop (x)
      {
          MsgBox, Mid Loop: %A_Index%
          
          Loop, 4 ; Inner loop (y)
          {
              MsgBox, Inner Loop: %A_Index%
          }
      }
  }
}

MovePiece(start, finish) {
  MouseMove, board[start].x, board[start].y
  Click, Down
  MouseMove, board[finish].x, board[finish].y
  Click, Up
}

MakeMove() {
  if the_move >= 10 {
    MsgBox, No more moves.
    return
  }
  MovePiece(moves[the_move].1, moves[the_move].2)
}

GetColor(spot) {
  x := board[spot].x
  y := board[spot].y
  PixelGetColor, spot_color, x, y
  MsgBox, % "spot_color is:  " . spot_color . ""
}

CheckColor(spot, the_color, color_name) {
  x1 := board[spot].x - 2
  y1 := board[spot].y - 2
  x2 := board[spot].x
  y2 := board[spot].y

  if color_name = "green_board" or "white_board"
    variation = 60
  else
    variation = 20

  PixelSearch, color_x, color_y , x1, y1, x2, y2, the_color, 10, Fast
  MouseMove, x2, y2
  If color_x {
    MsgBox, %color_name%
  } Else {
    MsgBox, Not %color_name%
  }
;  GetColor(spot)
}








^+z::Pause           ; ctrl + shift + z
^+x::ExitApp            ; ctrl + shift + x

1::GetColor("b3")
2::GetColor("c3")
3::GetColor("d1")
4::GetColor("a6")

; 1::MovePiece("e2", "e4")
; 2::MovePiece("d2", "d3")
; 3::MovePiece("a2", "a3")
; 4::MovePiece("g1", "f3")






a::CheckColor("c7", black_piece, "black_piece")
s::CheckColor("d7", black_piece, "black_piece")
d::CheckColor("e7", black_piece, "black_piece")
f::CheckColor("f3", black_piece, "black_piece")

z::CheckColor("b3", white_piece, "white_piece")
x::CheckColor("c3", white_piece, "white_piece")
c::CheckColor("d3", white_piece, "white_piece")
v::CheckColor("d4", green_board, "green_board")
b::CheckColor("d5", white_board, "white_board")
n::CheckColor("f3", white_board, "white_board")
m::CheckColor("g3", white_board, "white_board")




Right::MakeMove()


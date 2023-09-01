;ChessMonster
;resolution: HP second screen
;browser zoom: 80%
;board_scope := "147, 205  to  849, 908" ;(702 x 761 )
;square_size := "87 by 95"  ;87 x 87

;#Include VA.ahk
#Include chess_gui.ahk
#Include board_map.ahk
#Include board_watcher.ahk
#Include mouse_mover.ahk
#Include pawn_mover.ahk
#Include knight_mover.ahk
#Include bishop_mover.ahk
#Include rook_mover.ahk
#Include queen_mover.ahk
#Include king_mover.ahk

global rel_path := "" . A_ScriptDir . "\assets\"
;global img_path := %rel_path%p_wh_wh.png
;global img_path := "" . rel_path . "p_wh_wh.png"

; Exit
; Pause On

global my_color := "white"
global opp_color := "black"
global target_status := "empty"

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



; MAIN LOOP =====================      MAIN LOOP      MAIN LOOP

if WinExist("Play Chess") {
  WinActivate, Play Chess
}
;  WinActivate, Play Chess

CreateBoard()
GetMyColor()

; sleep, 1000
; gui_text := "BBBB"
; GuiControl,, gui_output, % gui_text
; sleep, 1000
; gui_text := "CCCC"
; GuiControl,, gui_output, % gui_text



; ====== END MAIN LOOP ================    END MAIN LOOP    END MAIN LOOP


NewGame() {
  next_move := 1
  GetMyColor()
  FlipBoard()
}


;TryMove() calls RandomSquare(), SquareStatus(spot),
TryMove() {   ;  IDPiece(spot), TryMove(), MovePiece(spot, target)
  Loop {      ;  MovePawn(spot), MoveKnight(spot)
    Sleep, 10
    spot := RandomSquare()
    spot_color := SquareStatus(spot)
    while (spot_color != my_color) {   ; find my guys
;    while (SquareStatus(spot) != my_color) {   ; find my guys
      sleep, 10
      MouseMove, board[spot].x, board[spot].y
      sleep, 10
      spot := RandomSquare()
      spot_color := SquareStatus(spot)
      sleep, 10
      MouseMove, board[spot].x, board[spot].y
    }
    piece_type := IDPiece(spot, spot_color)  ;       <<============

   ; if ( (piece_type != "king") ) {
   ;  ; if ( (piece_type != "pawn") AND (piece_type != "knight")
   ;  ;     AND (piece_type != "bishop") AND (piece_type != "rook")
   ;  ;     AND (piece_type != "queen") ) {
   ;    TryMove()
   ;  }
    if (piece_type = "pawn") {
      target := MovePawn(spot)
    } else if (piece_type = "knight") {
      target := MoveKnight(spot)
    } else if (piece_type = "bishop") {
      target := MoveBishop(spot)
    } else if (piece_type = "rook") {
      target := MoveRook(spot)
    } else if (piece_type = "queen") {
      target := MoveQueen(spot)
    } else if (piece_type = "king") {
      target := MoveKing(spot)
    }
    if target {
      MovePiece(spot, target)
      if ( (piece_type = "pawn") AND (target contains 8) ) {
        Sleep, 100
        MouseClick, Left    ;  Promotion  choose queen
      }
    }
    Sleep, 10
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

RandomSquare() {
  Random, col, 1, 8
  Random, rank, 1, 8
  file := Chr(96 + col)   ; file > a-h
  spot := file . rank
  return spot
}


Output() {
  MsgBox, % "a1:  x: " . board["a1"].x . "  y: " . board["a1"].y . ""
  MsgBox, % "a2:  x: " . board["a2"].x . "  y: " . board["a2"].y . ""
  MsgBox, % "b1:  x: " . board["b1"].x . "  y: " . board["b1"].y . ""
  MsgBox, % "b2:  x: " . board["b2"].x . "  y: " . board["b2"].y . ""
}





;======= KEYBOARD SHORTCUTS ===================

^+z::Pause           ; ctrl + shift + z
^+x::ExitApp            ; ctrl + shift + x


w::
  my_color := "white"
  opp_color := "black"
b::
  my_color := "black"
  opp_color := "white"


1::NewGame()
2::TryMove()

7::DriftMouse()
; 4::FindMyGuys()

3::MoveKnight("e2")

;0::FindMove("f4", "pawn")

a::GetPositions()

;0::OutputPositions()
;9::OutputDebug, % "Output Debug Output Debug" . my_color . ""
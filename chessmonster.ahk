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

global rel_path := "" . A_ScriptDir . "\assets\"
;global img_path := %rel_path%p_wh_wh.png
;global img_path := "" . rel_path . "p_wh_wh.png"

; Exit
; Pause On

;MsgBox, Hello `n hello


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
;GetMyColor()

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

; FindMyGuys() {
;   source := RandomSquare()   ;source is a spot
;   ; if (SquareStatus(source) = my_color) {
;   ; } else {
;     while (SquareStatus(source) != my_color) {
;       sleep, 50
;       MouseMove, board[source].x, board[source].y
; ;      MsgBox, % "Source: " . source . "  ID: " . SquareStatus(source) . "   my_color: " . my_color . ""
;       sleep, 50
;       source := RandomSquare()
;     }
;     sleep, 50
;     guy_spot := source
;     MouseMove, board[source].x, board[source].y
;     MsgBox, % "Found my guy.  Source: " . source . "  ID: " . SquareStatus(source) . "   my_color: " . my_color . ""

;     MsgBox, % "" . IDPiece(guy_spot) . ""

; ;  }
; }

;TryMove() calls RandomSquare, SquareStatus, IDPiece,
TryMove() { ; TryMove, FindMove, MovePiece
  Loop {
    Sleep, 10
    spot := RandomSquare()
    while (SquareStatus(spot) != my_color) {   ; find my guys
      sleep, 10
      ; MsgBox, % "Source: " . source . " SquareStatus source:  " . SquareStatus(source) . "   my_color:  " . my_color . ""
      MouseMove, board[spot].x, board[spot].y
      sleep, 10
      spot := RandomSquare()
      sleep, 10        ; found my guy
    ;  spot := source
      MouseMove, board[spot].x, board[spot].y
    }
    piece_type := IDPiece(spot)
  ;  MsgBox, % "" . piece_type . ""  ; piece_type

    if ((piece_type != "pawn") AND (piece_type != "pawn")) {
      TryMove()
    }
    if (piece_type = "pawn") {
      target := FindMove(spot, piece_type)
    }
    if target {
      MovePiece(spot, target)
    }
    Sleep, 10
  }
}

FindMove(spot, piece_type) { ;"f4", "pawn"
  target := PawnMoves(spot)
;  MsgBox, %target%
  ; if target {
  ;   MovePiece(spot, target)
  ; }
  ; return target
  return target
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

; ChooseMove() {
;   MsgBox, % RandomSquare()
; }

RandomSquare() {
  Random, rank, 1, 8
  Random, file, 1, 8
;  rank := rand_num1
  file := Chr(96 + file)   ; file > a-h
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



1::NewGame()
2::TryMove()

3::DriftMouse()
; 4::FindMyGuys()

8::KnightMoves("b1")

0::FindMove("f4", "pawn")

a::GetPositions()

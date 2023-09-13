;ChessMonster
;resolution: HP second screen
;browser zoom: 80%
;board_scope := "147, 205  to  849, 908" ;(702 x 761 )
;square_size := "87 by 95"  ;87 x 87
            ;  ChooseSquare(), SquareStatus(spot),
            ;  IDPiece(spot), MovePiece(spot, target)
            ;  MovePawn(spot), MoveKnight(spot), MoveBishop(spot),
            ;  MoveRook(spot), MoveQueen(spot), MoveKing(spot)

#Include chess_gui.ahk
#Include VA.ahk
#Include listener.ahk
#Include board_map.ahk
#Include board_watcher.ahk
#Include positions_watcher.ahk
#Include positions_poller.ahk
#Include piece_polls.ahk
#Include opening_moves.ahk
#Include move_maker.ahk
#Include new_match.ahk

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

global none := "none"
global my_color := "white"
global opp_color := "black"
;global target_status := "empty"
global move_num := 0

global paused := false

;
;
;
;
;  =====================================================================
;    === BEGIN MAIN SEQUENCE ===================      MAIN SEQUENCE

ActivateChess()
CreateGui()
CreateBoard()
GetMyColor()
GetStartingPositions()

; PollOpponent()
; PollOpponent()
; PollOpponent()
; PollOpponent()
; PollOpponent()
; PollOpponent()
; PollOpponent()
; PollOpponent()
; PollOpponent()
; PollOpponent()
; PollOpponent()
; PollOpponent()

;CheckForGameEnd()



;   ===== END MAIN SEQUENCE ================        END MAIN SEQUENCE
; ======================================================================


;
;
;        PAUSE LOOP
;
;
PauseDisplay() {
  LogMain0("           ready")
  LogMain("1 new match")
  LogTimer("2 continue")
  LogVolume("r rematch")
}
PauseMatch() {
  if paused {
    GoLoop()
  } else {
    paused := true
  }
}

;
;           GO LOOP           GO LOOP           GO LOOP
;
;
GoLoop() {                   ; GoLoop() main chessmonster loop
LogMain0("GoLoop()")
sleep, 200
  paused := false
  ActivateChess()

  loop {
    spot := ChooseSquare()

    spot_color := UpdatePosition(spot)

    spot := FindMyGuys(spot, spot_color)    ; return spot   ( color = my_color )

    piece_type := positions[spot].piece  ;       <<============
    UseSpecificPiece() ; return none
    target := MoveWhichPiece(spot, piece_type)

    if target {
      MovePiece(spot, target)   ; MovePiece()--move_maker.ahk
      PromotePawn(piece_type, target)
      Listen()
      PollOpponent()
    }
    if (paused = true) {
      PauseDisplay()
      break
    }
  }
}

;**********************************************************************************************
;
;    BeginFunctions()     BeginFunctions()      BeginFunctions()      BeginFunctions()
;
;**********************************************************************************************
;

NewGame() {
  ActivateChess()
  ResetMoves()
  GetMyColor()
  FlipBoard()
  GetStartingPositions()
  GoLoop()
  ; MakeMove()
}

ResetMoves() {
  move_num := 0
  LogMoves(move_num)
}

PollOppTerritory() {
  loop 9 {
    PollOpponent()
  }
}

UseSpecificPiece() {
  ; LogMain("UseSpcificPiece()")
  ; sleep 200
  ; if ( (piece_type != "bishop") ) {
  ;   TryMove()
  ; }
  return none
}
MoveWhichPiece(spot, piece_type) {
  switch piece_type {
    case "pawn":
      target := MovePawn(spot)
    case "knight":
      target := MoveKnight(spot)
    case "bishop":
      target := MoveBishop(spot)
    case "rook":
      target := MoveRook(spot)
    case "queen":
      target := MoveQueen(spot)
    case "king":
      target := MoveKing(spot)
  }
  return target
}
PromotePawn(piece_type, target) {
  if ( (piece_type = "pawn") AND (target contains 8) ) {
    sleep 100
    mouseclick Left    ;  Promotion  choose queen
  }
}

ChooseSquare() {
  LogMain("ChooseSquare()")
  if fail {    ; fail from move_maker.ahk
    fail := false
    spot := FailChoose()
  } else if ( RandomChoice() ) {
    spot := ChooseMySpots()
  } else {
    spot := RandomSquare()
    LogMain("ChooseSquare() " . spot . " rand square")
    sleep 200
  }
  return spot
}

FailChoose() {
  LogMain("FailChoose()")
  if RandomChoice() {
    spot := WhereIsMyKing()
  } else {
    spot := ChooseMySpots()
  }
  return spot
}

ChooseMySpots() {
    LogMain("ChooseMySpots() " . spot)
    sleep 100
    my_spots := GetMySpots()
    length_my_spots := my_spots.length()
    Random, spot_num, 1, length_my_spots
    spot := my_spots[spot_num]
    return spot
}

RandomSquare() {
  random, col, 1, 8
  random, rank, 1, 8
  file := Chr(96 + col)   ; file > a-h
  spot := file . rank
  return spot
}

RandomChoice(max=2) {
  random, choice, 1, max
  if (choice = 1) {
    return true
  } else {
    return false
  }
}

Output() {
  MsgBox, % "a1:  x: " . board["a1"].x . "  y: " . board["a1"].y . ""
  MsgBox, % "a2:  x: " . board["a2"].x . "  y: " . board["a2"].y . ""
  MsgBox, % "b1:  x: " . board["b1"].x . "  y: " . board["b1"].y . ""
  MsgBox, % "b2:  x: " . board["b2"].x . "  y: " . board["b2"].y . ""
}

MyColorWhite() {
  my_color := "white"
  opp_color := "black"
}

MyColorBlack() {
  my_color := "black"
  opp_color := "white"
}

global toggle := true
ToggleLoop() {
  toggle := !toggle
}

StartTLoop() {
  loop
  {
      If not Toggle
          break
      tooltip %A_Index%
  }
  return
}

ActivateChess() {
  LogMain0("ActivateChess()")
  sleep, 200
  if WinExist("Play Chess") {
    WinActivate, Play Chess
  }
}

SublimeGo() {
  WinActivate, ahk_class PX_WINDOW_CLASS
}

ExitChessMonster() {
  gui hide
  SublimeGo()
  ExitApp
}

;======= KEYBOARD SHORTCUTS ===================



^+z::Pause           ; ctrl + shift + z
;^+x::ExitApp            ; ctrl + shift + x
^x::ExitChessMonster() ; ctrl + shift + x
^+x::ExitChessMonster() ; ctrl + shift + x
; ^+c::SublimeGo() ; ctrl + shift + x

1::NewGame()
2::GoLoop()
7::DriftMouse()
r::RematchComputer()
q::MoveGui1()
e::MoveGui2()
s::ShakeGui()

8::ToggleLoop()
9::StartTLoop()
0::New3Min()
; 0::UpdatePosition("e5")
; 0::SqStatTest()

a::GetPositions()
w::MyColorWhite()
b::MyColorBlack()

o::PollOppTerritory()
p::PauseMatch()

z::SoundBeep, 400, 500  ; , [ Frequency, Duration]

;9::OutputDebug, % "Output Debug Output Debug" . my_color . ""

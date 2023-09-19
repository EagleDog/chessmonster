;ChessMonster
;resolution: HP second screen
;browser zoom: 80%
;board_scope := "147, 205  to  849, 908" ;(702 x 761 )
;square_size := "87 by 95"  ;87 x 87
            ;  ChooseSquare(), SquareStatus(spot),
            ;  IDPiece(spot), MovePiece(spot, target)
            ;  MovePawn(spot), MoveKnight(spot), MoveBishop(spot),
            ;  MoveRook(spot), MoveQueen(spot), MoveKing(spot)

#Include debug.ahk
#Include chess_gui.ahk
#Include VA.ahk
#Include listener.ahk
#Include board_map.ahk
#Include board_watcher.ahk
#Include positions_watcher.ahk
#Include positions_poller.ahk
#Include polling_zones.ahk
#Include snapshots.ahk
#Include antecedents_watcher.ahk
#Include opening_moves.ahk
#Include move_maker.ahk
#Include new_match.ahk

#Include pawn_mover.ahk
#Include knight_mover.ahk
#Include bishop_mover.ahk
#Include rook_mover.ahk
#Include queen_mover.ahk
#Include king_mover.ahk

global rel_path := A_ScriptDir
global assets_path := rel_path . "\assets\"
;global img_path := %rel_path%p_wh_wh.png
;global img_path := "" . rel_path . "p_wh_wh.png"

; Exit
; Pause On

global none := "none"
global my_color := "white"
global opp_color := "black"
;global target_status := "empty"
global move_num := 1

global paused := false


;
;        PAUSE LOOP
;
PauseDisplay() {
  LogMain0("           ready")
  LogMain("1 new match")
  LogTimer("2 continue")
  LogVolume("r rematch")
}
PauseMatch() {
  if paused {
    paused := false
;    GoLoop()
  } else {
    paused := true
  }
}

;
;
;  =====================================================================
;    ====== MAIN SEQUENCE ===================      MAIN SEQUENCE

ActivateChess()
CreateGui()
CreateBoard()
GetMyColor()
GetStartingPositions()
ResetSnapshots()

; PollOpponent()
; PollOpponent()
; PollOpponent()
; PollOpponent()

;CheckForGameEnd()


;   ===== END MAIN SEQUENCE ================        END MAIN SEQUENCE
; ======================================================================

;
;           GO LOOP           GO LOOP           GO LOOP
;
;
GoLoop() {                   ; GoLoop() main chessmonster loop
LogMain0("GoLoop()")
Chill()
  paused := false
  ActivateChess()
  loop {
    UpdateSnapshots()  ; <== UpdateSnapshots()
    spot := ChooseSquare()
    spot_color := SqStat(spot)
;    spot_color := UpdatePosition(spot)

    spot := FindMyGuys(spot, spot_color)    ; return spot   ( color = my_color )

    piece_type := positions[spot].piece  ;       <<============
    UseSpecificPiece() ; does nothing, for testing piece movements
    target := MoveWhichPiece(spot, piece_type)

    if target {
      MovePiece(spot, target)  ; from move_maker.ahk
      PromotePawn(piece_type, target)
;      Listen()
;      PollZone(zones["zone_1"])
      PollOpp()
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
  ResetSnapshots()
  GetMyColor()
  FlipBoard()
  GetStartingPositions()
  GoLoop()
  ; MakeMove()
}

ResetMoves() {
  move_num := 1
  LogMoves(move_num)
}

UseSpecificPiece() { ; for testing piece movements
  ; LogMain("UseSpcificPiece()")
  ; sleep 200
  ; if ( (piece_type != "bishop") ) {
  ;   TryMove()
  ; }
  ; return none
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

FindMyGuys(spot, spot_color) {
  while (spot_color != my_color) {   ; find my guys
    piece := positions[spot].piece
    spot := ChooseSquare()
    spot_color := SqStat(spot)
;    spot_color := UpdatePosition(spot)
    GoSpot(spot)
  }
  return spot
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
    Chill()
  }
  return spot
}

FailChoose() {
  LogMain("FailChoose()")
  if RandomChoice(3) {
    spot := ChooseMySpots()
  } else {
    spot := WhereIsMyKing()
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

MyColorWhite() {
  my_color := "white"
  opp_color := "black"
}

MyColorBlack() {
  my_color := "black"
  opp_color := "white"
}

Chill() {
  sleep 100
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
3::MoveGui3()
7::DriftMouse()
r::RematchComputer()
q::MoveGui1()
e::MoveGui2()
s::ShakeGui()

;9::New3Min()

d::DebugSnapshots()
0::CheckQueenAntecedents("e5")

;0::OutputSnapshot(1)
;0::GetPositionsHistory(2)
; 0::UpdatePosition("e5")
; 0::SqStatTest()

a::GetPositions()
w::MyColorWhite()
b::MyColorBlack()

;o::PollOppTerritory()
p::PauseMatch()

o::OutputSnapshot()


z::SoundBeep, 400, 500  ; , [ Frequency, Duration]

;9::OutputDebug, % "Output Debug Output Debug" . my_color . ""

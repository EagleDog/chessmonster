;ChessMonster
;resolution: HP second screen
;browser zoom: 80%
;board_scope := "147, 205  to  849, 908" ;(702 x 761 )
;square_size := "87 by 95"  ;87 x 87
            ;  ChooseSquare(), SquareStatus(spot),
            ;  IDPiece(spot), MovePiece(spot, target)
            ;  MovePawn(spot), MoveKnight(spot), MoveBishop(spot),
            ;  MoveRook(spot), MoveQueen(spot), MoveKing(spot)

; Exit
; Pause On

; #Include engine\std_in_out.ahk
#Include debug.ahk
#Include interface\chess_gui.ahk
#Include interface\VA.ahk
#Include interface\listener.ahk

#Include engine\fen_maker.ahk
#Include engine\streamer.ahk
#Include engine\uci_commander.ahk

#Include interface\board_map.ahk
#Include interface\board_watcher.ahk
#Include interface\positions_watcher.ahk
#Include interface\positions_poller.ahk
#Include interface\zone_poller.ahk
#Include interface\snapshots.ahk
#Include interface\antecedents_watcher.ahk
#Include interface\opening_moves.ahk
#Include interface\move_maker.ahk
#Include interface\new_match.ahk

#Include interface\pawn_mover.ahk
#Include interface\knight_mover.ahk
#Include interface\bishop_mover.ahk
#Include interface\rook_mover.ahk
#Include interface\queen_mover.ahk
#Include interface\king_mover.ahk

global rel_path := A_ScriptDir
global assets_path := rel_path . "\assets\"
global fishlog := rel_path . "\engine\fishlog.txt"

global none := "none"
global my_color := "white"
global opp_color := "black"
global my_color_abbr := "w"
;global target_status := "empty"

global paused := false

global move_num := 1

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
      if !fail {
        PromotePawn(piece_type, target)
        PollOpp()
      }
    }
;      Listen()
;      PollZone(zones["zone_1"])
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
  ; GoLoop()
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
  if RandomChoice(3) {      ; 1:3 odds move my_spots
    spot := ChooseMySpots()
  } else {
    spot := WhereIsMyKing() ; 2:3 odds move king
  }
  return spot
}

ChooseMySpots() {
    LogMain( "ChooseMySpots()" )
;    sleep 100
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
  ExitStreamer()
  ExitApp
}

;======= KEYBOARD SHORTCUTS ===================


^+z::Pause           ; ctrl + shift + z
;^+x::ExitApp            ; ctrl + shift + x
^x::ExitChessMonster() ; ctrl + shift + x
^+x::ExitChessMonster() ; ctrl + shift + x
; ^+c::SublimeGo() ; ctrl + shift + x

1::StartEngine()
2::PollZones()
3::RunUCI()
0::NewGameUCI()

^1::NewGame()
^2::GoLoop()
^3::MoveGui3()
m::DriftMouse()
r::RematchComputer()
q::MoveGui1()
e::MoveGui2()
s::ShakeGui()

;9::New3Min()

d::DebugSnapshots()

;0::CheckQueenAntecedents("e5")
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


;z::SoundBeep, 400, 500  ; , [ Frequency, Duration]


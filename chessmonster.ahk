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

global rel_path := A_ScriptDir
global assets_path := rel_path . "\assets\"
global fishlog := rel_path . "\engine\fishlog.txt"

#Include tools\debug.ahk
#Include tools\VA.ahk
#Include tools\toolbox.ahk
#Include interface\chess_gui.ahk
#Include interface\listener.ahk

#Include engine\castle_rights.ahk
#Include engine\fen_maker.ahk
#Include engine\streamer.ahk
#Include engine\uci_commander.ahk

#Include interface\board_map.ahk
#Include interface\board_watcher.ahk
#Include interface\positions_watcher.ahk
#Include interface\positions_poller.ahk
#Include interface\zone_poller.ahk
#Include interface\snapshots.ahk
#Include interface\opening_moves.ahk
#Include interface\move_maker.ahk
#Include interface\new_match.ahk
#Include interface\antecedents_watcher.ahk
#Include interface\descendents_watcher.ahk

#Include pieces\pawn_mover.ahk
#Include pieces\knight_mover.ahk
#Include pieces\bishop_mover.ahk
#Include pieces\rook_mover.ahk
#Include pieces\queen_mover.ahk
#Include pieces\king_mover.ahk

global none := "none"
global my_color := "white"
global opp_color := "black"
global my_color_abbr := "w"
;global target_status := "empty"

global paused := false

global move_num := 1

;
;  =====================================================================
;    ====== MAIN SEQUENCE ===================      MAIN SEQUENCE

ActivateChess()
CreateGui()
CreateBoard()
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
        PromotePawn(spot, piece_type, target)
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
;                 NewGame()

NewGame() {
  ActivateChess()
  ResetMoves()
  ResetCastleRights()
  GetMyColor()
  FlipBoard()
  GetStartingPositions()
  ResetSnapshots()
  NewGameUCI()
  StartGame()
  ; GoLoop()
  ; MakeMove()
}

UseSpecificPiece() { ; for testing piece movements
  ; if ( (piece_type != "bishop") ) {
  ;   TryMove()
  ; }
}

MoveWhichPiece(spot, piece_type) {
  switch piece_type {
    case "pawn": target := MovePawn(spot)
    case "knight": target := MoveKnight(spot)
    case "bishop": target := MoveBishop(spot)
    case "rook": target := MoveRook(spot)
    case "queen": target := MoveQueen(spot)
    case "king": target := MoveKing(spot)
  }
  return target
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

StartGame() {
  ; if ( ( my_color == "black" )
  ;     and ( move_num == 1 ) ) {
  ;   PollOpp()
  ; } else {
  ;   RunUCI()
  ; }
  RunUCI()
  loop {
    if ( paused == true ) {
      paused := false
      break
    }
    PollOpp()
  }
}


;======= KEYBOARD SHORTCUTS ===================


^+z::Pause           ; ctrl + shift + z
;^+x::ExitApp            ; ctrl + shift + x
^x::ExitChessMonster() ; ctrl + shift + x
^+x::ExitChessMonster() ; ctrl + shift + x
; ^+c::SublimeGo() ; ctrl + shift + x

1::StartGame()
2::PollOpp()
;2::PollOpp()
3::RunUCI()

4::SearchSuccessors("d4", rook_patterns)
; 4::SearchSuccessors("h8", rook_patterns)

5::GetMyColor()

;5::CheckPawnSize()

9::msgbox % move_num "--move_num"
0::NewGameUCI()

^1::NewGame()
^2::GoLoop()
^3::MoveGui3()

^+1::MoveStockfish()
^+2::MoveFish2()
^+3::MoveFish3()

m::DriftMouse()
r::RematchComputer()
q::MoveGui1()
e::MoveGui2()
s::ShakeGui()

;9::New3Min()

d::DebugSnapshots()
^f::FishlogRefresh()
f::FlipBoardUCI()

;0::CheckQueenAntecedents("e5")
;0::OutputSnapshot(1)
;0::GetPositionsHistory(2)
; 0::UpdatePosition("e5")
; 0::SqStatTest()

a::GetPositions()
w::MyColorIsWhite()
b::MyColorIsBlack()

;o::PollOppTerritory()

p::PauseMatch()

o::OutputSnapshot()

;z::SoundBeep, 400, 500  ; , [ Frequency, Duration]

Up::IncreaseMoveNum()
Down::DecreaseMoveNum()

w & k::CastleRights1()
w & q::CastleRights2()
b & k::CastleRights3()
b & q::CastleRights4()


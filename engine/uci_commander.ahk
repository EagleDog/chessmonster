;uci_commander.ahk
;
; 
; STEP 0 -- launch stockfish console    DONE
; STEP 1 -- ucinewgame                  DONE
; STEP 2 -- position startpos           DONE
; STEP 3 -- isready                     DONE
; STEP 4 -- go movetime 1000            DONE
; STEP 5 -- stop
; STEP 6 -- get bestmove (e.g. e2e3)    DONE
; STEP 7 -- translate move to gui (e.g. MovePiece(e2,e3))   DONE
; STEP 8 -- get new fen from gui
; STEP 9 -- position fen rnbqk3/4pppp/8/8/...etc  (reflects move e2e3)
; STEP 10 -- is ready
; STEP 11 -- go movetime 1000
; ... etc.

;global move_time := 500

stockfish_commands := ["ucinewgame","isready","d","position startpos"
                       ,"position fen","go movetime 1000", "stop", "flip"]

StartEngine() {
  AttachStockfish()
  MoveStockfish()
  NewGameUCI()
  AdjustElo()
  ActivateChess()
}

RunUCI() {
  blunder := Blunderize()
  if blunder {
    return
  }
  LogField2("")
  if not WinExist("ahk_exe stockfish.exe") {
    StartEngine()
  }
  GetReady()
  fen := GetFenFromGUI()
  SendFenToUCI(fen)
  GetReady()
  if ( skill_level == 0 ) {
    FindMove()
    sleep 50
  } else {
    move_time := RandMoveTime()
    CalculateMove(move_time)   ; go movetime 500  ; ActivateChess()
    sleep % move_time + 50
  }
   bestmove := GetBestMove()
   bestmoves := ParseBestMove(bestmove)
  ActivateChess()
  DidGameEnd()
  SendMoveToGUI(bestmoves)
  CheckMyEnPassant(bestmove)
  CheckMyCastling(bestmove)
  delay := true
}

CalculateMove(movetime) {
  SendToUCI("go movetime " movetime)
}

FindMove() {
  SendToUCI("go depth 1")
  UpdateFishlog()
}

GetBestMove() {
  response := ReceiveFromUCI()
  bestmove := StrSplit(response, " ")[2]
  FileAppend % bestmove " ", *
  return bestmove
}

SendMoveToGUI(bestmoves) {        ; move piece
  spot := bestmoves[1]
  target := bestmoves[2]
  LogOpp1("")
  LogOpp2("")
  my_capture := CheckMyCaptures(bestmoves)
  MovePiece(spot, target)
  piece := positions[target].piece
  ; PromotePawn(spot, piece, target) ; <== PromotePawn(spot,piece,target)
  LogMine1(piece " " target)
  ; LogMine1(piece " " spot " to " target)
  if my_capture {
    LogMine2(piece " took " my_capture)
  }
  fileappend % "move " bestmoves[1] " to " bestmoves[2] " sent to gui", *
}

GetReady() {
  SendIsReady()
  ready_response := GetIsReady()
  while ( ready_response != "readyok") {
    sleep 300
    SendIsReady()
    ready_response := GetIsReady()
  }
}

SendIsReady() {
  SendToUCI("isready")
}

GetIsReady() {
  ready_response := ReceiveFromUCI()
  return ready_response
}

AttachConsole() {
  AttachStockfish()
}

SendToUCI(command) {
  OutToFish(command)
}

ReceiveFromUCI() {
  response := InFromFish()
  return response
}

NewGameUCI() {
  SendToUCI("uci")
  SendToUCI("ucinewgame")
  AdjustElo()
}

StartPos() {
  SendToUCI("position startpos")
}

StopThinking() {
  SendToUCI("stop")
}

DisplayBoardUCI() {
  SendToUCI("d")
}

ParseBestMove(bestmove) {
  bestmoves := []
  loop parse, bestmove
  { 
    if A_LoopField is Integer
    {
      num_pos := A_Index
      bestmoves.push(SubStr(bestmove, num_pos - 1, 2))
    }
  }
  Print("bestmove: " bestmoves[1] " " bestmoves[2] " ")
  return bestmoves
}

GetFenFromGUI() {
  fen := CreateFen()
  return fen
}

SendFenToUCI(fen) {
  SendToUCI("position fen " fen)
  Print("position fen " fen)
}

; 1::AttachConsole()
; 2::NewGameUCI()
; 3::StartPos()
; 4::SendIsReady()
; 5::ReceiveReady()

; 6::CalculateMove(500)
; 7::GetBestMove()
; 8::ParseBestMove(bestmove)
; 9::SendMoveToGUI(bestmoves)
; ;9::GetFenFromGUI()
; 0::SendFenToUCI()

; ;2::OutToFish("isready")
; ;3::InFromFish()

; ^+x::ExitStreamer()






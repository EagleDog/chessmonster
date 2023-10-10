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
  if not WinExist("ahk_exe stockfish.exe") {
    StartEngine()
  }
  GetReady()
  fen := GetFenFromGUI()
  SendFenToUCI(fen)
  GetReady()
   move_time := RandMoveTime()
  CalculateMove(move_time)   ; go movetime 500  ; ActivateChess()
   sleep % move_time + 50
   bestmove := GetBestMove()
   bestmoves := ParseBestMove(bestmove)
  ActivateChess()
  DidGameEnd()
  SendMoveToGUI(bestmoves)
  CheckMyEnPassant(bestmove)
  CheckMyCastling(bestmove)
}

GetBestMove() {
  response := ReceiveFromUCI()
  bestmove := StrSplit(response, " ")[2]
  FileAppend % bestmove " ", *
  return bestmove
}

SendMoveToGUI(bestmoves) {        ; move piece
  LogField3("")
  LogField4("")
  my_capture := CheckMyCaptures(bestmoves)
  MovePiece(bestmoves[1], bestmoves[2])
  LogField5("we moved " bestmoves[1] " to " bestmoves[2])
  if my_capture {
    LogField6("we captured " my_capture)
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
  SendToUCI("ucinewgame")
}

StartPos() {
  SendToUCI("position startpos")
}

CalculateMove(movetime) {
  SendToUCI("go movetime " movetime)
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






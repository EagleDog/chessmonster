;uci_support.ahk
;
;

AdjustElo() {
  ; SendToUCI("setoption name UCI_LimitStrength value true")
  ; SendToUCI("setoption name UCI_Elo value " elo)
  SendToUCI("setoption name Skill Level value " skill_level)
}

RandMoveTime(){
  random rand_move_time, 50, 150
  return 5
}

CheckMyCaptures(bestmoves) {
  if ( positions[bestmoves[2]].color == opp_color ) {
    my_capture := positions[bestmoves[2]].piece
    captures := true
    return my_capture
  }
}


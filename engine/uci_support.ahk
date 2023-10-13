;uci_support.ahk
;
;

AdjustElo() {
  if ( skill_level != "off" ) {
    SendToUCI("setoption name Skill Level value " skill_level)
  } else if ( elo != "off" ) {
    SendToUCI("setoption name UCI_LimitStrength value true")
    SendToUCI("setoption name UCI_Elo value " elo)
  }
}

RandMoveTime(){
  random rand_move_time, 50, 150
  ; return rand_move_time
  return 2000
}

CheckMyCaptures(bestmoves) {
  if ( positions[bestmoves[2]].color == opp_color ) {
    my_capture := positions[bestmoves[2]].piece
    captures := true
    return my_capture
  }
}

Fishlog(log_text) {
  fileappend % log_text, % fishlog
}


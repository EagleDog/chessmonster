
chessmonster -- move automation 

Automagic Mouse Moves

an AHK demo -- AutoHotKey Demo

pawns are sacrificed
devoured by opponents
slaughtered by bishops
sacrificed for weather
an ancient ritual


Keyboard Shortcuts are at bottom of main file

    ^+z::Pause
    ^+x::Exit

    1::NewGame()
    2::MakeMove()
    7::DriftMouse()
    r::RematchComputer()

    a::GetPositions()
    w::MyColorWhite()
    b::MyColorBlack()


chessmonster.ahk is main file

  it uses `#include` to include other files

chessmonster
  \___board_map
   |__board_watcher
   |__positions_watcher
   |__mouse_mover
   |__chess_gui
   |__listener
   |__pawn_mover
   |__knight_mover
   |__bishop_mover
   |__rook_mover
   |__queen_mover
   |__king_mover





____roadmap____

needed bug fix: queen, bishop, rook sometimes try to jump past opponent's pieces

increase position polling (esp. opp.'s side of board)
  - position polling during move:
    - pawn      done
    - knight    done
    - bishop    done
    - rook      done
    - queen     done
    - king      done

**figure out a way to check for mated king**
  --especially: after 15 or 20 moves or so
  --possibly: check if piece tried to move, but stayed in same spot


increase play speed

____finished tasks____






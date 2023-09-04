
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
    0::TryMoves()

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

increase position polling (esp. opp.'s side of board)

**figure out a way to check for mated king**
  --especially: after 15 or 20 moves or so
  --possibly: check if piece tried to move, but stayed in same spot


increase play speed



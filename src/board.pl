:- dynamic board/4.
:- dynamic board/3.
:- dynamic board/2.

% Initial pawn
board(0, 1, pawn, white). %% a2
board(0, 6, pawn, black). %% a7
board(1, 1, pawn, white). %% b2
board(1, 6, pawn, black). %% b7
board(2, 1, pawn, white). %% c2
board(2, 6, pawn, black). %% c7
board(3, 1, pawn, white). %% d2
board(3, 6, pawn, black). %% d7
board(4, 1, pawn, white). %% e2
board(4, 6, pawn, black). %% e7
board(5, 1, pawn, white). %% f2
board(5, 6, pawn, black). %% f7
board(6, 1, pawn, white). %% g2
board(6, 6, pawn, black). %% g7
board(7, 1, pawn, white). %% h2
board(7, 6, pawn, black). %% h7

% Initial Bishop
board(2, 0, bishop, white). %% c1
board(2, 7, bishop, black). %% f1
board(5, 0, bishop, white). %% c8
board(5, 7, bishop, black). %% f8

% Initial knight
board(1, 0, knight, white). %% b1
board(6, 0, knight, black). %% g1
board(1, 7, knight, white). %% b8
board(6, 7, knight, black). %% g8

% Initial Rook
board(0, 0, rook, white). %% a1
board(7, 0, rook, black). %% a8
board(0, 7, rook, white). %% h1
board(7, 7, rook, black). %% h8

% Initial Queen
board(3, 0, queen, white). %% d1
board(3, 7, queen, black). %% d8

% Initial King
board(4, 0, king, white). %% e1
board(4, 7, king, black). %% e8

updateBoard([Px, Py, Cx, Cy], Piece, Turn):-
    removePiece(board(Px, Py, _, _)), 
    removePiece(board(Cx, Cy, _, _)),
    assert(board(Cx, Cy, Piece, Turn)), !.

removePiece(Board):-
    retract(Board).
removePiece(_Board).


isPieceValid(Turn, [A, B, _, _], Piece):-
    board(A, B, Piece, Turn).

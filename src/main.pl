:- consult(menu).
:- consult(move).
:- consult(gui).
:- consult(board).
:- consult(stockfish).

:- dynamic(gamemode/1).     % gamemode(mode)


main :-
    showMenu(GameMode),
    assert(gamemode(GameMode)),
    initGameGui(game, white).


game(X, Y, Turn, _) :-
    selected(Sx, Sy, SRef, Turn),
    playerMove(Turn, [Sx, Sy, X, Y]), !,
    gamemode(Gamemode),
    applyMove(Gamemode, [Sx, Sy, X, Y]),
    deselectBox(Sx, Sy, SRef).
game(X, Y, Turn, Ref) :-
    isPieceValid(X, Y, _, Turn),
    not(selected(_, _, _, _)),
    selectBox(X, Y, Turn, Ref).
game(_, _, _, _) :-
    selected(Sx, Sy, SRef, _),
    deselectBox(Sx, Sy, SRef).


applyMove(1, [Sx, Sy, X, Y]) :-
    turn(Turn),
    removePiece(X, Y),
    updateBoard([Sx, Sy, X, Y], PRef, Piece),
    movePiece(PRef, X, Y),
    applyPromotion(Turn, X, Y, PRef, Piece),
    changeTurn(Turn).
applyMove(2, PlayerMove) :-
    applyMove(1, PlayerMove),
    turn(Turn), board_to_fen(Turn, Fen),
    start_stockfish(Stockfish, Out),
    get_best_move(Stockfish, Out, Fen, 1000, StockfishMove),
    applyMove(1, StockfishMove),
    changeTurn(Turn).


applyPromotion(Turn, X, Y, Ref, pawn):-
    (Y =:= 7; Y =:= 0),
    removePiece(board(X, Y, pawn, _, _)),
    assert(board(X, Y, queen, Turn, Ref)),
    changePiece(X, Y, queen).
applyPromotion(_, _, _, _, _).
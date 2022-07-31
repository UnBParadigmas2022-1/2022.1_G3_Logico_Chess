:- consult(board).
:- consult(gui).
:- consult(menu).
:- consult(move).
:- consult(socket).
:- consult(stockfish).
:- consult(utils).

:- dynamic(gamemode/1).     % gamemode(mode)


main :-
    showMenu(GameMode),
    assert(gamemode(GameMode)),
    initSocketGame(GameMode),
    initGameGui(game, white).


game(X, Y, Turn, _) :-
    selected(Sx, Sy, SRef, Turn),
    playerMove(Turn, [Sx, Sy, X, Y]), !,
    gamemode(Gamemode),
    applyMove(Gamemode, [Sx, Sy, X, Y]),
    deselectBox(Sx, Sy, SRef),
    \+isCheckmate.
game(X, Y, Turn, Ref) :-
    isPieceValid(X, Y, _, Turn),
    not(selected(_, _, _, _)),
    selectBox(X, Y, Turn, Ref).
game(_, _, _, _) :-
    selected(Sx, Sy, SRef, _),
    deselectBox(Sx, Sy, SRef).


isCheckmate :-
    turn(Turn),
    board_to_fen(Turn, Fen),
    start_stockfish(Stockfish, Out),
    get_best_move(Stockfish, Out, Fen, 1, [Move|_]),
    Move == 40,
    format('Checkmate, vitoria do jogador ~a\n', Turn).


applyMove(1, [Sx, Sy, X, Y]) :-
    removePiece(X, Y),
    updateBoard([Sx, Sy, X, Y], PRef),
    movePiece(PRef, X, Y),
    turn(Turn),
    changeTurn(Turn).
applyMove(3, PlayerMove) :-
    applyMove(1, PlayerMove),
    turn(Turn),
    playerSocketMove(Turn, PlayerMove, SocketMove),
    applyMove(1, SocketMove),
    changeTurn(Turn).
applyMove(4, PlayerMove) :-
    applyMove(1, PlayerMove),
    turn(Turn), board_to_fen(Turn, Fen),
    start_stockfish(Stockfish, Out),
    get_best_move(Stockfish, Out, Fen, 100, StockfishMove),
    applyMove(1, StockfishMove),
    changeTurn(Turn).
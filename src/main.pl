:- consult(menu).
:- consult(move).
:- consult(gui).

:- dynamic(gamemode/1).     % gamemode(mode)


main :-
    showMenu(GameMode),
    assert(gamemode(GameMode)),
    initGameGui(game, white).


game(X, Y, Turn, _) :-
    selected(Sx, Sy, SRef, Turn),
    playerMove(Turn, [Sx, Sy, X, Y]), !,
    gamemode(Gamemode),
    applyMove(Gamemode, [Sx, Sy, X, Y], Turn),
    deselectBox(Sx, Sy, SRef),
    changeTurn(Turn).
game(X, Y, Turn, Ref) :-
    isPieceValid(X, Y, _, Turn),
    not(selected(_, _, _, _)),
    selectBox(X, Y, Turn, Ref).
game(_, _, _, _) :-
    selected(Sx, Sy, SRef, _),
    deselectBox(Sx, Sy, SRef).


applyMove(1, [Sx, Sy, X, Y], _) :-
    removePiece(X, Y),
    updateBoard([Sx, Sy, X, Y], PRef),
    movePiece(PRef, X, Y).
applyMove(2, PlayerMove, Turn) :-               %% STOCKFISH INTEGRATION
    applyMove(1, PlayerMove, Turn).
    % CALL STOCKFISH (StockfishMove)
    % applyMove(1, StockfishMove, Turn),
    % changeTurn(Turn).                         %% PASS COMPUTER TURN


:- consult(board).
:- consult(gui).
:- consult(menu).
:- consult(move).
:- consult(socket).
:- consult(stockfish).
:- consult(utils).

:- dynamic(gamemode/1).      % gamemode(mode)
:- dynamic(turn/1).          % turn(Turn)


main :-
    showMenu(GameMode),
    assert(gamemode(GameMode)),
    assert(turn(white)),
    initSocketGame(GameMode),
    initGameGui(GameMode, boxClickEvent).


boxClickEvent(X, Y, Ref) :-
    turn(Turn),                             % Get current turn (white or black)
    gamemode(GameMode),                     % Get current gamemode
    game(GameMode, X, Y, Turn, Ref).        % Call game to make the move


game(GameMode, X, Y, Turn, _) :-
    checkTurn(GameMode, Turn),
    selected(Sx, Sy, SRef, Turn),
    playerMove(Turn, [Sx, Sy, X, Y]), !,
    applyMove(GameMode, [Sx, Sy, X, Y]),
    deselectBox(Sx, Sy, SRef),
    \+isCheckmate.
game(GameMode, X, Y, Turn, Ref) :-
    checkTurn(GameMode, Turn),
    isPieceValid(X, Y, _, Turn),
    not(selected(_, _, _, _)),
    selectBox(X, Y, Turn, Ref).
game(_,_,_,_,_) :-
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
applyMove(GameMode, PlayerMove) :-
    (GameMode == 2; GameMode == 3),
    applyMove(1, PlayerMove),
    turn(Turn),
    sendPlayerSocketMove(Turn, PlayerMove).
applyMove(4, PlayerMove) :-
    applyMove(1, PlayerMove),
    turn(Turn), board_to_fen(Turn, Fen),
    start_stockfish(Stockfish, Out),
    get_best_move(Stockfish, Out, Fen, 100, StockfishMove),
    applyMove(1, StockfishMove),
    changeTurn(Turn).


checkTurn(2, white) :- !, fail.
checkTurn(3, black) :- !, fail.
checkTurn(_, _) :- !.


changeTurn(white) :- retract(turn(_)), assert(turn(black)).
changeTurn(black) :- retract(turn(_)), assert(turn(white)).

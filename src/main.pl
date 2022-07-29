:- consult(menu).
:- consult(move).
:- consult(gui).

main :-
    showMenu(GameMode),
    initGameGui(GameMode, game, white).


game(Gamemode, X, Y, Turn, _) :-
    selected(Sx, Sy, SRef, Turn),
    makeMove(Gamemode, Turn, [Sx, Sy, X, Y]), !,
    removePiece(X, Y),
    updateBoard([Sx, Sy, X, Y], PRef),
    movePiece(PRef, X, Y),
    deselectBox(Sx, Sy, SRef),
    changeTurn(Turn).
game(_, X, Y, Turn, Ref) :-
    isPieceValid(X, Y, _, Turn),
    not(selected(_, _, _, _)),
    selectBox(X, Y, Turn, Ref).
game(_, _, _, _, _) :-
    selected(Sx, Sy, SRef, _),
    deselectBox(Sx, Sy, SRef).


makeMove(1, Turn, Move) :- playerMove(Turn, Move).
makeMove(2, Turn, Move) :- playerMove(Turn, Move).
makeMove(3, Turn, Move) :- playerMove(Turn, Move).
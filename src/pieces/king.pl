:-consult('board').

isKingMoveValid(_, [Px, Py, Px, Py]):- fail.
isKingMoveValid(Turn, [_, _, Cx, Cy]):- board(Cx, Cy, _, Turn, _), !, fail. 
isKingMoveValid(_, Move):- 
    isKingFreeWay(Move, 1, 1);
    isKingFreeWay(Move, 1, -1);
    isKingFreeWay(Move, -1, 1);
    isKingFreeWay(Move, -1, -1);
    isKingFreeWay(Move, 1, 0);
    isKingFreeWay(Move, -1, 0);
    isKingFreeWay(Move, 0, 1);
    isKingFreeWay(Move, 0, -1).

isKingFreeWay([Px, Py, Cx, Cy], StepX, StepY) :-
    increment(Px, X, StepX),
    increment(Py, Y, StepY),
    X == Cx, Y == Cy;
        increment(Px, XX, StepX),
        increment(Py, YY, StepY),
        not(board(XX, YY,_,_,_)).
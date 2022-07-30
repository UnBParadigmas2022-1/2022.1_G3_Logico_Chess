:-consult('board').

isQueenMoveValid(_, [Px, Py, Px, Py]):- fail.
isQueenMoveValid(Turn, [_, _, Cx, Cy]):- board(Cx, Cy, _, Turn, _), !, fail. 
isQueenMoveValid(_, Move):- 
    isFreeWay(Move, 1, 1);
    isFreeWay(Move, 1, -1);
    isFreeWay(Move, -1, 1);
    isFreeWay(Move, -1, -1);
    isFreeWay(Move, 1, 0);
    isFreeWay(Move, -1, 0);
    isFreeWay(Move, 0, 1);
    isFreeWay(Move, 0, -1).
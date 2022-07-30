:-consult(board).

isBishopMoveValid(_, [Px, Py, Px, Py]):- fail.
isBishopMoveValid(Turn, [_, _, Cx, Cy]):- board(Cx, Cy, _, Turn, _), !, fail. 
isBishopMoveValid(_, [Px, Py, Cx, Cy]):- abs(Px-Cx) =\= abs(Py-Cy), fail. % so deixa andar na diagonal
isBishopMoveValid(_, Move):- 
    isFreeWay(Move, 1, 1);
    isFreeWay(Move, 1, -1);
    isFreeWay(Move, -1, 1);
    isFreeWay(Move, -1, -1).
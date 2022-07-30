:-consult(board).

isBishopMoveValid(_, [Px, Py, Px, Py]):- fail.
isBishopMoveValid(Turn, [_, _, Cx, Cy]):- board(Cx, Cy, _, Turn, _), !, fail. 
isBishopMoveValid(_, [Px, Py, Cx, Cy]):- abs(Px-Cx) =\= abs(Py-Cy), fail. % so deixa andar na diagonal
isBishopMoveValid(_, Move):- 
    isFreeWay(Move, 1, 1);
    isFreeWay(Move, 1, -1);
    isFreeWay(Move, -1, 1);
    isFreeWay(Move, -1, -1).

isFreeWay([Px, Py, _, _], _, _) :- (Px > 7; Px < 0; Py > 7; Py < 0), !, fail. % condicao de parada
isFreeWay([Px, Py, Cx, Cy], StepX, StepY) :-
    increment(Px, X, StepX),
    increment(Py, Y, StepY),
    X == Cx, Y == Cy;
        increment(Px, XX, StepX),
        increment(Py, YY, StepY),
        not(board(XX, YY,_,_,_)),
        isFreeWay([XX, YY, Cx, Cy], StepX, StepY).
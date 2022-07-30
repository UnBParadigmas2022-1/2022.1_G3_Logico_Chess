:-consult(board).

isBishopMoveValid(Turn, [Px, Py, Cx, Cy]):- Px == Cx, Py == Cy, fail.
isBishopMoveValid(Turn, [Px, Py, Cx, Cy]):- board(Cx, Cy, _, Turn), fail. 
isBishopMoveValid(Turn, [Px, Py, Cx, Cy]):- abs(Px-Cx) =\= abs(Py-Cy), fail. % so deixa andar na diagonal
isBishopMoveValid(Turn, Move):- 
    isFreeWay(Move, 1, 1);
    isFreeWay(Move, 1, -1);
    isFreeWay(Move, -1, 1);
    isFreeWay(Move, -1, -1).

isFreeWay([Px, Py, Cx, Cy], StepX, StepY) :- (Px > 7; Px < 0; Py > 7; Py < 0), !, fail. % condicao de parada
isFreeWay([Px, Py, Cx, Cy], StepX, StepY) :-
    X is Px+StepX,
    Y is Py+StepY,
    X == Cx, Y == Cy;
        XX is Px+StepX,
        YY is Py+StepY,
        not(board(XX, YY,_,_)),
        isFreeWay([XX, YY, Cx, Cy], StepX, StepY).
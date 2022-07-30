increment(X, X1, Qty):-
    X1 is X+Qty.

decrement(X, X1, Qty):-
    X1 is X-Qty.

isFreeWay([Px, Py, _, _], _, _) :- (Px > 7; Px < 0; Py > 7; Py < 0), !, fail. % condicao de parada
isFreeWay([Px, Py, Cx, Cy], StepX, StepY) :-
    increment(Px, X, StepX),
    increment(Py, Y, StepY),
    X == Cx, Y == Cy;
        increment(Px, XX, StepX),
        increment(Py, YY, StepY),
        not(board(XX, YY,_,_,_)),
        isFreeWay([XX, YY, Cx, Cy], StepX, StepY).
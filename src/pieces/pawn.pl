:-consult(board).

isPawnMoveValid(Turn, Move):-
    isTurnMoveValid(Turn, Move).

isTurnMoveValid(white, [Px, Py, Cx, Cy]):-
    increment(Py, Y),
    Px == Cx,
    Cy == Y.

isTurnMoveValid(black, [Px, Py, Cx, Cy]):-
    decrement(Py, Y),
    Px == Cx,
    Cy == Y.

increment(X, X1):-
    X1 is X+1.

decrement(X, X1):-
    X1 is X-1.
:-consult(board).

isPawnMoveValid(Turn, Move):-
    verifyPawnAttack(Turn, Move);
    isSimpleMoveValid(Turn, Move).

isSimpleMoveValid(white, [Px, Py, Cx, Cy]):-
    increment(Py, Y),
    Px == Cx,
    Cy == Y.
isSimpleMoveValid(black, [Px, Py, Cx, Cy]):-
    decrement(Py, Y),
    Px == Cx,
    Cy == Y.

increment(X, X1):-
    X1 is X+1.

decrement(X, X1):-
    X1 is X-1.

verifyPawnAttack(white, [Px, Py, Cx, Cy]):-
    board(Cx, Cy, pawn, black),
    increment(Py, Y), decrement(Px, X1), increment(Px, X2),
    (X1 == Cx ; X2 == Cx),
    Cy == Y.
verifyPawnAttack(black, [Px, Py, Cx, Cy]):-
    board(Cx, Cy, pawn, white),
    decrement(Py, Y), decrement(Px, X1), increment(Px, X2),
    (X1 == Cx ; X2 == Cx),
    Cy == Y.
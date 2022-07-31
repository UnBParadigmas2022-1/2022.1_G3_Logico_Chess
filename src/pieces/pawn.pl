isPawnMoveValid(Turn, Move):-
    (verifyPawnAttack(Turn, Move);
    (verifyCollision(Move),
    (verifyFirstMove(Turn, Move);
    isSimpleMoveValid(Turn, Move)))),
    applyPromotion(Turn, Move).


verifyCollision([_, _, Cx, Cy]):- not(board(Cx, Cy, _, _, _)).


isSimpleMoveValid(white, [Px, Py, Cx, Cy]):-
    increment(Py, Y, 1),
    Cx == Px,
    Cy == Y.
isSimpleMoveValid(black, [Px, Py, Cx, Cy]):-
    decrement(Py, Y, 1),
    Cx == Px,
    Cy == Y.


verifyPawnAttack(white, [Px, Py, Cx, Cy]):-
    board(Cx, Cy, _, black, _),
    increment(Py, Y, 1), decrement(Px, X1, 1), increment(Px, X2, 1),
    (Cx == X1 ; Cx == X2),
    Cy == Y.
verifyPawnAttack(black, [Px, Py, Cx, Cy]):-
    board(Cx, Cy, _, white, _),
    decrement(Py, Y, 1), decrement(Px, X1, 1), increment(Px, X2, 1),
    (Cx == X1 ; Cx == X2),
    Cy == Y.


verifyFirstMove(white, [Px, Py, Cx, Cy]):-
    Py == 1,
    increment(Py, Y1, 1),increment(Py, Y2, 2),
    verifyCollision([_, _, Px, Y1]),
    Cx == Px,
    Cy == Y2.
verifyFirstMove(black, [Px, Py, Cx, Cy]):-
    Py == 6,
    decrement(Py, Y1, 1),decrement(Py, Y2, 2),
    verifyCollision([_, _, Px, Y1]),
    Cx == Px,
    Cy == Y2.


applyPromotion(_, [X, Y, _, Cy]) :-
    (Cy =:= 0 ; Cy =:= 7),
    changePiece(X, Y, queen).
applyPromotion(_, _).
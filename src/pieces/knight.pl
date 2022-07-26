isKnightMoveValid(Turn, Move):-
    isMoveValid(Move),
    (isSquareEmpty(Move);
    isSquareValid(Turn, Move)).

isSquareEmpty([_, _, Cx, Cy]):- 
    not(board(Cx, Cy, _, _, _)).

isSquareValid(white, [_, _, Cx, Cy]):-
    board(Cx, Cy, _, black, _).

isSquareValid(black, [_, _, Cx, Cy]):-
    board(Cx, Cy, _, white, _).

isMoveValid([Px, Py, Cx, Cy]):-
    increment(Py, Y1, 1),
    increment(Py, Y2, 2),
    decrement(Py, Y3, 1),
    decrement(Py, Y4, 2),
    increment(Px, X1, 1),
    increment(Px, X2, 2),
    decrement(Px, X3, 1),
    decrement(Px, X4, 2),
    ((Cy == Y1 , (Cx == X2 ; Cx == X4));
    (Cy == Y2 , (Cx == X1 ; Cx == X3));
    (Cy == Y3 , (Cx == X2 ; Cx == X4));
    (Cy == Y4 , (Cx == X1 ; Cx == X3))).
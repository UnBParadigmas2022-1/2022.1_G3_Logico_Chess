:-consult(board).

isRookMoveValid(Turn, Move):-
    isVerticalEmpty(Move),
    verifyCollision(Move),
    isSimpleMoveValid(Turn, Move).


verifyCollision([_, _, Cx, Cy]):- not(board(Cx, Cy, _, _)).

isVerticalEmpty([Px, Py, Cx, Cy]):-
    Px =:= Cx,
    Py =\= Cy, !,
    increment(Py, X1, 1),
    not(board(Cx, X1, _, _)),
    isVerticalEmpty([Px, X1, Cx, Cy]).
isVerticalEmpty([Px, X1, Cx, Cy]):-
    write('Caminho limpo'),nl.


isSimpleMoveValid(white, [Px, Py, Cx, Cy]):-
    format('\nPx[~r]:\n', Px), flush_output(),
    format('\nPy[~r]:\n', Py), flush_output(),
    format('\nCx[~r]:\n', Cx), flush_output(),
    format('\nCy[~r]:\n', Cy), flush_output().

isSimpleMoveValid(black, [Px, Py, Cx, Cy]):-
    format('\nPx[~r]:\n', Px), flush_output(),
    format('\nPy[~r]:\n', Py), flush_output(),
    format('\nCx[~r]:\n', Cx), flush_output(),
    format('\nCy[~r]:\n', Cy), flush_output().

increment(X, X1):-
    X1 is X+1.
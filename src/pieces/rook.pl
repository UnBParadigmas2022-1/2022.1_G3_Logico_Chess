:-consult(board).

isRookMoveValid(Turn, Move):-
    (isVerticalEmpty(Move); isHorizontalEmpty(Move);
    isVerticalBackEmpty(Move); isHorizontalBackEmpty(Move)),
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


isVerticalBackEmpty([Px, Py, Cx, Cy]):-
    Px =:= Cx,
    Py =\= Cy, !,
    decrement(Py, X1, 1),
    not(board(Cx, X1, _, _)),
    isVerticalEmpty([Px, X1, Cx, Cy]).
isVerticalEmpty([Px, X1, Cx, Cy]):-
    write('Caminho limpo'),nl.


isHorizontalEmpty([Px, Py, Cx, Cy]):-
    Px =:= Cx,
    Py =\= Cy, !,
    increment(Py, X1, 1),
    not(board(Cx, X1, _, _)),
    isHorizontalEmpty([Px, X1, Cx, Cy]).
isHorizontalEmpty([Px, X1, Cx, Cy]):-
    write('Caminho limpo'),nl.


isHorizontalBackEmpty([Px, Py, Cx, Cy]):-
    Px =:= Cx,
    Py =\= Cy, !,
    decrement(Py, X1, 1),
    not(board(Cx, X1, _, _)),
    isHorizontalEmpty([Px, X1, Cx, Cy]).
isHorizontalEmpty([Px, X1, Cx, Cy]):-
    write('Caminho limpo'),nl.


isSimpleMoveValid(white, [Px, Py, Cx, Cy]):-
    write(' '),nl.


isSimpleMoveValid(black, [Px, Py, Cx, Cy]):-
    write(' '),nl.


increment(X, X1):-
    X1 is X+1.


decrement(X, X1):-
    X1 is X-1.

:-consult(board).
:-discontiguous isDiagonalEmpty/1.

isBishopMoveValid(Turn, Move):- 
    (isDiagonalEmpty(Move)).

isDiagonalEmpty([Px, Py, Cx, Cy]):-
    (Px =\= Cx, Py =\= Cy), !,
    ((Cx > Px, increment(Px, X1, 1)); (Cx < Px, decrement(Px, X1, 1))), 
    ((Cx > Px, increment(Py, Y1, 1)); (Cx < Px, decrement(Py, Y1, 1))),
    not(board(X1, Y1, _, _)),
    isDiagonalEmpty([X1, Y1, Cx, Cy]).

isDiagonalEmpty([X1, Y1, Cx, Cy]):-
    write('Caminho limpo'),nl.

isDiagonalEmpty([X1, Y1, Cx, Cy]):-
    write('Caminho limpo'),nl.

increment(X, X1, Qty):-
    X1 is X + Qty.

decrement(X, X1, Qty):-
    X1 is X - Qty.
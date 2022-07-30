:-consult(board).

isRookMoveValid(Turn, Move):-
    checkingVerticalUp(Turn, Move);
    checkingVerticalDown(Turn, Move);
    checkingHorizontalRight(Turn, Move);
    checkingHorizontalLeft(Turn, Move).


atack(Turn, [Px, Py, Cx, Cy]):-
    Turn == white, !,
    board(Px, Py, _, black).
atack(Turn, [Px, Py, Cx, Cy]):-
    Turn == black,
    board(Px, Py, _, white).

checkingVerticalUp(Turn, [Px, Py, Cx, Cy]):-
    Px == Cx,
    Py < Cy,
    isEmptyVerticalUp(Turn, [Px, Py, Cx, Cy]).

isEmptyVerticalUp(Turn, [Px, Py, Cx, Cy]):-
    increment(Py, X1);
    (X1 =:= Cx ),
    atack(Turn, [Px, Py, Cx, Cy]),
X1 =\= Cy+1, !,
        not(board(Px, X1, _, _)),
        isEmptyVerticalUp(Turn, [Px, X1, Cx, Cy]).
isEmptyVerticalUp(Turn, [Px, X1, Cx, Cy]):-
    Px == Cx,
    X1 == Cy,
    atack(Turn, [Px, X1, Cx, Cy])


checkingVerticalDown(Turn, [Px, Py, Cx, Cy]):-
    Px == Cx,
    Py > Cy,
    isEmptyVerticalDown(Turn, [Px, Py, Cx, Cy]).


isEmptyVerticalDown(Turn, [Px, Py, Cx, Cy]):-
    decrement(Py, X1),
    X1 =\= Cy-1, !,
    (atack(Turn, [Px, X1, Cx, Cy]) ; not(board(Px, X1, _, _))),
    isEmptyVerticalDown(Turn, [Px, X1, Cx, Cy]).
isEmptyVerticalDown(Turn, [Px, X1, Cx, Cy]):-
    Px == Cx,
    X1 == Cy.


checkingHorizontalRight(Turn, [Px, Py, Cx, Cy]):-
    Py == Cy,
    Px < Cx,
    isEmptyHorizontalRight(Turn, [Px, Py, Cx, Cy]).

isEmptyHorizontalRight(Turn, [Px, Py, Cx, Cy]):-
    increment(Px, X1),
    X1 =\= Cx+1, !,
    (atack(Turn, [X1, Py, Cx, Cy]) ; not(board(X1,Py, _, _))),
    isEmptyHorizontalRight(Turn, [X1, Py, Cx, Cy]).
isEmptyHorizontalRight(Turn, [X1, Py, Cx, Cy]):-
    X1 == Cx,
    Py == Cy.

checkingHorizontalLeft(Turn, [Px, Py, Cx, Cy]):-
    Py == Cy,
    Px > Cx,
    isEmptyHorizontalLeft(Turn, [Px, Py, Cx, Cy]).

isEmptyHorizontalLeft(Turn, [Px, Py, Cx, Cy]):-
    decrement(Px, X1),
    X1 =\= Cx-1, !,
    (atack(Turn, [X1, Py, Cx, Cy]) ; not(board(X1,Py, _, _))),
    isEmptyHorizontalLeft(Turn, [X1, Py, Cx, Cy]).
isEmptyHorizontalLeft(Turn, [X1, Py, Cx, Cy]):-
    X1 == Cx,
    Py == Cy.


increment(X, X1):-
    X1 is X+1.

decrement(X, X1):-
    X1 is X-1.


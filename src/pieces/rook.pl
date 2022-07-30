:-consult(board).

isRookMoveValid(Turn, Move):-
    verificaVerticalFront(Move);
    verificaVerticalDown(Move);
    verificaHorizontalRight(Move);
    verificaHorizontalLeft(Move).


verificaVerticalFront([Px, Py, Cx, Cy]):-
    Px == Cx,
    Py < Cy,
    write('Sou Vertical Front'),nl,
    isVerticalFrontEmpty([Px, Py, Cx, Cy]).

verificaVerticalDown([Px, Py, Cx, Cy]):-
    Px == Cx,
    Py > Cy,
    write('Sou Vertical Down'),nl,
    isVerticalDownEmpty([Px, Py, Cx, Cy]).

isVerticalFrontEmpty([Px, Py, Cx, Cy]):-
    increment(Py, X1),
    X1 =\= Cy+1, !,
    not(board(Px, X1, _, _)),
    isVerticalFrontEmpty([Px, X1, Cx, Cy]).
isVerticalFrontEmpty([Px, X1, Cx, Cy]):-
    Px == Cx,
    X1 == Cy.

isVerticalDownEmpty([Px, Py, Cx, Cy]):-
    decrement(Py, X1),
    X1 =\= Cy-1, !,
    not(board(Px, X1, _, _)),
    isVerticalDownEmpty([Px, X1, Cx, Cy]).
isVerticalDownEmpty([Px, X1, Cx, Cy]):-
    Px == Cx,
    X1 == Cy.


verificaHorizontalRight([Px, Py, Cx, Cy]):-
    Py == Cy,
    Px < Cx,
    write('Sou Hozizontal Right'),nl,
    isHorizontalRightEmpty([Px, Py, Cx, Cy]).

isHorizontalRightEmpty([Px, Py, Cx, Cy]):-
    increment(Px, X1),
    X1 =\= Cx+1, !,
    not(board(X1,Py, _, _)),
    isHorizontalRightEmpty([X1, Py, Cx, Cy]).
isHorizontalRightEmpty([X1, Py, Cx, Cy]):-
    X1 == Cx,
    Py == Cy.

verificaHorizontalLeft([Px, Py, Cx, Cy]):-
    Py == Cy,
    Px > Cx,
    write('Sou Hozizontal Left'),nl,
    isHorizontalLeftEmpty([Px, Py, Cx, Cy]).

isHorizontalLeftEmpty([Px, Py, Cx, Cy]):-
    decrement(Px, X1),
    X1 =\= Cx-1, !,
    not(board(X1,Py, _, _)),
    isHorizontalLeftEmpty([X1, Py, Cx, Cy]).
isHorizontalLeftEmpty([X1, Py, Cx, Cy]):-
    X1 == Cx,
    Py == Cy.


increment(X, X1):-
    X1 is X+1.

decrement(X, X1):-
    X1 is X-1.


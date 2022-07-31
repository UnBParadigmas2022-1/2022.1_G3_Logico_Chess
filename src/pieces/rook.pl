isRookMoveValid(_, [Px, Py, Px, Py]):- !, fail.
isRookMoveValid(Turn, [_, _, Cx, Cy]):- board(Cx, Cy, _, Turn, _), !, fail.
isRookMoveValid(Turn, Move):-
    checkVerticalFront(Turn, Move);
    checkVerticalDown(Turn, Move);
    checkHorizontalRight(Turn, Move);
    checkHorizontalLeft(Turn, Move).

attack(Turn, [Px, Py, _, _]):-
    Turn == white, !,
    board(Px, Py, _, black, _).
attack(Turn, [Px, Py, _, _]):-
    Turn == black,
    board(Px, Py, _, white, _).

checkVerticalFront(Turn, [Px, Py, Cx, Cy]):-
    Px == Cx,
    Py < Cy,
    isEmptyVerticalFront(Turn, [Px, Py, Cx, Cy]).

isEmptyVerticalFront(Turn, [Px, Py, Cx, Cy]):-
    increment(Py, X1, 1),
    X1 == Cy;
    increment(Py, XX1, 1),
    not(board(Px, XX1, _, _, _)),
    XX1 =\= Cy+1, !,
    isEmptyVerticalFront(Turn, [Px, XX1, Cx, Cy]).
isEmptyVerticalFront(Turn, [Px, X1, Cx, Cy]):-
    Px == Cx,
    X1 == Cy;
    attack(Turn, [Px, X1, Cx, Cy]).

checkVerticalDown(Turn, [Px, Py, Cx, Cy]):-
    Px == Cx,
    Py > Cy,
    isEmptyVerticalDown(Turn, [Px, Py, Cx, Cy]).

isEmptyVerticalDown(Turn, [Px, Py, Cx, Cy]):-
    decrement(Py, X1, 1),
    X1 == Cy;
    decrement(Py, XX1, 1),
    not(board(Px, XX1, _, _, _)),
    XX1 =\= Cy-1, !,
    isEmptyVerticalDown(Turn, [Px, XX1, Cx, Cy]).
isEmptyVerticalDown(Turn, [Px, X1, Cx, Cy]):-
    Px == Cx,
    X1 == Cy;
    attack(Turn, [Px, X1, Cx, Cy]).


checkHorizontalRight(Turn, [Px, Py, Cx, Cy]):-
    Py == Cy,
    Px < Cx,
    isEmptyHorizontalRight(Turn, [Px, Py, Cx, Cy]).

isEmptyHorizontalRight(Turn, [Px, Py, Cx, Cy]):-
    increment(Px, X1, 1),
    X1 == Cx;
    increment(Px, XX1, 1),
    not(board(XX1,Py, _, _, _)),
    XX1 =\= Cx+1, !,
    isEmptyHorizontalRight(Turn, [XX1, Py, Cx, Cy]).
isEmptyHorizontalRight(Turn, [X1, Py, Cx, Cy]):-
    X1 == Cx,
    Py == Cy;
    attack(Turn, [X1, Py, Cx, Cy]).

checkHorizontalLeft(Turn, [Px, Py, Cx, Cy]):-
    Py == Cy,
    Px > Cx,
    isEmptyHorizontalLeft(Turn, [Px, Py, Cx, Cy]).

isEmptyHorizontalLeft(Turn, [Px, Py, Cx, Cy]):-
    decrement(Px, X1, 1),
    X1 == Cx;
    decrement(Px, XX1, 1),
    not(board(XX1,Py, _, _, _)),
    XX1 =\= Cx-1, !,
    isEmptyHorizontalLeft(Turn, [XX1, Py, Cx, Cy]).
isEmptyHorizontalLeft(Turn, [X1, Py, Cx, Cy]):-
    X1 == Cx,
    Py == Cy;
    attack(Turn, [X1, Py, Cx, Cy]).
:-consult(board).
:-consult(utils).

isRookMoveValid(_, [Px, Py, Px, Py]):- !, fail.
isRookMoveValid(Turn, [_, _, Cx, Cy]):- board(Cx, Cy, _, Turn, _), !, fail.
isRookMoveValid(Turn, Move):-
    verificaVerticalFront(Turn, Move);
    verificaVerticalDown(Turn, Move);
    verificaHorizontalRight(Turn, Move);
    verificaHorizontalLeft(Turn, Move).

atack(Turn, [Px, Py, _, _]):-
    Turn == white, !,
    board(Px, Py, _, black, _).
atack(Turn, [Px, Py, _, _]):-
    Turn == black,
    board(Px, Py, _, white, _).

verificaVerticalFront(Turn, [Px, Py, Cx, Cy]):-
    Px == Cx,
    Py < Cy,
    isVerticalFrontEmpty(Turn, [Px, Py, Cx, Cy]).

isVerticalFrontEmpty(Turn, [Px, Py, Cx, Cy]):-
    increment(Py, X1, 1),
    X1 == Cy;
    increment(Py, XX1, 1),
    not(board(Px, XX1, _, _, _)),
    XX1 =\= Cy+1, !,
    isVerticalFrontEmpty(Turn, [Px, XX1, Cx, Cy]).
isVerticalFrontEmpty(Turn, [Px, X1, Cx, Cy]):-
    Px == Cx,
    X1 == Cy;
    atack(Turn, [Px, X1, Cx, Cy]).

verificaVerticalDown(Turn, [Px, Py, Cx, Cy]):-
    Px == Cx,
    Py > Cy,
    isVerticalDownEmpty(Turn, [Px, Py, Cx, Cy]).

isVerticalDownEmpty(Turn, [Px, Py, Cx, Cy]):-
    decrement(Py, X1, 1),
    X1 == Cy;
    decrement(Py, XX1, 1),
    not(board(Px, XX1, _, _, _)),
    XX1 =\= Cy-1, !,
    isVerticalDownEmpty(Turn, [Px, XX1, Cx, Cy]).
isVerticalDownEmpty(Turn, [Px, X1, Cx, Cy]):-
    Px == Cx,
    X1 == Cy;
    atack(Turn, [Px, X1, Cx, Cy]).  


verificaHorizontalRight(Turn, [Px, Py, Cx, Cy]):-
    Py == Cy,
    Px < Cx,
    isHorizontalRightEmpty(Turn, [Px, Py, Cx, Cy]).

isHorizontalRightEmpty(Turn, [Px, Py, Cx, Cy]):-
    increment(Px, X1, 1),
    X1 == Cx;
    increment(Px, XX1, 1),
    not(board(XX1,Py, _, _, _)),
    XX1 =\= Cx+1, !,
    isHorizontalRightEmpty(Turn, [XX1, Py, Cx, Cy]).
isHorizontalRightEmpty(Turn, [X1, Py, Cx, Cy]):-
    X1 == Cx,
    Py == Cy;
    atack(Turn, [X1, Py, Cx, Cy]).

verificaHorizontalLeft(Turn, [Px, Py, Cx, Cy]):-
    Py == Cy,
    Px > Cx,
    isHorizontalLeftEmpty(Turn, [Px, Py, Cx, Cy]).

isHorizontalLeftEmpty(Turn, [Px, Py, Cx, Cy]):-
    decrement(Px, X1, 1),
    X1 == Cx;
    decrement(Px, XX1, 1),
    not(board(XX1,Py, _, _, _)),
    XX1 =\= Cx-1, !,
    isHorizontalLeftEmpty(Turn, [XX1, Py, Cx, Cy]).
isHorizontalLeftEmpty(Turn, [X1, Py, Cx, Cy]):-
    X1 == Cx,
    Py == Cy;
    atack(Turn, [X1, Py, Cx, Cy]).



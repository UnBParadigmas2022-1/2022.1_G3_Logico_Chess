:-consult(board).

isRookMoveValid(Turn, Move):-
    verificaVerticalFront(Turn, Move);
    verificaVerticalDown(Turn, Move);
    verificaHorizontalRight(Turn, Move);
    verificaHorizontalLeft(Turn, Move).

atack(Turn, [Px, Py, Cx, Cy]):-
    Turn == white, !,
    board(Px, Py, _, black).
atack(Turn, [Px, Py, Cx, Cy]):-
    Turn == black,
    board(Px, Py, _, white).

verificaVerticalFront(Turn, [Px, Py, Cx, Cy]):-
    write('verificaVerticalFront'), nl,
    Px == Cx,
    Py < Cy,
    isVerticalFrontEmpty(Turn, [Px, Py, Cx, Cy]).

isVerticalFrontEmpty(Turn, [Px, Py, Cx, Cy]):-
    write(Py),nl,
    increment(Py, X1),
    not(board(Px, X1, _, _)),
    X1 =\= Cy+1, !,
    isVerticalFrontEmpty(Turn, [Px, X1, Cx, Cy]).
isVerticalFrontEmpty(Turn, [Px, X1, Cx, Cy]):-
    Px == Cx,
    X1 == Cy;
    atack(Turn, [Px, X1, Cx, Cy]).

verificaVerticalDown(Turn, [Px, Py, Cx, Cy]):-
    Px == Cx,
    Py > Cy,
    isVerticalDownEmpty(Turn, [Px, Py, Cx, Cy]).

isVerticalDownEmpty(Turn, [Px, Py, Cx, Cy]):-
    decrement(Py, X1),
    not(board(Px, X1, _, _)),
    X1 =\= Cy-1, !,
    isVerticalDownEmpty(Turn, [Px, X1, Cx, Cy]).
isVerticalDownEmpty(Turn, [Px, X1, Cx, Cy]):-
    Px == Cx,
    X1 == Cy;
    atack(Turn, [Px, X1, Cx, Cy]


verificaHorizontalRight(Turn, [Px, Py, Cx, Cy]):-
    Py == Cy,
    Px < Cx,
    isHorizontalRightEmpty(Turn, [Px, Py, Cx, Cy]).

isHorizontalRightEmpty(Turn, [Px, Py, Cx, Cy]):-
    increment(Px, X1),
    not(board(X1,Py, _, _))),
    X1 =\= Cx+1, !,
    isHorizontalRightEmpty(Turn, [X1, Py, Cx, Cy]).
isHorizontalRightEmpty(Turn, [X1, Py, Cx, Cy]):-
    X1 == Cx,
    Py == Cy;
    atack(Turn, [X1, Py, Cx, Cy]).

verificaHorizontalLeft(Turn, [Px, Py, Cx, Cy]):-
    Py == Cy,
    Px > Cx,
    isHorizontalLeftEmpty(Turn, [Px, Py, Cx, Cy]).

isHorizontalLeftEmpty(Turn, [Px, Py, Cx, Cy]):-
    decrement(Px, X1),
    not(board(X1,Py, _, _)),
    X1 =\= Cx-1, !,
    isHorizontalLeftEmpty(Turn, [X1, Py, Cx, Cy]).
isHorizontalLeftEmpty(Turn, [X1, Py, Cx, Cy]):-
    X1 == Cx,
    Py == Cy;
    atack(Turn, [X1, Py, Cx, Cy]).


increment(X, X1):-
    X1 is X+1.

decrement(X, X1):-
    X1 is X-1.


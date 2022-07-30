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

% Feito atack para o caso de o jogador selecionar uma peça do adversário.
verificaVerticalFront(Turn, [Px, Py, Cx, Cy]):-
    Px == Cx,
    Py < Cy,
    isVerticalFrontEmpty(Turn, [Px, Py, Cx, Cy]).
% Feito atack para o caso de o jogador selecionar uma peça do adversário.
isVerticalFrontEmpty(Turn, [Px, Py, Cx, Cy]):-
    increment(Py, X1),
    X1 =\= Cy+1, !,
    (atack(Turn, [Px, X1, Cx, Cy]) ; not(board(Px, X1, _, _))),
    isVerticalFrontEmpty(Turn, [Px, X1, Cx, Cy]).
isVerticalFrontEmpty(Turn, [Px, X1, Cx, Cy]):-
    Px == Cx,
    X1 == Cy.

% Feito atack para o caso de o jogador selecionar uma peça do adversário.
verificaVerticalDown(Turn, [Px, Py, Cx, Cy]):-
    Px == Cx,
    Py > Cy,
    isVerticalDownEmpty(Turn, [Px, Py, Cx, Cy]).

% Feito atack para o caso de o jogador selecionar uma peça do adversário.
isVerticalDownEmpty(Turn, [Px, Py, Cx, Cy]):-
    decrement(Py, X1),
    X1 =\= Cy-1, !,
    (atack(Turn, [Px, X1, Cx, Cy]) ; not(board(Px, X1, _, _))),
    isVerticalDownEmpty(Turn, [Px, X1, Cx, Cy]).
isVerticalDownEmpty(Turn, [Px, X1, Cx, Cy]):-
    Px == Cx,
    X1 == Cy.


verificaHorizontalRight(Turn, [Px, Py, Cx, Cy]):-
    Py == Cy,
    Px < Cx,
    isHorizontalRightEmpty(Turn, [Px, Py, Cx, Cy]).

isHorizontalRightEmpty(Turn, [Px, Py, Cx, Cy]):-
    increment(Px, X1),
    X1 =\= Cx+1, !,
    (atack(Turn, [X1, Py, Cx, Cy]) ; not(board(X1,Py, _, _))),
    isHorizontalRightEmpty(Turn, [X1, Py, Cx, Cy]).
isHorizontalRightEmpty(Turn, [X1, Py, Cx, Cy]):-
    X1 == Cx,
    Py == Cy.

verificaHorizontalLeft(Turn, [Px, Py, Cx, Cy]):-
    Py == Cy,
    Px > Cx,
    isHorizontalLeftEmpty(Turn, [Px, Py, Cx, Cy]).

isHorizontalLeftEmpty(Turn, [Px, Py, Cx, Cy]):-
    decrement(Px, X1),
    X1 =\= Cx-1, !,
    (atack(Turn, [X1, Py, Cx, Cy]) ; not(board(X1,Py, _, _))),
    isHorizontalLeftEmpty(Turn, [X1, Py, Cx, Cy]).
isHorizontalLeftEmpty(Turn, [X1, Py, Cx, Cy]):-
    X1 == Cx,
    Py == Cy.


increment(X, X1):-
    X1 is X+1.

decrement(X, X1):-
    X1 is X-1.


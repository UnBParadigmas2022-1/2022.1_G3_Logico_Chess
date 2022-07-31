:- consult(utils).

:- dynamic(castling/2).


castling(white, [short, long]).
castling(black, [short, long]).


updateCastling(Turn, Castling) :-
    retract(castling(Turn, _)), assert(castling(Turn, Castling)).


validateCastling(Turn, [Px, Py, Cx, Cy]) :-
    Px < Cx, castling(Turn, Castling),
    member(short, Castling),
    isFreeWay([Px, Py, Cx, Cy], 1, 0).
validateCastling(Turn, [Px, Py, Cx, Cy]) :-
    Px > Cx, castling(Turn, Castling),
    member(long, Castling),
    isFreeWay([Px, Py, Cx, Cy], -1, 0).


isKingMoveValid(_, [Px, Py, Px, Py]) :- fail.
isKingMoveValid(Turn, [_, _, Cx, Cy]) :- board(Cx, Cy, _, Turn, _), !, fail. 
isKingMoveValid(Turn, [Px, Py, Cx, Cy]) :- 
    abs(Px-Cx) =< 1,
    abs(Py-Cy) =< 1, !,
    updateCastling(Turn, []).
isKingMoveValid(Turn, [Px, Py, Cx, Cy]) :-
    abs(Px-Cx) =:= 2, Py == Cy,
    validateCastling(Turn, [Px, Py, Cx, Cy]).

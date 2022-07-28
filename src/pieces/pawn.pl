:-consult(board).

isPawnMoveValid(Turn, Move):-
    nth0(0, Move, PreviousX),
    nth0(1, Move, PreviousY),
    nth0(2, Move, CurrentX),
    nth0(3, Move, CurrentY),
    isTurnMoveValid(Turn, PreviousX, PreviousY, CurrentX, CurrentY).

isTurnMoveValid(white, PreviousX, PreviousY, CurrentX, CurrentY):-
    increment(PreviousY, Y),
    PreviousX == CurrentX,
    CurrentY == Y.

isTurnMoveValid(black, PreviousX, PreviousY, CurrentX, CurrentY):-
    decrement(PreviousY, Y),
    PreviousX == CurrentX,
    CurrentY == Y.

increment(X, X1):-
    X1 is X+1.

decrement(X, X1):-
    X1 is X-1.
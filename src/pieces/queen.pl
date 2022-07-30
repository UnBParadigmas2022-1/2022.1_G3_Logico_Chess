:-consult('board').

isQueenMoveValid(_, [Px, Py, Px, Py]):- fail.
isQueenMoveValid(Turn, [_, _, Cx, Cy]):- board(Cx, Cy, _, Turn, _), !, fail. 
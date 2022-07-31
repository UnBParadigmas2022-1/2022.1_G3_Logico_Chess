isKingMoveValid(_, [Px, Py, Px, Py]):- fail.
isKingMoveValid(Turn, [_, _, Cx, Cy]):- board(Cx, Cy, _, Turn, _), !, fail. 
isKingMoveValid(_, [Px, Py, Cx, Cy]):- 
  abs(Px-Cx) =< 1,
  abs(Py-Cy) =< 1.
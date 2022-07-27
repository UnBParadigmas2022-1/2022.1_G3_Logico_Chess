:- consult(menu).
:- consult('local').


main :-
    showMenu(),
    menuOption(GameMode),
    game(0, GameMode).


game(Turn, GameMode) :-
    readPlayerMove(GameMode, Turn, Move),
    format('Player[~d]: Jogou ', Turn+1), write(Move), nl,
    NextTurn is Turn+1 mod 2,
    game(NextTurn, GameMode).


readPlayerMove(1, Turn, Move) :- readLocalMove(Turn, Move).
readPlayerMove(2, Turn, Move) :- readLocalMove(Turn, Move).         %% TODO: change to socket
readPlayerMove(3, Turn, Move) :- readLocalMove(Turn, Move).
readPlayerMove(4, Turn, Move) :- readLocalMove(Turn, Move).         %% TODO: change to socket

:- consult(menu).
:- consult(move).
:- consult(socket).

main :-
    showMenu(GameMode),
    initGame(GameMode),
    game(0, GameMode).


initGame(GameMode) :- 
    (GameMode == 2 ; GameMode == 4), !,
    initSocketGame(GameMode).
initGame(_) :- !.


game(Turn, GameMode) :-
    prepareTurn(Turn, GameMode),
    readPlayerMove(Turn, Move),
    format(user_output, 'Jogador[~d]: Jogou ', Turn+1), write(user_output, Move), write(user_output, '\n'), flush_output(),
    NextTurn is (Turn+1) mod 2,
    game(NextTurn, GameMode).


prepareTurn(Turn, 2) :- prepareSocketTurn(Turn).
prepareTurn(0, 4) :- prepareSocketTurn(0).
prepareTurn(1, 4) :- set_input(user_input), set_output(user_output). % Change this when computer gamemode is ready
prepareTurn(_, _) :- !.

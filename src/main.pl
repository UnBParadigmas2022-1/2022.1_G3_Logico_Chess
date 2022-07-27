:- consult(menu).
:- consult(move).
:- consult(socket).

main :-
    showMenu(GameMode),
    initGame(GameMode),
    game(white, GameMode).


initGame(GameMode) :- 
    (GameMode == 2 ; GameMode == 4), !,
    initSocketGame(GameMode).
initGame(_) :- !.


game(Turn, GameMode) :-
    prepareTurn(Turn, GameMode),
    readPlayerMove(Turn, Move),
    format(user_output, 'Jogador[~s]: Jogou ', Turn), write(user_output, Move), write(user_output, '\n'), flush_output(),
    changeTurn(Turn, NextTurn),
    game(NextTurn, GameMode).


prepareTurn(Turn, 2) :- prepareSocketTurn(Turn).
prepareTurn(0, 4) :- prepareSocketTurn(0).
prepareTurn(1, 4) :- set_input(user_input), set_output(user_output). % Change this when computer gamemode is ready
prepareTurn(_, _) :- !.


changeTurn(Turn, NewTurn):-
    ( Turn == white
    -> NewTurn = black
    ; NewTurn = white
    ).
:- consult(menu).
:- consult(move).
:- consult(socket).

main :-
    showMenu(GameMode),
    initGame(GameMode),
    game(0, GameMode).


initGame(GameMode) :- 
    (GameMode == 2 ; GameMode == 4), !,
    initSocketGame().
initGame(_) :- !.


game(Turn, GameMode) :-
    prepareTurn(Turn, GameMode),
    readPlayerMove(Turn, Move),
    format(user_output, 'Player[~d]: Jogou ', Turn+1), write(user_output, Move), write(user_output, '\n'), flush_output(),
    NextTurn is (Turn+1) mod 2,
    game(NextTurn, GameMode).


prepareTurn(Turn, GameMode) :-
    (GameMode == 2 ; GameMode == 4), !,
    prepareSocketTurn(Turn).
prepareTurn(_, _) :- !.

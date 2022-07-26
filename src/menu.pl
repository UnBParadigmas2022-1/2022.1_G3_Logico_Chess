:- dynamic(menuOption/1).

drawChar(_,Count) :- Count =< 0, !.
drawChar(Char,Count) :-
    write(Char),
    plus(Count,-1,NewCount),
    drawChar(Char,NewCount).

isOptionValid(Op) :- Op >= 1, Op =< 3, !, assert(menuOption(Op)).


readMenuResponse(Count) :- Count =< 0, !, write('\nMaximo de tentativas alcançado! Encerrando programa.\n'), halt.
readMenuResponse(Count) :-
    read(Op),
    not(isOptionValid(Op)), !,
    write('Opção não encontrada! Tente novamente:\n'),
    plus(Count,-1,NewCount),
    readMenuResponse(NewCount).


showMenu() :-
    drawChar('#',60), nl,
    write('Escolha o modo de jogo:\n'),
    write('[1] - Multiplayer Local\n'),
    write('[2] - Multiplayer Socket\n'),
    write('[3] - Computador\n'),
    drawChar('#',60), nl,
    write('Escolha uma opção:\n'),
    not(readMenuResponse(5)).


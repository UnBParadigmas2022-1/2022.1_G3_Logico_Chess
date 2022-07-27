:- consult(move).

readLocalMove(Turn, Move) :-
    format('\nPlayer[~d]: Insira sua jogada:\n', Turn+1),
    read(MoveReaded),
    name(MoveReaded,MoveList),
    checkMove(Turn, MoveList, Move).

checkMove(Turn, MoveList, Move) :-
    not(isMoveFormatValid(MoveList)), !,
    tty_clear,
    write('Formato de mensagem invalido!\n'),
    write('Informe a posição atual e pra onde quer ir no seguinte formato: OrigemDestino!\n'),
    write('Exemplo: e2f5\n'),
    readLocalMove(Turn, Move).
checkMove(_, MoveList, Move) :- parseMove(MoveList, Move), tty_clear.
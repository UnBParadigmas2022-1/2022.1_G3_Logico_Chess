
readPlayerMove(Turn, Move) :-
    format('\nJogador[~d]: Insira sua jogada:\n', Turn+1), flush_output(),
    read(MoveReaded),
    name(MoveReaded,MoveList),
    checkMove(Turn, MoveList, Move).

checkMove(Turn, MoveList, Move) :-
    not(isMoveFormatValid(MoveList)), !,
    write('\nFormato de mensagem invalido!\n'),
    write('Informe a posicao atual e pra onde quer ir no seguinte formato: OrigemDestino!\n'),
    write('Exemplo: e2f5\n'), flush_output(),
    readPlayerMove(Turn, Move).
checkMove(_, MoveList, Move) :- parseMove(MoveList, Move).


parseMove([A,B,C,D], Move) :-
    AA is A-97, BB is B-49,
    CC is C-97, DD is D-49,
    Move = [AA, BB, CC, DD].


isLetterValid(Letter) :- Letter >= 97, Letter =< 104.       %% 'a' <= Letter <= 'h'
isNumberValid(Number) :- Number >= 49, Number =< 56.        %% '0' <= Number <= '8'


isMoveFormatValid([A,B,C,D]) :-                             %% A move is valid if is in this format: [a-h][0-8][a-h][0-8]
    isLetterValid(A), isNumberValid(B),
    isLetterValid(C), isNumberValid(D).
isMoveFormatValid(_) :- fail.

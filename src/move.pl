:- consult(board).
:- consult(pieces/pawn).
:- consult(pieces/knight).
:- discontiguous playerMove/2.

playerMove(Turn, Move) :-
    readMove(Turn, Move),
    isPieceValid(Turn, Move, Piece),
    isMoveValid(Turn, Move, Piece), !,
    updateBoard(Move, Piece, Turn).
playerMove(Turn, Move) :-
    writeln("Jogada invalida"),flush_output(),
    playerMove(Turn, Move).


isMoveValid(Turn, Move, pawn) :- isPawnMoveValid(Turn, Move).
isMoveValid(Turn, Move, knight) :- isKnightMoveValid(Turn, Move).


readMove(Turn, Move) :-
    format('\nJogador[~s]: Insira sua jogada:\n', Turn), flush_output(),
    read(MoveReaded),
    name(MoveReaded,MoveList),
    isMoveFormatValid(MoveList), !,
    parseMove(MoveList, Move).
readMove(Turn, Move) :-
    write('\nFormato de mensagem invalido!\n'),
    write('Informe a posicao atual e pra onde quer ir no seguinte formato: OrigemDestino!\n'),
    write('Exemplo: e2f5\n'), flush_output(),
    readMove(Turn, Move).


parseMove([A,B,C,D], Move) :-
    AA is A-97, BB is B-49,
    CC is C-97, DD is D-49,
    Move = [AA, BB, CC, DD].


isLetterValid(Letter) :- Letter >= 97, Letter =< 104.       % 'a' <= Letter <= 'h'
isNumberValid(Number) :- Number >= 49, Number =< 56.        % '0' <= Number <= '8'


isMoveFormatValid([A,B,C,D]) :-                             % A move is valid if is in this format: [a-h][0-8][a-h][0-8]
    isLetterValid(A), isNumberValid(B),
    isLetterValid(C), isNumberValid(D).
isMoveFormatValid(_) :- fail.
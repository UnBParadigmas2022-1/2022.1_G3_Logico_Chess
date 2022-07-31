:- consult(pieces/pawn).
:- consult(pieces/knight).
:- consult(pieces/bishop).
:- consult(pieces/queen).
:- consult(pieces/rook).
:- consult(pieces/king).


playerMove(Turn, [Sx, Sy, X, Y]) :-
    isPieceValid(Sx, Sy, Piece, Turn),
    isMoveValid(Turn, [Sx, Sy, X, Y], Piece),
    \+isCheck(Turn, [Sx, Sy, X, Y]).


isMoveValid(Turn, Move, pawn) :- isPawnMoveValid(Turn, Move).
isMoveValid(Turn, Move, knight) :- isKnightMoveValid(Turn, Move).
isMoveValid(Turn, Move, bishop) :- isBishopMoveValid(Turn, Move).
isMoveValid(Turn, Move, queen) :- isQueenMoveValid(Turn, Move).
isMoveValid(Turn, Move, rook) :- isRookMoveValid(Turn, Move).
isMoveValid(Turn, Move, king) :- isKingMoveValid(Turn, Move).

invertLocalTurn(white, black).
invertLocalTurn(black, white).


snapshotMove(Move, Turn, Fen) :-
    updateBoard(Move, _),
    board_to_fen(Turn, Fen).


isCheck(Turn, Move) :-
    snapshot(snapshotMove(Move, Turn, Fen)),
    start_stockfish(Stockfish, Out),
    is_check(Stockfish, Out, Fen),
    writeln('Posicao invalida, o jogar esta em check!').


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


parseMove([40|_], Move) :- Move = [40].
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

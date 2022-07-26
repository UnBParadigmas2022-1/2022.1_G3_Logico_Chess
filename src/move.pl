
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
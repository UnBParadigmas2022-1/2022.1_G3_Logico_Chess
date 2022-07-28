% start_stockfish/2 -> Cria pipes stdin e stdout para comunicação com o stockfish
start_stockfish(Stockfish, Out) :-
    process_create(path(stockfish), [], [stdin(pipe(Stockfish)), stdout(pipe(Out))]).

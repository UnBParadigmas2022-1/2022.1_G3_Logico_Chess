% start_stockfish/2 -> Cria pipes stdin e stdout para comunicação com o stockfish
start_stockfish(Stockfish, Out) :-
    process_create(path(stockfish), [], [stdin(pipe(Stockfish)), stdout(pipe(Out))]).

% send_command/2 -> Envia comando SEM retorno de terminal (stdin não é fechada)
send_command(Stockfish, Command) :-
    writeln(Stockfish, Command),
    flush_output(Stockfish).

% read_output/2 -> Prepara leitura de stdout com lista de códigos
% read_output/3 -> Converte valor para letra e salva na lista
read_output(Out, Lines) :-
    read_line_to_codes(Out, Codes),
    read_output(Out, Codes, Lines).

read_output(_, end_of_file, []) :- !.
read_output(Out, Codes, [Line|Lines]) :-
    atom_codes(Line, Codes),
    read_line_to_codes(Out, Next),
    read_output(Out, Next, Lines).

% set_fen_position/2 -> Comando que seta posição no stockfish no formato fen
set_fen_position(Stockfish, Fen) :-
    atomics_to_string(['position', 'fen', Fen], " ", Command),
    send_command(Stockfish, Command).

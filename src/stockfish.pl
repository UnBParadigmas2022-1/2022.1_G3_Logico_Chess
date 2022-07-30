:- consult(board).


% start_stockfish/2 -> Cria pipes stdin e stdout para comunicação com o stockfish
start_stockfish(Stockfish, Out) :-
    process_create(path(stockfish), [], [stdin(pipe(Stockfish)), stdout(pipe(Out))]).


% close_stockfish/2 -> Finaliza o stockfish fechando as duas streams
close_stockfish(Stockfish, Out) :-
    close_stream(Stockfish); close_stream(Out).


% close_stream/1 -> Valida se uma stream está aberta e finaliza
close_stream(Stream) :-
    is_stream(Stream), close(Stream).


% send_command/2 -> Envia comando SEM retorno de terminal (stdin não é fechada)
% send_command/4 -> Envia comando COM retorno de terminal (nesse caso é preciso fechar o stdin)
send_command(Stockfish, Command) :-
    writeln(Stockfish, Command),
    flush_output(Stockfish).


send_command(Stockfish, Out, Command, Lines) :-
    send_command(Stockfish, Command),
    sleep(1),
    close_stream(Stockfish),
    read_output(Out, Lines).


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


% get_best_move/5 -> Comando que acha o melhor movimento, de acordo com
% a posição Fen passada e o tempo de busca Time (milessegundos)
get_best_move(Stockfish, Out, Fen, Time, Move) :-
    set_fen_position(Stockfish, Fen),
    atomics_to_string(['go', 'movetime', Time], " ", Command),
    send_command(Stockfish, Out, Command, Lines),
    last(Lines, Line),
    split_string(Line, " ", "", Last), last(Last, String),
    name(String, Move),
    close_stockfish(Stockfish, Out).


% get_evaluation/4 -> Comando que calcula a vantagem no jogo, de
% acordo com a posição Fen passada
get_evaluation(Stockfish, Out, Fen, Eval) :-
    set_fen_position(Stockfish, Fen),
    send_command(Stockfish, Out, 'eval', Lines),
    reverse(Lines, ReverseLines),
    nth0(1, ReverseLines, Line),
    split_string(Line, " ", "", Last),
    reverse(Last, ReverseLast),
    nth0(7, ReverseLast, Eval),
    close_stockfish(Stockfish, Out).


% case_piece/3 -> Retorna se é upper ou down case o atom da peça
case_piece(Piece, white, Value) :- upcase_atom(Piece, Value), !.
case_piece(Piece, black, Value) :- downcase_atom(Piece, Value).


% format_piece/3 -> Pega a peça e retorna sua inicial de acordo com sua cor
format_piece(Y, X, Letter) :-
    (
        board(X, Y, Piece, Color),
        case_piece(Piece, Color, Cased)),
        atom_chars(Cased, [Letter|_]
    ), !;
    Letter is 1.

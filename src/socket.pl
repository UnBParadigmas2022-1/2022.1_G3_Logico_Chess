:- use_module(socket).

:- consult(move).

%  clients(Turn, Socket, StreamIn, StreamOut)
:- dynamic(clients/4).


initSocketGame(2) :-
    % write('\nInsira o IP do servidor:\n'),
    % read(Ip),
    % write('\nInsira a porta do servidor:\n'),
    % read(Port),
    createClient(localhost, 2503).
initSocketGame(3) :-
    % write('\nInsira o IP do servidor:\n'),
    % read(Ip),
    % write('\nInsira a porta do servidor:\n'),
    % read(Port),
    createServer(localhost, 2503, AcceptFd),
    acceptClient(AcceptFd, black).
    % prepareSocketTurn(black).
initSocketGame(_).


% prepareSocketTurn(Turn) :-
%     clients(Turn, _, StreamIn, StreamOut),
%     set_input(StreamIn),
%     set_output(StreamOut).


createServer(Ip, Port, AcceptFd) :- 
    tcp_socket(Socket),
    tcp_setopt(Socket, reuseaddr),
    tcp_bind(Socket, Ip:Port),
    tcp_listen(Socket, 2),
    tcp_open_socket(Socket, AcceptFd, _),
    format('Aguardando jogadores no endereço ~s:~d\n', [Ip, Port]).


createClient(Ip, Port) :-
    tcp_socket(Socket),
    tcp_connect(Socket, Ip:Port),
    tcp_open_socket(Socket, StreamIn, StreamOut),
    set_input(StreamIn),
    set_output(StreamOut),
    writeln([StreamIn, StreamOut]).
    % read_pending_codes(StreamIn, _, _).


acceptClient(AcceptFd, Turn) :-
    format('Jogador[~s]: Aguardando conexão\n', Turn),
    tcp_accept(AcceptFd, Socket, _),
    tcp_open_socket(Socket, StreamIn, StreamOut),
    format('Jogador[~s]: Conectado\n', Turn),
    assert(clients(Turn, Socket, StreamIn, StreamOut)),
    set_input(StreamIn),
    set_output(StreamOut).
    % read_pending_codes(StreamIn, _, _).


closeClients() :- findall(S, clients(_,S,_,_), L), closeClient(L).


closeClient([]) :- !.
closeClient([S]) :- tcp_close_socket(S).
closeClient([H|T]) :- closeClient([H]), closeClient(T).


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


playerSocketMove(white, PlayerMove, SocketMove) :-
    read_pending_codes(current_input, _, _),
    invertLocalTurn(white, LocalPlayerTurn),
    % prepareSocketTurn(Turn),
    deparseMove(PlayerMove, Move),
    writeln(user_output, Move),
    writeln(Move), flush_output(),
    read_line_to_codes(current_input,Cs),
    % atom_codes(SocketResponseMove, Cs),
    writeln(user_output, Cs),
    % name(SocketResponseMove, SocketMoveList),
    % writeln(user_output, SocketMoveList),
    parseMove(Cs, SocketMove).
playerSocketMove(black, PlayerMove, SocketMove) :-
    read_pending_codes(current_input, _, _),
    invertLocalTurn(black, LocalPlayerTurn),
    % prepareSocketTurn(Turn),
    deparseMove(PlayerMove, Move),
    read_line_to_codes(current_input,Cs),
    writeln(user_output, Move),
    writeln(Move), flush_output(),
    % atom_codes(SocketResponseMove, Cs),
    writeln(user_output, Cs),
    % name(SocketResponseMove, SocketMoveList),
    % writeln(user_output, SocketMoveList),
    parseMove(Cs, SocketMove).

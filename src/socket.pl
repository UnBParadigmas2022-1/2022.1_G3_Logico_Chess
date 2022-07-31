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
initSocketGame(_).


prepareSocketTurn(Turn) :-
    clients(Turn, _, StreamIn, StreamOut),
    set_input(StreamIn),
    set_output(StreamOut).


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
    assert(clients(white, Socket, StreamIn, StreamOut)).


acceptClient(AcceptFd, Turn) :-
    format('Jogador[~s]: Aguardando conexão\n', Turn),
    tcp_accept(AcceptFd, Socket, _),
    tcp_open_socket(Socket, StreamIn, StreamOut),
    format('Jogador[~s]: Conectado\n', Turn),
    assert(clients(Turn, Socket, StreamIn, StreamOut)).


closeClients() :- findall(S, clients(_,S,_,_), L), closeClient(L).


closeClient([]) :- !.
closeClient([S]) :- tcp_close_socket(S).
closeClient([H|T]) :- closeClient([H]), closeClient(T).


waitServerFirstMove(2, Move) :-
    read_pending_codes(current_input, _, _),
    readSocketMove(Move),
    applyMove(1, Move).
waitServerFirstMove(_, _).


readSocketMove(Move) :-
    prepareSocketTurn(white),
    read_line_to_codes(current_input, MoveReaded),
    parseMove(MoveReaded, Move),
    writeln(user_output, ['Recebendo', MoveReaded]).


sendPlayerSocketMove(Turn, PlayerMove) :-
    prepareSocketTurn(Turn),
    deparseMove(PlayerMove, Move),
    writeln(user_output, ['Enviando ', Move]),
    writeln(Move), flush_output().

:- use_module(socket).

:- consult(move).

%  clients(Turn, Socket, StreamIn, StreamOut)
:- dynamic(clients/4).


initSocketGame(3) :-
    write('\nInsira o IP do servidor:\n'),
    read(Ip),
    write('\nInsira a porta do servidor:\n'),
    read(Port),
    createServer(Ip, Port, AcceptFd),
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


playerSocketMove(Turn, PlayerMove, SocketMove) :-
    invertLocalTurn(Turn, LocalPlayerTurn),
    prepareSocketTurn(Turn),
    deparseMove(PlayerMove, Move),
    writeln(PlayerMove), flush_output(),
    read(SocketResponseMove),
    writeln(user_output, SocketResponseMove),
    name(SocketResponseMove, SocketMoveList),
    parseMove(SocketMoveList, SocketMove).

:- use_module(socket).

:- dynamic(clients/3).


createServer(Port, AcceptFd) :- 
    tcp_socket(Socket),
    tcp_bind(Socket, Port),
    tcp_listen(Socket, 2),
    tcp_open_socket(Socket, AcceptFd, _).


acceptClient(AcceptFd, Turn) :-
    format('Player[~d]: Aguardando conexão\n', Turn+1),
    tcp_accept(AcceptFd, Socket, Peer),
    format('Player[~d]: Conectado\n', Turn+1),
    assert(clients(Turn, Socket, Peer)).

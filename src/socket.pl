:- use_module(socket).

:- dynamic(clients/4).


createServer(Port, AcceptFd) :- 
    tcp_socket(Socket),
    tcp_setopt(Socket, reuseaddr),
    tcp_bind(Socket, Port),
    tcp_listen(Socket, 2),
    tcp_open_socket(Socket, AcceptFd, _).


acceptClient(AcceptFd, Turn) :-
    format('Player[~d]: Aguardando conexão\n', Turn+1),
    tcp_accept(AcceptFd, Socket, _),
    tcp_open_socket(Socket, StreamIn, StreamOut),
    format('Player[~d]: Conectado\n', Turn+1),
    assert(clients(Turn, Socket, StreamIn, StreamOut)).


closeClients() :- findall(S, clients(_,S,_,_), L), closeClient(L).

closeClient([]) :- !.
closeClient([S]) :- tcp_close_socket(S).
closeClient([H|T]) :- closeClient([H]), closeClient(T).
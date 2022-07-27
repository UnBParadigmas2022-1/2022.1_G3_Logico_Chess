:- use_module(socket).

:- dynamic(clients/4).


initSocketGame(GameMode) :-
    write('\nInsira a porta do servidor:\n'),
    read(Port),
    createServer(Port, AcceptFd),
    acceptClient(AcceptFd, 0),
    GameMode == 2, !,
    acceptClient(AcceptFd, 1).
initSocketGame(_) :- !.

prepareSocketTurn(Turn) :-
    clients(Turn, _, StreamIn, StreamOut),
    set_input(StreamIn),
    set_output(StreamOut).


createServer(Port, AcceptFd) :- 
    tcp_socket(Socket),
    tcp_setopt(Socket, reuseaddr),
    tcp_bind(Socket, Port),
    tcp_listen(Socket, 2),
    tcp_open_socket(Socket, AcceptFd, _),
    format('Aguardando jogadores na porta ~d\n', Port).


acceptClient(AcceptFd, Turn) :-
    format('Jogador[~d]: Aguardando conexão\n', Turn+1),
    tcp_accept(AcceptFd, Socket, _),
    tcp_open_socket(Socket, StreamIn, StreamOut),
    format('Jogador[~d]: Conectado\n', Turn+1),
    assert(clients(Turn, Socket, StreamIn, StreamOut)).


closeClients() :- findall(S, clients(_,S,_,_), L), closeClient(L).

closeClient([]) :- !.
closeClient([S]) :- tcp_close_socket(S).
closeClient([H|T]) :- closeClient([H]), closeClient(T).

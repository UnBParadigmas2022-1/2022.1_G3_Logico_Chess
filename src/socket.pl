:- use_module(socket).

:- consult(move).

%  clients(Turn, Socket, StreamIn, StreamOut)
:- dynamic(clients/4).

gamemodeTurnEnemy(2, white).
gamemodeTurnEnemy(3, black).

initSocketGame(2) :-
    write('\nInsira o IP do servidor:\n'),
    read(Ip),
    write('\nInsira a porta do servidor:\n'),
    read(Port),
    gamemodeTurnEnemy(2, Enemy),
    createClient(Ip, Port, Enemy),
    thread_create(receiveSocketMove, _).
initSocketGame(3) :-
    write('\nInsira o IP do servidor:\n'),
    read(Ip),
    write('\nInsira a porta do servidor:\n'),
    read(Port),
    gamemodeTurnEnemy(3, Enemy),
    createServer(Ip, Port, AcceptFd),
    acceptClient(AcceptFd, Enemy),
    thread_create(receiveSocketMove, _).
initSocketGame(_).


createServer(Ip, Port, AcceptFd) :- 
    tcp_socket(Socket),
    tcp_setopt(Socket, reuseaddr),
    tcp_bind(Socket, Ip:Port),
    tcp_listen(Socket, 2),
    tcp_open_socket(Socket, AcceptFd, _),
    format('Aguardando jogadores no endereço ~s:~d\n', [Ip, Port]).


createClient(Ip, Port, Enemy) :-
    tcp_socket(Socket),
    tcp_connect(Socket, Ip:Port),
    tcp_open_socket(Socket, StreamIn, StreamOut),
    assert(clients(Enemy, Socket, StreamIn, StreamOut)).


acceptClient(AcceptFd, Enemy) :-
    format('Jogador[~s]: Aguardando conexão\n', Enemy),
    tcp_accept(AcceptFd, Socket, _),
    tcp_open_socket(Socket, StreamIn, StreamOut),
    format('Jogador[~s]: Conectado\n', Enemy),
    assert(clients(Enemy, Socket, StreamIn, StreamOut)).


closeClients() :- findall(S, clients(_,S,_,_), L), closeClient(L).


closeClient([]) :- !.
closeClient([S]) :- tcp_close_socket(S).
closeClient([H|T]) :- closeClient([H]), closeClient(T).


receiveSocketMove :-
    gamemode(GameMode),
    gamemodeTurnEnemy(GameMode, Turn),
    readSocketMove(Move, Turn),
    applyMove(1, Move),
    receiveSocketMove.


readSocketMove(Move, Turn) :-
    clients(Turn, _, StremIn, _),
    writeln(user_output, ['Aguardando jogada do inimigo', Turn]),
    read_line_to_codes(StremIn, MoveReaded),
    parseMove(MoveReaded, Move),
    writeln(user_output, ['Recebendo', Move]).


sendPlayerSocketMove(Turn, PlayerMove) :-
    clients(Turn, _, _, StreamOut),
    deparseMove(PlayerMove, Move),
    writeln(user_output, ['Enviando', Move]),
    writeln(StreamOut, Move), flush_output(StreamOut).

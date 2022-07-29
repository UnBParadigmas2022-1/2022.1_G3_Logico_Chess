:- consult(board).

:- use_module(library(pce)).
:- pce_image_directory('../assets').


:- dynamic(selected/4). % selected(X, Y, Ref, Turn)
:- dynamic(turn/1).     % turn(Turn)


resource(res_wp, image, image('wp.xpm')).
resource(res_bp, image, image('bp.xpm')).
resource(res_wr, image, image('wr.xpm')).
resource(res_br, image, image('br.xpm')).
resource(res_wn, image, image('wn.xpm')).
resource(res_bn, image, image('bn.xpm')).
resource(res_wb, image, image('wb.xpm')).
resource(res_bb, image, image('bb.xpm')).
resource(res_wk, image, image('wk.xpm')).
resource(res_bk, image, image('bk.xpm')).
resource(res_wq, image, image('wq.xpm')).
resource(res_bq, image, image('bq.xpm')).


piece(pawn, white, res_wp).
piece(pawn, black, res_bp).
piece(rook, white, res_wr).
piece(rook, black, res_br).
piece(knight, white, res_wn).
piece(knight, black, res_bn).
piece(bishop, white, res_wb).
piece(bishop, black, res_bb).
piece(queen, white, res_wq).
piece(queen, black, res_bq).
piece(king, white, res_wk).
piece(king, black, res_bk).


initGameGui(Gamemode, Game, Turn) :-
    assert(turn(Turn)),
    startGui(Gamemode, Game).
    

startGui(Gamemode, Game) :-
    new(@dark, colour(@default, 30583, 38293, 22102)),
    new(@light, colour(@default, 60395, 60652, 53456)),
    new(@selected, colour(@default, 30840, 30840, 24672)),
    new(@Display, window('Chess', size(800,800))),
    drawBoard(@Display, Gamemode, Game),
    drawPieces(@Display),
    send(@Display, open).


drawBoard(Display, Gamemode, Game) :- draw(Display, 8, 8, 0, Gamemode, Game).


draw(_, _, Height, Y, _, _) :- Y == Height.
draw(Display, Width, Height, Y, Gamemode, Game) :-
    drawLine(Display, 0, Y, Width, Gamemode, Game),
    plus(Y,1,YY),
    draw(Display, Width, Height, YY, Gamemode, Game).


drawLine(_, X, _, Width, _, _) :- X == Width.
drawLine(Display, X, Y, Width, Gamemode, Game) :-
    NewY is abs(Y-7),
    send(Display, display,
        new(Ref, box(100,100)), point(X*100, Y*100)), 
    drawBoxColor(Ref, X, Y),
    send(Ref, recogniser,
        click_gesture(left, '', single,
            message(@prolog, boxClickEvent, Gamemode, X, NewY, Ref, Game))),
    plus(X,1,XX),
    drawLine(Display, XX, Y, Width, Gamemode, Game).


boxClickEvent(Gamemode, X, Y, Ref, Game) :-
    turn(Turn),
    call(Game, GameMode, X, Y, Turn, Ref).


changeTurn(white) :- retract(turn(_)), assert(turn(black)).
changeTurn(black) :- retract(turn(_)), assert(turn(white)).


selectBox(X, Y, Turn, Box) :-
    assert(selected(X, Y, Box, Turn)),
    send(Box, fill_pattern, @selected).


deselectBox(X, Y, Box) :-
    retract(selected(_, _, _, _)),
    mod(X, 2) =:= mod(Y, 2),
    send(Box, fill_pattern, @dark);
    send(Box, fill_pattern, @light).


movePiece(Ref, X, Y) :-
    NewY is abs(Y-7),
    board(X, Y, _, _, Ref),
    send(Ref, move, point(X*100, NewY*100)).


removePiece(X, Y) :-
    board(X, Y, _, _, Ref), !,
    free(Ref).
removePiece(_, _).


drawBoxColor(Ref, X, Y) :-
    mod(X, 2) =:= mod(Y, 2),
    send(Ref, fill_pattern, @light);
    send(Ref, fill_pattern, @dark).


drawPieces(Display) :-
    findall([X,Y,Z,W], board(X,Y,Z,W),L),
    drawPiece(Display, L).


drawPiece(_, []) :- !.
drawPiece(Display, [[X,Y,Piece,Color]]) :-
    piece(Piece, Color, Res),
    NewY is abs(Y-7),
    send(Display, display,
        new(Ref, bitmap(resource(Res))), point(X*100, NewY*100)),
    assert(board(X,Y,Piece,Color,Ref)).
drawPiece(Display, [Head|Tail]) :-
    drawPiece(Display, [Head]),
    drawPiece(Display, Tail).



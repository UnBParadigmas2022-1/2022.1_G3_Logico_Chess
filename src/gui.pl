:- consult(board).

:- use_module(library(pce)).
:- pce_image_directory('../assets').


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


drawpieces(Display, []).

drawBox(Display, Ref, Color, X, Y) :-
    send(Display, display,
        new(Ref, box(100,100)), point(X*100, Y*100)),
            send(Ref, fill_pattern, Color).


drawPieces(Display) :-
    findall([X,Y,Z,W], board(X,Y,Z,W),L),
    drawPiece(Display, L).


drawPiece(Display, []) :- !.

drawPiece(Display, [[X,Y,Piece,Color]]) :-
    piece(Piece, Color, Res),
    NewY is abs(Y-7),
    send(Display, display,
        new(Ref, bitmap(resource(Res))), point(X*100, NewY*100)),
    assert(board(X,Y,Piece,Color,Ref)).
    
drawPiece(Display, [Head|Tail]) :-
    drawPiece(Display, [Head]),
    drawPiece(Display, Tail).


start :-
    new(@Display, window('Chess', size(800,800))),
        drawBox(@Display, @a1, colour(white), 0, 0),
        drawBox(@Display, @a2, colour(orange), 0, 1),
        drawBox(@Display, @a3, colour(white), 0, 2),
        drawBox(@Display, @a4, colour(orange), 0, 3),
        drawBox(@Display, @a5, colour(white), 0, 4),
        drawBox(@Display, @a6, colour(orange), 0, 5),
        drawBox(@Display, @a7, colour(white), 0, 6),
        drawBox(@Display, @a8, colour(orange), 0, 7),
        drawBox(@Display, @b1, colour(orange), 1, 0),
        drawBox(@Display, @b2, colour(white), 1, 1),
        drawBox(@Display, @b3, colour(orange), 1, 2),
        drawBox(@Display, @b4, colour(white), 1, 3),
        drawBox(@Display, @b5, colour(orange), 1, 4),
        drawBox(@Display, @b6, colour(white), 1, 5),
        drawBox(@Display, @b7, colour(orange), 1, 6),
        drawBox(@Display, @b8, colour(white), 1, 7),
        drawBox(@Display, @c1, colour(white), 2, 0),
        drawBox(@Display, @c2, colour(orange), 2, 1),
        drawBox(@Display, @c3, colour(white), 2, 2),
        drawBox(@Display, @c4, colour(orange), 2, 3),
        drawBox(@Display, @c5, colour(white), 2, 4),
        drawBox(@Display, @c6, colour(orange), 2, 5),
        drawBox(@Display, @c7, colour(white), 2, 6),
        drawBox(@Display, @c8, colour(orange), 2, 7),
        drawBox(@Display, @d1, colour(orange), 3, 0),
        drawBox(@Display, @d2, colour(white), 3, 1),
        drawBox(@Display, @d3, colour(orange), 3, 2),
        drawBox(@Display, @d4, colour(white), 3, 3),
        drawBox(@Display, @d5, colour(orange), 3, 4),
        drawBox(@Display, @d6, colour(white), 3, 5),
        drawBox(@Display, @d7, colour(orange), 3, 6),
        drawBox(@Display, @d8, colour(white), 3, 7),
        drawBox(@Display, @e1, colour(white), 4, 0),
        drawBox(@Display, @e2, colour(orange), 4, 1),
        drawBox(@Display, @e3, colour(white), 4, 2),
        drawBox(@Display, @e4, colour(orange), 4, 3),
        drawBox(@Display, @e5, colour(white), 4, 4),
        drawBox(@Display, @e6, colour(orange), 4, 5),
        drawBox(@Display, @e7, colour(white), 4, 6),
        drawBox(@Display, @e8, colour(orange), 4, 7),
        drawBox(@Display, @f1, colour(orange), 5, 0),
        drawBox(@Display, @f2, colour(white), 5, 1),
        drawBox(@Display, @f3, colour(orange), 5, 2),
        drawBox(@Display, @f4, colour(white), 5, 3),
        drawBox(@Display, @f5, colour(orange), 5, 4),
        drawBox(@Display, @f6, colour(white), 5, 5),
        drawBox(@Display, @f7, colour(orange), 5, 6),
        drawBox(@Display, @f8, colour(white), 5, 7),
        drawBox(@Display, @g1, colour(white), 6, 0),
        drawBox(@Display, @g2, colour(orange), 6, 1),
        drawBox(@Display, @g3, colour(white), 6, 2),
        drawBox(@Display, @g4, colour(orange), 6, 3),
        drawBox(@Display, @g5, colour(white), 6, 4),
        drawBox(@Display, @g6, colour(orange), 6, 5),
        drawBox(@Display, @g7, colour(white), 6, 6),
        drawBox(@Display, @g8, colour(orange), 6, 7),
        drawBox(@Display, @h1, colour(orange), 7, 0),
        drawBox(@Display, @h2, colour(white), 7, 1),
        drawBox(@Display, @h3, colour(orange), 7, 2),
        drawBox(@Display, @h4, colour(white), 7, 3),
        drawBox(@Display, @h5, colour(orange), 7, 4),
        drawBox(@Display, @h6, colour(white), 7, 5),
        drawBox(@Display, @h7, colour(orange), 7, 6),
        drawBox(@Display, @h8, colour(white), 7, 7),
        drawPieces(@Display),
        send(@Display, open).
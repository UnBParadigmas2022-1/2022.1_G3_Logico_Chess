:- consult(board).

:- use_module(library(pce)).
:- pce_image_directory('../assets').


:- dynamic(selected/4). % selected(X, Y, Ref, Turn)
:- dynamic(turn/1).     % turn(Turn)


% Load pictures
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

% Associate pictures with their pieces
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


initGameGui(Game, Turn) :-
    assert(turn(Turn)),
    startGui(Game).
    

startGui(Game) :-
    % Create custom colours
    new(@dark, colour(@default, 30583, 38293, 22102)),
    new(@light, colour(@default, 60395, 60652, 53456)),
    new(@selected, colour(@default, 30840, 30840, 24672)),
    % Create and start the window
    new(Display, window('Chess', size(800,800))),
    drawBoard(Display, Game),
    drawPieces(Display),
    send(Display, open).


drawBoard(Display, Game) :- draw(Display, 8, 8, 0, Game).


draw(_, _, Height, Y, _) :- Y == Height.
draw(Display, Width, Height, Y, Game) :-
    drawLine(Display, 0, Y, Width, Game),
    plus(Y,1,YY),                           % Next row
    draw(Display, Width, Height, YY, Game).


drawLine(_, X, _, Width, _) :- X == Width.
drawLine(Display, X, Y, Width, Game) :-
    NewY is abs(Y-7),                       % Convert to board/? coordinates
    send(Display, display,
        new(Ref, box(100,100)), point(X*100, Y*100)), 
    drawBoxColor(Ref, X, NewY),
    send(Ref, recogniser,                   % Call boxClickEvent on click
        click_gesture(left, '', single,
            message(@prolog, boxClickEvent, X, NewY, Ref, Game))),
    plus(X,1,XX),                           % Next column
    drawLine(Display, XX, Y, Width, Game).


boxClickEvent(X, Y, Ref, Game) :-
    turn(Turn),                             % Get current turn (white or black)
    call(Game, X, Y, Turn, Ref).            % Call game to make the move


changeTurn(white) :- retract(turn(_)), assert(turn(black)).
changeTurn(black) :- retract(turn(_)), assert(turn(white)).


selectBox(X, Y, Turn, Box) :-
    assert(selected(X, Y, Box, Turn)),      % Assert selected box
    send(Box, fill_pattern, @selected).     % Change colour of box to selected


deselectBox(X, Y, Box) :-
    retract(selected(_, _, _, _)),          % Remove previous selection
    drawBoxColor(Box, X, Y).                % Redraw the box to remove the selection color


movePiece(Ref, X, Y) :-
    NewY is abs(Y-7),                       % Convert to interface coordinates
    board(X, Y, _, _, Ref),                 % Get the box reference
    send(Ref, move, point(X*100, NewY*100)).


removePiece(X, Y) :-
    board(X, Y, _, _, Ref), !,
    free(Ref).
removePiece(_, _).


drawBoxColor(Ref, X, Y) :-                  % Draw the correct box color with board/? coordinates
    mod(X, 2) =:= mod(Y, 2),
    send(Ref, fill_pattern, @dark);
    send(Ref, fill_pattern, @light).


drawPieces(Display) :-                      % Draw all pieces from the board/4
    findall([X,Y,Z,W], board(X,Y,Z,W),L),
    drawPiece(Display, L).


drawPiece(_, []) :- !.
drawPiece(Display, [[X,Y,Piece,Color]]) :-
    piece(Piece, Color, Res),               % Get piece image
    NewY is abs(Y-7),                       % Convert to interface coordinates
    send(Display, display,
        new(Ref, bitmap(resource(Res))), point(X*100, NewY*100)),
    assert(board(X,Y,Piece,Color,Ref)).     % Add box reference to board/5
drawPiece(Display, [Head|Tail]) :-
    drawPiece(Display, [Head]),
    drawPiece(Display, Tail).
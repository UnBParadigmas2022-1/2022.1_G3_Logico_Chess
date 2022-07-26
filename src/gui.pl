:- use_module(library(pce)).
:- pce_image_directory('../assets').


:- dynamic(selected/4). % selected(X, Y, Ref, Turn)


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

% Create game mode titles
gameModeTitle(1, 'Chess - Multiplayer Local').
gameModeTitle(2, 'Chess - Multiplayer Cliente').
gameModeTitle(3, 'Chess - Multiplayer Servidor').
gameModeTitle(4, 'Chess - Computador').


initGameGui(GameMode, BoxClickEvent) :-
    gameModeTitle(GameMode, Title),
    startGui(Title, BoxClickEvent).
    

startGui(Title, BoxClickEvent) :-
    % Create custom colours
    new(@dark, colour(@default, 30583, 38293, 22102)),
    new(@light, colour(@default, 60395, 60652, 53456)),
    new(@selected, colour(@default, 30840, 30840, 24672)),
    % Create and start the window
    new(Display, window(Title, size(800,800))),
    drawMenuBar(Display, Title),
    drawBoard(Display, BoxClickEvent),
    drawPieces(Display),
    drawInform('Valendo!!!'),
    send(Display, open).


drawMenuBar(Display, Title) :-
    new(@orange, colour(orange)),
    new(@red, colour(red)),
    new(@blue, colour(blue)),
    new(@purple, colour(@default, 32767, 0, 65535)),
    new(Frame, frame(Title)),
		send(Frame, append, new(@menu_bar, dialog('', size(800,60)))),
        send(@menu_bar, display, new(@message, text(''))),
        send(@message, font, font(times, bold, 18)),
        send(@message, center, @menu_bar?center),
        send(Display, below, @menu_bar).


drawWarning(Message) :-
    send(@message, string, Message),
    send(@message, center, @menu_bar?center),
    (get(@message, colour, @red),
        send(@message, colour, @orange);
        send(@message, colour, @red)
    ).


drawInform(Message) :-
    send(@message, string, Message),
        send(@message, center, @menu_bar?center),
        (get(@message, colour, @blue),
            send(@message, colour, @purple);
            send(@message, colour, @blue)
        ).


drawBoard(Display, BoxClickEvent) :- draw(Display, 8, 8, 0, BoxClickEvent).


draw(_, _, Height, Y, _) :- Y == Height.
draw(Display, Width, Height, Y, BoxClickEvent) :-
    drawLine(Display, 0, Y, Width, BoxClickEvent),
    plus(Y,1,YY),                           % Next row
    draw(Display, Width, Height, YY, BoxClickEvent).


drawLine(_, X, _, Width, _) :- X == Width.
drawLine(Display, X, Y, Width, BoxClickEvent) :-
    NewY is abs(Y-7),                       % Convert to board/? coordinates
    send(Display, display,
        new(Ref, box(100,100)), point(X*100, Y*100)), 
    drawBoxColor(Ref, X, NewY),
    send(Ref, recogniser,                   % Call boxClickEvent on click
        click_gesture(left, '', single,
            message(@prolog, BoxClickEvent, X, NewY, Ref))),
    plus(X,1,XX),                           % Next column
    drawLine(Display, XX, Y, Width, BoxClickEvent).


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


changePiece(X, Y, NewPiece) :-
    board(X, Y, _, Color, Ref),             % Get the box reference
    retract(board(X, Y, _, _, _)),
    assert(board(X, Y, NewPiece, Color, Ref)),
    piece(NewPiece, Color, Res),            % Get the new piece image
    send(Ref, image, bitmap(resource(Res))).


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

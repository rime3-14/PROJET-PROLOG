:- consult(ai).
:- consult(rules).
:- consult(winner).

% Scores use x's perspective.
utility(Board, Score) :-
    ( winner(Board, Mark) ->
        ( Mark == x -> Score = 1 ; Score = -1 )
    ; Score = 0
    ).

isBoardEmpty(Board) :-
    forall((member(Column, Board), member(Cell, Column)), var(Cell)).

possible_moves(Board, Columns) :-
    findall(Column,
        ( member(Column, [3,2,4,1,5,0,6]),
          firstFreeIndexColonne(Board, Column, Row), Row < 6
        ),
        Columns).

% Depth is the number of plies still available. Column is none at a leaf.
minimax(Depth, Board, _Player, Column, Score) :-
    ( Depth =< 0 ; winner(Board, _) ; isBoardFull(Board) ), !,
    Column = none,
    utility(Board, Score).
minimax(Depth, Board, Player, Column, Score) :-
    Remaining is Depth - 1,
    changePlayer(Player, Opponent),
    possible_moves(Board, Moves),
    findall(Value-Move,
        ( member(Move, Moves),
          firstFreeIndexColonne(Board, Move, Row),
          playMove(Board, Move, Row, NextBoard, Player),
          minimax(Remaining, NextBoard, Opponent, _, Value)
        ),
        [First|Rest]),
    foldl(prefer(Player), Rest, First, Score-Column).

prefer(Player, NewScore-NewMove, OldScore-OldMove, Score-Move) :-
    ( ( Player == x, NewScore > OldScore ; Player == o, NewScore < OldScore ) ->
        Score = NewScore, Move = NewMove
    ; Score = OldScore, Move = OldMove
    ).

cave([[0, 0, 2, 3], [2, 0, 1, 2], [3, 0, 3, 1], [6, 0, 1, 2], [7, 0, 1, 3], [8, 0, 4, 4], [9, 4, 3, 1], [10, 5, 2, 1], [0, 4, 6, 6], [3, 3, 3, 1], [4, 2, 1, 1], [6, 5, 1, 5], [7, 8, 1, 2], [8, 9, 3, 1], [11, 8, 1, 2]]).
% cave([[0,0,2,1],[2,0,1,2],[3,0,1,2],[0,2,1,2],[1,3,3,1]]).
%cave([[0,0,4,1],[0,2,4,2]]).

% addPath(E,L,N):-
% append(E,L,N).
not_member(_, []) :- !.
not_member(X, [Head|Tail]) :-
X \= Head,
not_member(X, Tail).


travelNext(X,Y):-
Y is X+1.
travelBack(X,Y):-
Y is X-1.

pathContains([],[_,_],_).
pathContains([[RectX,RectY,Width,Height]|T], [SquareX, SquareY], S):-
%write([RectX,RectY,Width,Height]),
CoX is RectX+Width,
CoY is RectY+Height,
(SquareX > RectX,
SquareY > RectY,
SquareX =< CoX,
SquareY =< CoY -> false; pathContains(T,[SquareX,SquareY], S)),
S=[SquareX,SquareY].

%move(State,firstmove, nextstate)
% moving upward
move([A,X],[A,Y]):-travelBack(X,Y). 

% moving forward
move([X,A],[Y,A]):-travelNext(X,Y).

% moving down
move([A,X],[A,Y]):-travelNext(X,Y).

% moving back
move([X,A],[Y,A]):-travelBack(X,Y).

% cave(X),fly(X,[12,10],[1,4],P).
fly(_,[X,_],[Y,_],Path):-
Y is X+1,
write(Path).
% fly(AnsPath):- fly(_,_,_,AnsPath).
fly(Cave, [CaveWidth, CaveHeight],[StartX, StartY], AnsPath):-
StartX =< CaveWidth,
StartX > 0,
StartY =< CaveHeight,
StartY > 0,
pathContains(Cave, [StartX, StartY], S),
append(AnsPath,[S],Path),
move(S,N),
not_member(N,Path),
fly(Cave,[CaveWidth,CaveHeight],N,Path).
% ['/Users/jazzy/developer/prologMain.pl'].

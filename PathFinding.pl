/*Cidade1,Cidade2,Distancia*/	
conect( a,b,10  ).
conect( b,c,100 ).
conect( b,d,40  ).
conect( d,c,20  ).
conect( d,e,23  ).
conect( d,f,2   ).
conect( e,g,4   ).


conect( e,h,10  ).
conect( e,i,10  ).
conect( i,j,10  ).
conect( j,g,10  ).
conect( i,c,10  ).

is_empty([]).

is_member(X, [X | _]).         % If the head of the list is X
is_member(X, [_ | Rest]) :-    % else recur for the rest of the list
    is_member(X, Rest).

min(X,Y,X):-
    X < Y.

min(X,Y,Y):-
    X > Y;
    X = Y.

isconnected(X,Y,D) :- 
	conect( X,Y,D );
	conect( Y,X,D ).

path(X,Y,P) :-
    pathf(X,Y,P,[]).

pathf(X,Y,[X,Y],_):-
    isconnected( X,Y,_ ).

pathf(X,Y,[X | R],P) :-
    isconnected(X,Z,_),
    \+ is_member(Y,P),
    \+ is_member(Z,P),
    pathf(Z,Y,R,[Z | P] ).

minPath(X,Y,L,D):-
    listPath(X,Y,A),
    minAuxPath(A,M),
    M = [D|L].

minAuxPath( [M|A],M ):-
    is_empty(A).

minAuxPath([H|R],H):-
    minAuxPath(R,N),
    H = [ D1|_ ],
    N = [ D2|_ ],
    D1 < D2.

minAuxPath([H|R],N):-
    minAuxPath(R,N),
    H = [ D1|_ ],
    N = [ D2|_ ],
    D1 > D2.

listPath( X,Y,L ):-
    findall([ D1|P1 ],allPath( X, Y, P1,D1 ),L).

allPath( X,Y,P,D ):-
    auxMinPath( X,Y,P,D,[] ).

auxMinPath( X,Y,[X,Y],D,_ ):-
    isconnected(X,Y,D).

auxMinPath( X,Y,[ X | R],D,P ):-
    isconnected(X,Z,D2),
    \+ is_member(Y,P),
    \+ is_member(Z,P),
    auxMinPath( Z,Y,R,D1,[Z|P] ),
    D is D1+D2.

minlist( [H|R],H ):-
    is_empty(R).
 
minlist( [H|R],M ):-
    minlist(R,N),
    min(H,N,M).

% -------- Part 1 --------
% Es 1.1
% search ( Elem , List )
search(X, [X|_]).
search(X, [_|Xs]):- search(X, Xs).
% -- queries --
%search(a,[a,b,c]). -> y
%search(a,[c,d,e]). -> n
% -- iteration --
%search(X, [a,b,c]). -> a, b, c
% -- generation --
%search(a, X) -> generate all list that contains an a
%search(a,[X,b,Y,Z]). -> subsitute one variable with "a", 
%			so we obtain 3 results: X=a, Y=a, Z=a
%search(X,Y) -> generate infinite Y lists in which an element = X

%Es 1.2
%search2(Elem, List) -> looks for 2 consecutive occurences of Elem
search2(X, [X, X|_]).
search2(X, [_|Xs]):- search2(X, Xs).
%search2(a,[b,c,a,a,d,e,a,a,g,h]). -> yes, yes
%search2(a,[b,c,a,a,a,d,e]). -> yes, yes
%search2(X,[b,c,a,a,d,d,e]). -> yes X=a, yes X=d
%search2(a,L). -> all lists with 2 consecutive a
%search2(a,[_,_,a,_,a,_]). -> 5 results, one for each possible substitution
% 			of _ with a whose result contains 2 consecutive a

%Es 1.3
% search_two ( Elem , List )
% looks for two occurrences of Elem with any elements inbetween !
search_two(X, [X,_,X|_]).
search_two(X, [_|Xs]):- search_two(X, Xs).
%search_two(a,[b,c,a,a,d,e]). → no
%search_two(a,[b,c,a,d,a,d,e]). → yes
%search_two(a,L) -> generate all lists that has 2 occurences of a with any element in between

%Es 1.4
% search_anytwo ( Elem , List )
% looks for any Elem that occurs two times, anywhere
search_anytwo(X, [X|T]):- search(X, T).
search_anytwo(X, [_|T]):- search_anytwo(X, T).
%search_anytwo(a,[b,c,a,k,d,e]). → no
%search_anytwo(a,[b,c,a,a,d,e]). → yes

% -------- Part 2 --------
%Es 2.1
% size ( List , Size )
%Size will contain the number of elements in List
size([], 0) .
size([_|Xs], N):- size(Xs, N2), N is N2 + 1.
%size(L, 2).

%Es 2.2
% size ( List , Size )
% Size will contain the number of elements in List,
%	written using notation zero, s(zero), s(s(zero)) ..
peanosize([], zero) .
peanosize([_|Xs], s(N)):- peanosize(Xs, N).
%peanosize([a,b,c], X). -> X/s(s(s(zero)))

%Es 2.3
% sum(List, Sum)
sum([], 0).
sum([H|T], N2):- sum(T, N), N2 is N + H.
%sum ([1 ,2 ,3] , X )

%Es 2.4
%average ( List , Average )
%it uses average ( List , Count , Sum , Average)
average(List, A):- average(List, 0, 0, A).
average([], C, S, A) :- A is S / C.
average([X|Xs], C, S, A):-
	C2 is C +1,
	S2 is S +X,
	average(Xs, C2, S2, A).

%Es 2.5
% max ( List , Max )
% Max is the biggest element in List
% Suppose the list has at least one element
max([X|Xs], M):- max([X|Xs], M, X).
max([], Tm, Tm).
max([X|Xs], M, Tm):- Tm > X, max(Xs, M, Tm).
max([X|Xs], M, Tm):- X >= Tm, max(Xs, M, X).
%without tempMax
max2([M], M).
max2([X|Xs], Tmp):- max(Xs, Tmp), Tmp > X.
max2([X|Xs], X):- max2(Xs, Tmp), X >= Tmp.

%Es 2.6
%max ( List , Max , Min )
%Max is the biggest element in List
%Min is the smallest element in List
%Suppose the list has at least one element
maxmin([X], X, X).
maxmin([X|Xs], Tmax, Tmin):- maxmin(Xs, Tmax, Tmin), Tmax > X, Tmin < X.
maxmin([X|Xs], X, Tmin):- maxmin(Xs, Tmax, Tmin), X >= Tmax, Tmin < X.
maxmin([X|Xs], Tmax, X):- maxmin(Xs, Tmax, Tmin), Tmax > X, X =< Tmin.

% -------- Part 3 --------
%Es 3.1
% same ( List1 , List2 )
% are the two lists exactly the same ?
same([] ,[]).
same([X|Xs], [X|Ys]):- same(Xs, Ys).
%same([1,2],L) -> L = [1,2]

%Es 3.2
% all_bigger ( List1 , List2 )
% all elements in List1 are bigger than those in List2,1 by 1
% example : all_bigger ([10 ,20 ,30 ,40] ,[9 ,19 ,29 ,39]).
all_bigger([], []).
all_bigger([X|Xs], [Y|Ys]):- X >= Y, all_bigger(Xs, Ys).

%Es 3.3
% sublist ( List1 , List2 )
% List1 should contain elements all also in List2
% example : sublist ([1 ,2] ,[5 ,3 ,2 ,1]) .
sublist([], [H|_]).
sublist([X|Xs], L2):- search(X, L2), sublist(Xs, L2).

% -------- Part 4 --------
%Es 4.1
%seq (N , List )
%example : seq (5 ,[0 ,0 ,0 ,0 ,0]) .
seq(0 ,[]) .
seq(N, [0|T]):- N2 is N-1, seq(N2, T).

%Es 4.2
% seqR (N , List )
% example : seqR (4 ,[4 ,3 ,2 ,1 ,0]).
seqR(0 ,[0]) .
seqR(N, [N|T]):- N2 is N-1, seqR(N2, T).

%Es 4.3
% seqR2 (N , List )
% example : seqR2 (4 ,[0 ,1 ,2 ,3 ,4]).
seqR2(N, List):- last([], N, List).
last(L, 0, [0|L]).
last(L, N, Out):- N2 is N-1, last([N|L], N2, Out).

% -------- Part 5 --------
% last(List, E)
% return the last element of a list
% example: last([1,2,3], 3)
lastList([E], E).
lastList([X|Xs], E):- lastList(Xs,E).

% map(L, Mapper, R)
% mapper is applyed to L. Mapper must be a number that will be added to each element of L
% example: map([1,2,3], 1, [2,3,4])
map([], M, []).
map([X|Xs], M, [X2|T]):- X2 is X+M, map(Xs, M, T).

% filter(L, Pred, R)
% filter a list L searching all the elements that are > Pred
% example: filter([10,20,30,40], 20, [30,40])
filter([], P, []).
filter([X|Xs], P, [X|R]):- X > P, filter(Xs, P, R).
filter([X|Xs], P, R):- X =< P, filter(Xs, P, R).

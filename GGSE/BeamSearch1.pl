search(Graph, [Node|Path], _) :- 
choose([Node|Path], Graph, _),
state_of(Node, State),
goal_state(State), !.

search(Graph, SolnPath, Beam) :-
choose(Path, Graph, OtherPaths),
one_step_extensions(Path, NewPaths),
add_to_paths(NewPaths, OtherPaths, GraphPlus, Beam),
search(GraphPlus, SolnPath, Beam).

one_step_extensions([Node|Path], NewPaths) :-
state_of(Node, State),
findall([NewNode,Node|Path],
(state_change(State, NewState),  
make_node(NewState, NewNode)), 
NewPaths).

choose(Path, [Path|OtherPaths], OtherPaths).

add_to_paths(NewPaths, OtherPaths, GraphMinus, Beam) :-
inser_in_order(NewPaths, OtherPaths, AllPaths), 
prune(AllPaths, Beam, GraphMinus).

prune([], _, []).
prune(_, 0, []) :- 
!.
prune([H|T1], Beam, [H|T2]) :-
NarrowBeam is Beam - 1,
prune(T1, NarrowBeam, T2).

inser_in_order(X, Y, Z) :-
append(X, Y, W), quicksort(W, Z).

quicksort([], []).
quicksort([[(A,B)|T]|OtherPaths], Result):-
order(B, OtherPaths, Left, Right),
quicksort(Left, L),
quicksort(Right, R),
append(L, [[(A,B)|T]|R], Result).

order(_, [], [], []).
order(Pivot, [[(A,B)|T]|OtherPaths], [[(A,B)|T]|Left], Right) :-
B =< Pivot, order(Pivot, OtherPaths, Left, Right).
order(Pivot, [[(A,B)|T]|OtherPaths], Left, [[(A,B)|T]|Right]) :-
B > Pivot, order(Pivot, OtherPaths, Left, Right).

state_of(X, X).

make_node(X, X).

goal_state((g,_)).

state_change(X, Y) :-
successor(X, Y).
successor((a,0), (b,1)).
successor((a,0), (c,5)).
successor((a,0), (d,10)).
successor((b,1), (e,9)).
successor((e,9), (g,19)).
successor((c,5), (g,20)).
successor((d,10), (f,13)).
successor((f,13), (g,16)).
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
cost_of(Node, PathCost),
findall([NewNode,Node|Path],
(state_change(State, NewState, GCost), 
AccCost is GCost + PathCost, 
make_node(NewState, AccCost, NewNode)), 
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
append(X, Y, W), order(W, Z).
order([], []).
order(X, [Path|Y]) :-
choose1(Path, X, Other), order(Other, Y).

choose1(Path, [[(A,B)|T]|OtherPaths], Other) :-
choose_cheapest([[(A,B)|T]|OtherPaths], B, _, Path), select(Path, [[(A,B)|T]|OtherPaths], Other).

choose_cheapest([], _, Y, Y).
choose_cheapest([[(A,B)|T]|OtherPaths], C, _, Result) :-
B =< C, choose_cheapest(OtherPaths, B, [(A,B)|T], Result).
choose_cheapest([[(_,B)|_]|OtherPaths], C, Y, Result) :-
B > C, choose_cheapest(OtherPaths, C, Y, Result).

state_of((X,_), X).

make_node(X, A, (X,A)).

cost_of((_,X), X).

goal_state((g)).

state_change(X, Y, GCost) :-
successor(X, Y, GCost).
successor(a, b, 1).
successor(a, c, 5).
successor(a, d, 10).
successor(b, e, 9).
successor(e, g, 19).
successor(c, g, 20).
successor(d, f, 13).
successor(f, g, 16).
search(Graph, [Node|Path], Goal) :- 
choose([Node|Path], Graph, _),
state_of(Node, State),
goal_state(State, Goal), !.

search(Graph, SolnPath, Goal) :-
choose(Path, Graph, OtherPaths),
one_step_extensions(Path, NewPaths),
add_to_paths(NewPaths, OtherPaths, GraphPlus),
search(GraphPlus, SolnPath, Goal).

one_step_extensions([Node|Path], NewPaths) :-
state_of(Node, State),
cost_of(Node, PathCost),
findall([NewNode,Node|Path],
(state_change(State, NewState, GCost), 
AccCost is GCost + PathCost, 
make_node(NewState, AccCost, NewNode)), 
NewPaths).

choose(Path, [[(A,B)|T]|OtherPaths], Other) :-
choose_cheapest([[(A,B)|T]|OtherPaths], B, _, Path), select(Path, [[(A,B)|T]|OtherPaths], Other).

choose_cheapest([], _, Y, Y).
choose_cheapest([[(A,B)|T]|OtherPaths], C, _, Result) :-
B =< C, choose_cheapest(OtherPaths, B, [(A,B)|T], Result).
choose_cheapest([[(_,B)|_]|OtherPaths], C, Y, Result) :-
B > C, choose_cheapest(OtherPaths, C, Y, Result).

add_to_paths(NewPaths, OtherPaths, AllPaths) :-
append(OtherPaths, NewPaths, AllPaths). 

state_of((X,_), X).

make_node(X, A, (X,A)).

cost_of((_,X), X).

goal_state((X),(X)).

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
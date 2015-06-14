search(Graph, [Node|Path] ) :- 
choose([Node|Path], Graph, _),
state_of(Node, State),
goal_state(State), !.

search(Graph, SolnPath) :-
choose(Path, Graph, OtherPaths),
one_step_extensions(Path, NewPaths),
add_to_paths(NewPaths, OtherPaths, GraphPlus),
search(GraphPlus, SolnPath).

one_step_extensions([Node|Path], NewPaths) :-
state_of(Node, State),
findall([NewNode,Node|Path],
(state_change(State, NewState),  
make_node(NewState, NewNode)), 
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
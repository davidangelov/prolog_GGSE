search(Graph, [Node|Path] ) :- 
choose([Node|Path], Graph, _),
state_of(Node, State),
goal_state(State).

search(Graph, SolnPath) :-
choose(Path, Graph, OtherPaths),
one_step_extensions(Path, NewPaths),
add_to_paths(NewPaths, OtherPaths, GraphPlus),
search(GraphPlus, SolnPath).

one_step_extensions([Node|Path], NewPaths) :-
state_of(Node, State),
findall([NewNode,Node|Path],
(state_change(Rule, State, NewState), make_node(Rule, NewState, NewNode)), 
NewPaths).

choose(Path, [Path|OtherPaths], OtherPaths).

add_to_paths(NewPaths, OtherPaths, AllPaths) :-
append(OtherPaths, NewPaths, AllPaths). 

state_of(X, X).

make_node(_, X, X).

goal_state((g)).

state_change(_, a, b).
state_change(_, a, c).
state_change(_, a, d).
state_change(_, b, e).
state_change(_, e, g).
state_change(_, c, g).
state_change(_, d, f).
state_change(_, f, g).
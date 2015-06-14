id_search(Paths, SolnPath, Depth) :-
search(Paths, SolnPath, Depth).
id_search(Paths, SolnPath, Depth) :-
Depth1 is Depth + 1,
id_search(Paths, SolnPath, Depth1).

search(Graph, [Node|Path], _) :-
choose([Node|Path], Graph, _),
state_of(Node, State),
goal_state(State).

search(Graph, SolnPath, Depth) :-
choose(Path, Graph, GraphMinus),
length(Path, PathLength),
PathDepth is PathLength - 1,
PathDepth = Depth, !,

search(GraphMinus, SolnPath, Depth).

search(Graph, SolnPath, Depth) :-
choose(Path, Graph, OtherPaths),
one_step_extensions(Path, NewPaths),
add_to_paths(NewPaths, OtherPaths, GraphPlus),
search(GraphPlus, SolnPath, Depth).

one_step_extensions([Node|Path], NewPaths) :-
state_of(Node, State),
findall([NewNode,Node|Path],
(state_change(Rule, State, NewState), make_node(Rule, NewState, NewNode)), 
NewPaths).

choose(Path, [Path|OtherPaths], OtherPaths).

add_to_paths(NewPaths, OtherPaths, AllPaths) :-
append(NewPaths, OtherPaths, AllPaths). 

state_of(X, X).

make_node(_, X, X).

goal_state((g)).

state_change(1_2, a, b).
state_change(1_3, a, c).
state_change(1_4, a, d).
state_change(2_5, b, e).
state_change(5_8, e, g).
state_change(3_6, c, g).
state_change(4_7, d, f).
state_change(7_9, f, g).
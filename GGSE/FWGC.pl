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

goal_state((r,r,r,r)).

state_change(farmer, (B,W,G,C), (O,W,G,C)) :-
opposite(B,O), opposite(W,G), opposite(G,C).
state_change(wolf, (B,B,G,C), (O,O,G,C)) :-
opposite(B,O), opposite(G,C).
state_change(goat, (B,W,B,C), (O,W,O,C)) :-
opposite(B,O).
state_change(cabbage, (B,W,G,B), (O,W,G,O)) :-
opposite(B,O), opposite(W,G).

opposite(r, l).
opposite(l, r).

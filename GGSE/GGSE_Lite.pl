search([Node|Path], [Node|Path] ) :- 
state_of(Node, State),
goal_state(State).

search([Node|Path], SolnPath) :-
state_of(Node, State),
state_change(Rule, State, NewState),
make_node(Rule, NewState, NewNode),
search([NewNode,Node|Path], SolnPath).

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
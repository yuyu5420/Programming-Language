input_relation(N) :-
    N > 0
    -> % N > 0
        readln(P),
        nth0(0, P, P1), % P1 = first number in P list
        nth0(1, P, P2), % P2 = second number in P list
        assert(is_parent(P1, P2)), % P1 is P2's parent
        N1 is N - 1,
        input_relation(N1)
    ; % N <= 0
        readln([Y|_]),
        input_nodes(Y). % find lowest common ancestor

input_nodes(N) :-
    N > 0
    -> % N > 0
        readln(P),
        nth0(0, P, P1),
        nth0(1, P, P2),
        lca(P1, P2),
        N1 is N - 1,
        input_nodes(N1)
    ; % N <= 0
        halt.

is_ancestor(A, B) :- % if A is B's parent then A is B's ancestor
    is_parent(A, B). 

is_ancestor(A, B) :-  % if X is B's parent and A is X's ancestor then A is B's ancesor
    is_parent(X, B),
    is_parent(A, X).

lca(A,B) :- 
    A == B % A & B is same
    -> 
        write(A), nl
    ;
        is_ancestor(A,B) % A is B's ancestor
        -> 
            write(A), nl
        ; 
            is_parent(X,A),lca(X,B).

main :-
    readln([X|_]),
    N is X - 1,
    input_relation(N). % repeat X-1 times

:- initialization(main).
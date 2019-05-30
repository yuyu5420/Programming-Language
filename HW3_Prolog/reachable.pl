input_edge(N) :-
    N > 0
    -> % N > 0
        readln(P),
        nth0(0, P, P1), % P1 = first number in P list
        nth0(1, P, P2), % P2 = second number in P list
        assert(edge(P1, P2)), % P1 and P2 have connection
        assert(edge(P2, P1)), % P1 and P2 have connection
        N1 is N - 1,
        input_edge(N1)
    ; % N <= 0
        readln([Y|_]),
        input_nodes(Y). % find if reachable

input_nodes(N) :-
    N > 0
    -> % N > 0
        readln(P),
        nth0(0, P, A),
        nth0(1, P, B),
        reachable(A, B),
        N1 is N - 1,
        input_nodes(N1)
    ; % N <= 0
        halt.

reachable(A, B) :-
    A = B 
    -> % A = B
        write('Yes'),nl.

reachable(A, B) :-
    walk(A, B, [])
    ->
        write('Yes'),nl
    ;
        write('No'), nl.

walk(A,B,V) :-  % walk A to B
    edge(A,X),  % A connect X
    not(member(X,V)), % X not the member of V (not be visited)
    (                  
        B = X
    ; % or
        walk(X,B,[A|V]) % test next and put A into V (be visited)
    ).

main :-
    readln(X),
    nth0(1, X, E), % E = second number in X list (edge)
    input_edge(E).

:- initialization(main).
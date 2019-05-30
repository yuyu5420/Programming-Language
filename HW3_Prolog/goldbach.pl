is_prime(2).
is_prime(3).
is_prime(P) :- 
    integer(P),
    P > 3,
    P mod 2 =\= 0,
    \+ has_factor(P,3).  

has_factor(N,L) :- 
    N mod L =:= 0.

has_factor(N,L) :- 
    L * L < N,
    L2 is L + 2,
    has_factor(N,L2).

goldbach(N, P1, P2) :-
    N is P1 + P2,
    is_prime(P1),
    is_prime(P2).

test_goldbach(4, 3) :- % special case
    write('        2 2'), nl,
    halt.

test_goldbach(X, Y) :-
    Y < X / 2 + 1
    -> % find possible primes
        check_goldbach(X, Y), % goldbach is true, print the result                 
        Y2 is Y + 2,
        test_goldbach(X, Y2)
    ;  % no need to find primes             
        halt.

check_goldbach(X, Y) :-
    Z is X - Y,
    goldbach(X, Y, Z)
    ->
        write('        '),
        write(Y),
        write(' '),
        write(Z), nl
    ;
        true.

main :-
    write('Input: '),
    readln([X|_]),
    write('Output:'), nl,
    test_goldbach(X, 3). % find X's goldbach

:- initialization(main).
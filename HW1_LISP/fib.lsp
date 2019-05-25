;original recursion
(defun fib1(n)
    (if (< n 2)
        n
        (+ (fib1 (- n 1)) (fib1 (- n 2)))
    )
)
;tail recursion
(defun fib2(n)
    (labels ((fib(n a b)
                (if (= n 0)
                    a
                    (fib (- n 1) b (+ a b))
                )
            ))
        (fib n 0 1)
    )
)
(trace fib1)
(trace fib2)
(print (fib1 3))
(format t "~%");for next line
(print (fib2 8))
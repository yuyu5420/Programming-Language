;for solving warning:unknown variables
(defvar *m* nil)
(defun prime(n)
    (print n)
    (if (< n 3)
        (princ "is a prime number")
        (princ (check n))
    )
)
(defun check(n)
    (setq *m* 2)
    (loop
        (if (= (rem n *m*) 0);number can be divided
            (return "is not a prime number")
            (setq *m* (+ *m* 1))
        )
        (when (> *m* (/ n 2)) (return "is a prime number"))
    )
)
(prime 2)
(prime 239)
(prime 999)
(prime 17)
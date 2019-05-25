(defvar *y* 0);the line number have been done
(defun make-list-from-file (filename);read file and make list
    (let (
        (in (open filename :if-does-not-exist nil))
        (l nil)
    )
    (when in
            (loop for line = (read-line in nil)
                while line do 
                    (push line l)     
            )
        (setq l (reverse l))
        (close in)
    )
    (return-from make-list-from-file l)
    )
)
(defun same(i j l2)
    (let ((x 0))
        (dolist (k l2)
            (incf x)
            (if (and (> x *y*) (< x j));print the line before the same line of file2.txt(excluding the line have been print)
                (format t "+~A~%"  k );print + line
                nil
            )
        )
    )
    (setq *y* j);set the line number have been done
    (format t " ~a~%" i);print the same line
    (return-from same 1);have donn the same
)
(defun check(l2 l)
    (let 
        (
            (j 0);calculate the number of line(current)
            (q 0);0 represent not the same; 1 represent is the same(have done)
        )
        (dolist (i l2)
            (incf j)
            (if (and (equal i l) (/= q 1));check the line is same and it is the first time same
               (setq q (same i j l2))
               nil
            )
        )
        (if (= q 0);doesn't have the same line, just print it out
            (format t "-~A~%"  l );print - line
            nil
        )
    )
)
(defun main()
    (let
        (
            (x 0)
            (l1 (make-list-from-file "file1.txt"));read file1.txt
            (l2 (make-list-from-file "file2.txt"));read file2.txt
        )
        (dolist (i l1) (check l2 i))
        (dolist (i l2)
            (incf x)
            (if (> x *y*);file2.txt rest part
                (format t "+~A~%"  i );print + line
                nil
            )
        )
    )
)
(main)
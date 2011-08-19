(define (pascal row column)
  (cond ((= column 1) 1)
        ((= column row) 1)
        (else (+ (pascal (- row 1) (- column 1))
                 (pascal (- row 1) column)))))

; tests
(= (pascal 1 1) 1)

(= (pascal 3 2) 2)

(= (pascal 4 2) 3)

(= (pascal 5 3) 6)

; helper functions
(define (double x) (* x 2))
(define (halve x)  (/ x 2))

; recursive process: logarithmic space and steps
(define (multiply a b)
  (cond ((= b 1) a)
        ((even? b) (double (multiply a (halve b))))
        (else (+ a (multiply a (- b 1))))))

; tests

(= (multiply 4 4) 16)
(= (multiply 7 8) 56)

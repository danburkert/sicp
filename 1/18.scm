; helper functions
(define (double x) (* x 2))
(define (halve x)  (/ x 2))

; iterative process: constant space and logarithmic steps
; invariant quantity a * b + c
(define (multiply a b)
  (define (mult-iter a b c)
    (cond ((= b 1) (+ a c))
          ((even? b) (mult-iter (double a) (halve b) c))
          (else (mult-iter (double a) (halve (- b 1)) (+ a c)))))
  (mult-iter a b 0))


; tests

(= (multiply 4 4) 16)
(= (multiply 7 8) 56)

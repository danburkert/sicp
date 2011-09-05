(define (cons x y)
  (lambda (m) (m (* (expt 2 x)
                    (expt 3 y)))))

(define (car z)
  (z (lambda (m) (factor m 2))))

(define (cdr z)
  (z (lambda (m) (factor m 3))))


; factor a by b
(define (factor a b)
  (if (= (remainder a b) 0)
    (+ 1 (factor (/ a b) b))
    0))


; test

(= (car (cons 4 5)) 4)
(= (cdr (cons 4 5)) 5)

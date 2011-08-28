(define (compose f g)
  (lambda (x) (f (g x))))

(define (inc x) (+ x 1))

;test

((compose square inc) 6) ; 49

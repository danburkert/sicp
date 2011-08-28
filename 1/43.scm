(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (itr inv f n)
    (if (< n 1)
      inv
      (itr (compose f inv) f (- n 1))))
  (itr (lambda (x) x) f n))

; test

((repeated square 2) 5) ; 625

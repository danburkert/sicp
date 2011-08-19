; the sqrt-iter using the new-if function gives a max recursion
; depth exceeded error.  This happens because of applicative order
; evaluation- The else-clause is evaluated even though the predicate
; is true, thus beginning an infinite loop.

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (abs x)
  (if (< x 0)
      (- x)
      x))

(define (square x) (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) .001))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (sqrt x) (sqrt-iter 1.0 x))

(sqrt 9)
(sqrt (+ 100 37))

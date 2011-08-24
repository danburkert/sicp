(define (cube n) (* n n n))

(define  (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))

(define (inc n) (+ n 1))

(define (integral f a b n)
  (define h (/ (- b a) n))
  (define (y k)
    (f (+ a (* k h))))
  (define (coefficient k)
    (cond ((= k 0) 1)
          ((= k n) 1)
          ((odd? k) 4)
          (else 2)))
  (define (term k)
    (* (coefficient k) (y k)))
  (/ (* h (sum term 0 inc n))
     3))


; the results are much more precise
(integral cube 0 1 100.0) ;  0.24999
(integral cube 0 1 1000.0) ; 0.25000

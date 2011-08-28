(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (itr inv f n)
    (if (< n 1)
      inv
      (itr (compose f inv) f (- n 1))))
  (itr (lambda (x) x) f n))

(define dx 0.00001)

(define (smooth f)
  (lambda (x)
    (/ (+ (f x)
          (f (- x dx))
          (f (+ x dx)))
       3)))

(define (n-smooth f n)
  ((repeated smooth n) f))

; test

(define (cubic a b c)
  (lambda (x)
    (+ (* x x x) (* a x x) (* b x) c)))

((cubic 3 -2 6) 4)
((smooth (cubic 3 -2 6)) 4)
((n-smooth (cubic 3 -2 6) 4) 4)

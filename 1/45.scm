(define (close-enough? x y)
  (< (abs (- x y)) 0.001))
(define (average x y)
  (/ (+ x y) 2))
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))
(define (compose f g)
  (lambda (x) (f (g x))))
(define (repeated f n)
  (define (itr inv f n)
    (if (< n 1)
      inv
      (itr (compose f inv) f (- n 1))))
  (itr (lambda (x) x) f n))
(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (n-root x n)
  (fixed-point
    ((repeated average-damp 4)
       (lambda (y) (/ x (expt y (- n 1)))))
    1.0))

(n-root 8 3) ; 1 average

(n-root 16 4) ; 2 averages

(n-root 32 5) ; 2 averages

(n-root 64 6) ; 2 averages

(n-root 128 7) ; 2 averages

(n-root 256 8) ; 3 averages

(n-root 512 9) ; 3 averages

(n-root 1024 10) ; 3 averages

(n-root 2048 11) ; 3 averages

(n-root 4096 12) ; 3 averages

(n-root 12 15) ; 3 averages

(n-root 12 16) ; 4 averages


; it seems to be sqrt(n) rounded down, thus:

(define (n-root x n)
  (fixed-point
    ((repeated average-damp (floor (sqrt n)))
       (lambda (y) (/ x (expt y (- n 1)))))
    1.0))

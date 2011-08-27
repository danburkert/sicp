(define tolerance 0.00001)
(define (average x y)
  (/ (+ x y) 2))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (newline)
    (display guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
        next
        (try next))))
  (try first-guess))

; without damping:
(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0) ; 34

; with damping:
(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 2.0) ; 9

; the fixed point calculation with damping does far fewer iterations,
; 9 instead of 34


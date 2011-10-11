(define (make-vect xcor ycor)
  (cons xcor ycor))
(define (xcor-vect vect)
  (car vect))
(define (ycor-vect vect)
  (cdr vect))

; test

(eq? 4 (xcor-vect (make-vect 4 5)))
(eq? 5 (ycor-vect (make-vect 4 5)))

(define (add-vect a b)
  (make-vect (+ (xcor-vect a)
                (xcor-vect b))
             (+ (ycor-vect a)
                (ycor-vect b))))
(define (sub-vect a b)
  (make-vect (- (xcor-vect a)
                (xcor-vect b))
             (- (ycor-vect a)
                (ycor-vect b))))
(define (scale-vect vect scalar)
  (make-vect (* (xcor-vect vect) scalar)
             (* (ycor-vect vect) scalar)))



; test

(define a (make-vect 4 5))
(define b (make-vect -2 4))

; terrible coding style below, should use let or define instead of repeating
; vector transforms

(and (eq? (xcor-vect (add-vect a b)) 2)
     (eq? (ycor-vect (add-vect a b)) 9))

(and (eq? (xcor-vect (sub-vect a b)) 6)
     (eq? (ycor-vect (sub-vect a b)) 1))

(and (eq? (xcor-vect (scale-vect a 2)) 8)
     (eq? (ycor-vect (scale-vect a 2)) 10))

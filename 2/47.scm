(define (make-vect xcor ycor)
  (cons xcor ycor))
(define (xcor-vect vect)
  (car vect))
(define (ycor-vect vect)
  (cdr vect))
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


; a

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
(define (origin-frame frame)
  (list-ref frame 0))
(define (edge1-frame frame)
  (list-ref frame 1))
(define (edge2-frame frame)
  (list-ref frame 2))

; b

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
(define (origin-frame frame)
  (car frame))
(define (edge1-frame frame)
  (cadr frame))
(define (edge2-frame frame)
  (cddr frame))

; test

(define o-vect (make-vect 3 4))
(define e1-vect (make-vect -1 3))
(define e2-vect (make-vect 4 -5))
(define f (make-frame o-vect e1-vect e2-vect))

(eq? (edge1-frame f) e1-vect)
(eq? (edge2-frame f) e2-vect)
(eq? (origin-frame f) o-vect))

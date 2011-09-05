; I read through an intro to lambda calculus so I could understand
; this exercise a bit better:
; http://www.utdallas.edu/~gupta/courses/apl/lambda.pdf

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))


(add-1 zero)

(lambda (f) (lambda (x) (f ((zero f) x))))

(lambda (f) (lambda (x) (f (((lambda (t) (lambda (x) x)) f) x))))

(lambda (f) (lambda (x) (f ((lambda (x) x) x))))

(lambda (f) (lambda (x) (f x)))

(define one
  (lambda (f) (lambda (x) (f x))))



(add-1 one)

(lambda (f) (lambda (x) (f ((one f) x))))

(lambda (f) (lambda (x) (f (((lambda (t) (lambda (s) (t s))) f) x))))

(lambda (f) (lambda (x) (f (((lambda (s) (f s))) x))))

(lambda (f) (lambda (x) (f (f x))))

(define two
  (lambda (f) (lambda (x) (f (f x)))))

(define (add a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))

(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1))))))

(cond ((= 3 3) 3)
      ((= 4 4) 4))

(define (^ a b)
  (if (= b 1)
      a
      (* a (^ a (- b 1)))))

(A 1 10) ;1024

(A 2 4) ;65536

(A 3 3) ;65536

(A 4 2)

(define (f n) (A 0 n)) ; 2n

(define (g n) (A 1 n)) ; 2^n

(define (h n) (A 2 n)) ; 2^h(n-1), h(1) = 2

(define (k n) (* 5 n n)) ; 5n^2

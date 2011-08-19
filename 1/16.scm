; recursive procedure

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (even? n)
  (= (remainder n 2) 0))

; tests
(= (fast-expt 3 2) 9)
(= (fast-expt 4 3) 64)

; iterative procedure

(define (** b n)
  (**-iter 1 b n))

(define (**-iter a b n)
  (cond ((= n 1) (* a b))
        ((even? n) (**-iter a (square b) (/ n 2)))
        (else (**-iter (* a b) (square b) (/ (- n 1) 2)))))

; tests
(= (** 3 2) 9)
(= (** 4 3) 64)

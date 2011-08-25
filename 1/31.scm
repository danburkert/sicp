(define (product term a next b)
  (if (> a b)
    1
    (* (term a)
       (product term (next a) next b))))

(define (identity x) x)
(define (inc x) (+ x 1))

(define (factorial x)
  (product identity 2 inc x))

; tests

(= (factorial 3) 6)
(= (factorial 5) 120)

; a)

(define (wallis-term k)
  (/ (square (* 2.0 k))
     (- (square (* 2.0 k)) 1)))

(define (pi n)
  (* 2
     (product wallis-term 1 inc n)))

; tests
(pi 100) ; 3.134
(pi 1000) ; 3.141

(define (product term a next b)
  (define (itr inv term a next b)
    (if (> a b)
      inv ; invariant quantity
      (itr (* inv (term a)) term (next a) next b)))
  (itr 1 term a next b))

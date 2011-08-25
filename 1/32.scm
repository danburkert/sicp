; a)

(define (accumulate combiner null-value term a next b)
  (if (> a b)
    null-value
    (combiner (term a)
              (accumulate combiner null-value term (next a) next b))))

; b)

(define (accumulate combiner null-value term a next b)
  (define (itr inv combiner term a next b)
    (if (> a b)
      inv
      (itr (combiner (term a) inv)
           combiner
           term
           (next a)
           next
           b)))
  (itr null-value combiner term a next b))

; tests

(define (inc n) (+ n 1))
(define (identity n) n)

(define (sum term a next b)
  (accumulate + 0 term a next b))

(define (product term a next b)
  (accumulate * 1 term a next b))

(define (factorial x)
  (product identity 2 inc x))


(= (sum identity 1 inc 5) 15)
(= (sum identity 0 inc 4) 10)
(= (factorial 3) 6)
(= (factorial 5) 120)

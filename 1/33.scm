(define (accumulate combiner filter null-value term a next b)
  (if (> a b)
    null-value
    (if (filter a)
      (combiner (term a)
                (accumulate combiner filter null-value term (next a) next b))
      (accumulate combiner filter null-value term (next a) next b))))

; a)

(define (inc n) (+ n 1))

(define (prime? n)
  (define (divides? a b)
    (= (remainder b a) 0))
  (define (smallest-divisor)
    (find-divisor 2))
  (define (find-divisor test-divisor)
    (define (next)
      (if (= test-divisor 2) 3 (+ test-divisor 2)))
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor (next)))))
  (= n (smallest-divisor)))

(define (prime-square-sum a b)
  (accumulate + prime? 0 square a inc b))

  ; test

(= (prime-square-sum 1 5) 39)

; b)


(define (co-prime-product n)
  (define (co-prime? x)
    (= (gcd x n) 1))
  (accumulate * co-prime? 1 identity 2 inc (- n 1)))

  ; test

(= (co-prime-product 8) 105)

(define (expmod base exp m)
  (define (check-nontrivial-root x)
    (if (and (not (or (= x 1) (= x (- m 1))))
             (= (remainder (square x) m) 1))
        0 x))
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (check-nontrivial-root (expmod base (/ exp 2) m)))
                    m))
        (else
         (remainder (* base (check-nontrivial-root (expmod base (- exp 1) m)))
                    m))))

(define (miller-rabin n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 2 (random (- n 2)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin n) (fast-prime? n (- times 1)))
        (else false)))

(eq? (fast-prime? 19 10) true)
(eq? (fast-prime? 113 10) true)
(eq? (fast-prime? 120 5) false)

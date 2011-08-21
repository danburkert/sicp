(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (carmichael-test n)
  (define (fermat-test a)
    (= (expmod a n n) a))
  (define (next i)
    (if (= i 2) 3 (+ i 2)))
  (define (itr i)
    (cond ((>= i n) true)
          ((fermat-test i) (itr (next i)))
          (else false)))
  (itr 2))

; tests

(eq? (carmichael-test 3) true)
(eq? (carmichael-test 5) true)
(eq? (carmichael-test 99) false)
(eq? (carmichael-test 103) true)

; Carmichael numbers: 561, 1105, 1729, 2465, 2821, 6601

(eq? (carmichael-test 561) true)
(eq? (carmichael-test 1105) true)
(eq? (carmichael-test 1729) true)
(eq? (carmichael-test 2465) true)
(eq? (carmichael-test 2821) true)
(eq? (carmichael-test 6601) true)

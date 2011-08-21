(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(expmod 3 5 5)

(remainder (* 3 (expmod 3 4 5)) 5))))

(remainder (* 3 (remainder (square (expmod 3 2 5)) 5)) 5)

(remainder (* 3 (remainder (square (remainder (square (expmod 3 1 5)) 5)) 5)) 5)

(remainder (* 3 (remainder (square ( remainder (square ( remainder (* 3 (expmod 3 0 5)) 5)) 5)) 5)) 5)

(remainder (* 3 (remainder (square ( remainder (square ( remainder (* 3 1) 5)) 5)) 5)) 5)

(remainder (* 3 (remainder (square (remainder (square (remainder 3 5)) 5)) 5)) 5)

(remainder (* 3 (remainder (square (remainder (square 3) 5)) 5)) 5)

(remainder (* 3 (remainder (square (remainder 9 5)) 5)) 5)

(remainder (* 3 (remainder (square 4) 5)) 5)

(remainder (* 3 (remainder 16 5)) 5)

(remainder (* 3 1) 5)

(remainder 3 5)

3

;tests


(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(expmod 3 5 5)

(remainder (fast-expt 3 5) 5)

(remainder (* 3 (fast-expt 3 4)) 5)

;fast-expt 3 4
(remainder (* 3 (square (fast-expt 3 2))) 5)

(remainder (* 3 (square (square (fast-expt 3 1)))) 5)

(remainder (* 3 (square (square (* 3 (fast-expt 3 0))))) 5)

(remainder (* 3 (square (square (* 3 1)))) 5)

(remainder (* 3 (square (square 3))) 5)

(remainder (* 3 (square 9)) 5)

(remainder (* 3 81) 5)

(remainder 243 5)

3

; It appears to me that Alyssa's method would be faster, because there are less remainder calls.
; The only way the first one would be faster is if remainder was significantly faster when being
; called on small numbers.
;
; Performance tests:

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 10000)
      (report-prime (- (runtime) start-time))
      #f))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  #t)

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))


(define (divides? a b)
  (= (remainder b a) 0))

(define (search-for-primes start end max-count)
  (define (search-iter n count)
    (cond ((or (= count max-count) (> n end)))
          ((even? n) (search-iter (+ n 1) count))
          ((timed-prime-test n) (search-iter (+ n 2) (+ 1 count)))
          (else (search-iter (+ n 1) count))))
  (search-iter start 0))

(search-for-primes 1000000000 10000000000 3) ; Original: 0.90, 0.85, 0.86
                                             ; Alyssa's: too slow

(search-for-primes 10000000000 100000000000 3) ; Origina;: 1.02, 0.98, 1.03
                                               ; Alyssa's: too slow

(search-for-primes 100000000000 1000000000000 3) ; Original: 1.17, 1.12, 1.20
                                                 ; Alyssa's: too slow


; Alyssa's version appears to be simpler (there are less remainder calls), but it
; is significantly slower.  I think this is because the square procedure is being called
; on progressively larger numbers, while in the original version square is never called on
; a number greater than the prime being tested (i.e. the modulus)

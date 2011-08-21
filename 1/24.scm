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

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))

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

; I had to test with a lot of random numbers to compensate for computing power
; It does appear that the times increase increase less than the previous expample

(search-for-primes 1000000000 10000000000 3) ; 0.88, 0.84, 0.86

(search-for-primes 10000000000 100000000000 3) ; 1.03, 0.97, 1.03

(search-for-primes 100000000000 1000000000000 3) ; 1.14, 1.14, 1.17

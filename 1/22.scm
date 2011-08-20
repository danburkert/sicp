(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))
      #f))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time)
  #t)


(define (prime? n)
  (define (smallest-divisor)
    (find-divisor 2))
  (define (find-divisor test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor (+ test-divisor 1)))))
  (= n (smallest-divisor)))

(define (divides? a b)
  (= (remainder b a) 0))

(define (search-for-primes start end max-count)
  (define (search-iter n count)
    (cond ((or (= count max-count) (> n end)))
          ((even? n) (search-iter (+ n 1) count))
          ((timed-prime-test n) (search-iter (+ n 2) (+ 1 count)))
          (else (search-iter (+ n 1) count))))
  (search-iter start 0))

; I had to bump the numbers a bit to compensate for increased computing power
; It does appear that the times increase with by a factor of sqrt(10) ~= 3.2

(search-for-primes 1000000000 10000000000 3) ; 0.08, 0.07, 0.06

(search-for-primes 10000000000 100000000000 3) ; 0.20, 0.20, 0.20

(search-for-primes 100000000000 1000000000000 3) ; 0.63, 0.62, 0.61

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
    (define (next)
      (if (= test-divisor 2) 3 (+ test-divisor 2)))
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor (next)))))
  (= n (smallest-divisor)))

(define (divides? a b)
  (= (remainder b a) 0))

(define (search-for-primes start end max-count)
  (define (search-iter n count)
    (cond ((or (= count max-count) (> n end)))
          ((even? n) (search-iter (+ n 1) count))
          ((timed-prime-test n) (search-iter (+ n 2) (+ 1 count)))
          (else (search-iter (+ n 2) count))))
  (search-iter start 0))

; I had to bump the numbers a bit to compensate for increased computing power
; The new times are not twice as fast, it seems to be roughly 1.3 times as fast.
; This may be because of the extra overhead of the (next) function call instead
; of a simple addition

(search-for-primes 1000000000 10000000000 3) ; new times: 0.06, 0.05, 0.04
                                             ; old times: 0.08, 0.07, 0.06

(search-for-primes 10000000000 100000000000 3) ; new times: 0.14, 0.14, 0.14
                                               ; old times: 0.20, 0.20, 0.20

(search-for-primes 100000000000 1000000000000 3) ; new times: 0.46, 0.42, 0.44
                                                 ; old times: 0.63, 0.62, 0.61

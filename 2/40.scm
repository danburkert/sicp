(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))
(define (enumerate-interval low high)
  (if (> low high)
    ()
    (cons low (enumerate-interval (+ low 1) high))))
(define (flatmap proc seq)
  (accumulate append () (map proc seq)))
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

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

(define (unique-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))



(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (unique-pairs n))))


; test

(unique-pairs 10)

(prime-sum-pairs 10)

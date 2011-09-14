(define (reverse items)
  (define (itr n)
    (if (= n 0)
      (cons (car items) ())
      (cons (list-ref items n) (itr (- n 1)))))
  (itr (- (length items) 1)))

(reverse (list 0 1 2 3 4)) ; 4 3 2 1 0

(define (square-list items)
  (if (null? items)
    ()
    (cons (square (car items)) (square-list (cdr items)))))

(define (square-list items)
   (map square items))

(square-list (list 1 2 3 4 5 6 7 8 9 10))

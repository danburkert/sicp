(define (my-equal? a b)
  (cond ((and (not (pair? a)) (not (pair? b)))
         (eq? a b))
        ((and (pair? a) (pair? b))
         (and (my-equal? (car a) (car b))
              (my-equal? (cdr a) (cdr b))))
        (else false)))

; test

(define num-list (list 1 2 3))

(equal? 1 1)
(my-equal? 1 1)

(equal? 'a 'a)
(my-equal? 'a 'a)

(equal? num-list num-list)
(my-equal? num-list num-list)

(equal? '(this is a list) '(this is a list))
(my-equal? '(this is a list) '(this is a list))




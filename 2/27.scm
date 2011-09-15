(define (reverse items)
  (define (iter things return)
    (if (null? things)
      return
      (iter (cdr things)
            (cons (car things) return))))
  (iter items ()))

(reverse (list 1 2 3 4))
(reverse (list (list 1 2) (list 3 4)))

(define (deep-reverse items)
  (define (iter things return)
    (cond ((null? things) return)
          ((pair? (car things))
           (iter (cdr things)
                 (cons (deep-reverse (car things)) return)))
          (else (iter (cdr things)
                      (cons (car things)
                            return )))))
  (iter items ()))




    (if (null? things)
      return
      (iter (cdr things)
            (cons (iter (car things) ())
                  return))))
  (iter items ()))

(deep-reverse (list 1 2 3 4))

(deep-reverse (list (list 1 2) (list 3 4))))

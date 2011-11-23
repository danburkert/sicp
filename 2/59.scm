(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
    set
    (cons x set)))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union set1 set2)
  (cond ((null? set2) set1)
        (else (union (adjoin-set (car set2) set1)
                     (cdr set2)))))

; test

(define set1 '(a b c d e f g))
(define set2 '(e f g h i j k))

(element-of-set? 'a set1)
(element-of-set? 'k set1)

(adjoin-set 'h set1)

(intersection-set set1 set2)

(union set1 set2)

(union set1 '())

(union '() set1)

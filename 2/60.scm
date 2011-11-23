(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cons x set))

(define (union-set set1 set2)
  (append set1 set2))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

; test

(define set1 '(a b c c a a b))
(define set2 '(c d e e e f f))

(element-of-set? 'a set1)
(element-of-set? 'd set1)

(adjoin-set 'h set1)

(intersection-set set1 set2)

(union set1 set2)

(union set1 '())

(union '() set1)

; discussion

; the efficiency of the adjoin operation is O(c) because it no longer has to check
; if the element already exists in the set.  The element-of-set? funciton is the same,
; but it could be slower since the list could have many many duplicates it needs to go through.
; Accordingly, the union and intersection will be faster in the best case, but slower in the
; worse case where the list has many duplicates.

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
    '()
    (let ((x1 (car set1)) (x2 (car set2)))
      (cond ((= x1 x2)
             (cons x1
                   (intersection-set (cdr set1)
                                     (cdr set2))))
            ((< x1 x2)
             (intersection-set (cdr set1) set2))
            ((< x2 x1)
             (intersection-set set1 (cdr set2)))))))

(define (adjoin-set x set)
  (define (iter item rest)
    (cond ((null? rest) (list item))
          ((< item (car rest))
              (cons item rest))
          (else (cons (car rest)
                      (iter item (cdr rest))))))
  (if (element-of-set? x set)
    set
    (iter x set)))

; test

(define set1 (list 1 3 5 7 9))

(adjoin-set 0 set1)

(adjoin-set 4 set1)

(adjoin-set 5 set1)

(adjoin-set 10 set1)

(cons (list 1 2 3) (list 3 4 5))

(cons (list 1) (list 2))

(cons 1 2)

(cons (list 1 2 3) (list 4))

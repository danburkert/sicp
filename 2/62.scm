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

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
          (let ((x1 (car set1)) (x2 (car set2)))
            (cond ((< x1 x2)
                   (cons x1 (union-set (cdr set1) set2)))
                  ((< x2 x1)
                   (cons x2 (union-set set1 (cdr set2))))
                  ((= x1 x2)
                   (cons x1 (union-set (cdr set1) (cdr set2)))))))))


; test

(define set1 (list 1 3 5 7 9))
(define set2 (list 2 4 5 6))

(union-set set1 set2)

(union-set (list 1 2 3 4) '())
(union-set '() (list 1 2 3 4))

(union-set (list 1 2 3 4 5) (list 4 5 6 7 8 9))

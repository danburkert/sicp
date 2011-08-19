(define (ss a b) (+ (* a a) (* b b)))

(define (least a b c)
  (cond ((and (< a b) (< a c)) a)
        ((and (< b a) (< b c)) b)
        ((and (< c a) (< c b)) c)))

(define (greatest_ss a b c) (ss (if (< a b) b a) (if (< b c) c b)))

(greatest_ss 4 3 7)

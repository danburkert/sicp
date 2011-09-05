(define (make-interval a b) (cons a b))
(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))
(define (sub-interval a b)
  (make-interval (- (lower-bound a) (upper-bound b))
                 (- (upper-bound a) (lower-bound b))))
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))
(define (div-interval x y)
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (width-interval x)
  (/ (- (upper-bound x)
        (lower-bound x))
     2))

; test

(define a (make-interval -10 0))
(define b (make-interval -10 -5))

(= (width-interval a) 5)
(= (width-interval b) (/ 5 2))

(width-interval (add-interval a b)) ; 15 / 2
(width-interval (sub-interval a b)) ; 15 / 2
(width-interval (mul-interval a b)) ; 50
(width-interval (div-interval a b)) ; 1

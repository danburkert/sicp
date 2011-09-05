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
  (if (or (and (positive? (upper-bound x)) (negative? (lower-bound x)))
          (and (positive? (upper-bound y)) (negative? (lower-bound y))))
    (error "Intervals must not span zero" x y)
    (mul-interval x
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y))))))

; test

(div-interval (make-interval -10 -5)
              (make-interval 10 11)) ; valid

(div-interval (make-interval -10 10)
              (make-interval 10 11)) ; invalid

(div-interval (make-interval 10 20)
              (make-interval 10 11)) ; valid

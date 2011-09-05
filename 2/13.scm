(define (make-interval a b) (cons a b))
(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))


(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))


(define (make-center-percent c p)
  (let ((w (* c (/ p 100))))
    (make-center-width c w)))

(define (percent i)
  (* 100 (/ (width i) (center i))))

; the tolerance of the product of two intervals is approximately the
; sum of the two tolerances, so:

(define (mul-interval x y)
  (make-center-percent (* (center x) (center y))
                       (+ (percent x) (percent y))))


; test

(mul-interval (make-center-percent 10 10)
              (make-center-percent 10 10)) ; is (80, 120), should be (81, 121)

(mul-interval (make-center-percent 10 10)
              (make-center-percent 5 20)) ; is (35, 65), should be (36, 66)

(mul-interval (make-center-percent 3.3 2)
              (make-center-percent 4.3 3.5))

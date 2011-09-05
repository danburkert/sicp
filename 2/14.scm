(define (make-interval a b) (cons a b))
(define (lower-bound x) (car x))
(define (upper-bound x) (cdr x))
(define (sub-interval a b)
  (make-interval (- (lower-bound a) (upper-bound b))
                 (- (upper-bound a) (lower-bound b))))
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))
(define (div-interval x y)
  (if (or (and (positive? (upper-bound x)) (negative? (lower-bound x)))
          (and (positive? (upper-bound y)) (negative? (lower-bound y))))
    (error "Intervals must not span zero" x y)
    (mul-interval x
                  (make-interval (/ 1.0 (upper-bound y))
                                 (/ 1.0 (lower-bound y))))))
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

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

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(par1 (make-interval 99 101)
      (make-interval 99 101)) ; (48.5198, 51.5202)
(par2 (make-interval 99 101)
      (make-interval 99 101)) ; (49.5, 50.5)

(par1 (make-interval 999 1001)
      (make-interval 99 101)) ; (89,75, 92.08)
(par2 (make-interval 999 1001)
      (make-interval 99 101)) ; (90.07m 91.74)

(percent (par1 (make-interval 99 101)
               (make-interval 99 101))) ; 2.999
(percent (par2 (make-interval 99 101)
               (make-interval 99 101))) ; 1.000

; the par2 function results in tighter intervals

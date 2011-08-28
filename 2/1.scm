(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))
(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))
(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

; test

(print-rat (add-rat (make-rat 3 4) (make-rat 1 2)))

(define neg-one-half (make-rat 1 -2))
(print-rat neg-one-half)


; 2.1

(define (make-rat n d)
  (let ((g (gcd n d))
        (den-sign (/ d (abs d))))
    (cons (* (/ n g) den-sign)
          (abs (/ d g)))))

; test

(equal-rat? (make-rat -3 -5) (make-rat 3 5))
(equal-rat? (make-rat -3 5) (make-rat 3 -5))

(equal-rat? (add-rat (make-rat 1 2) (make-rat -1 -2)) (make-rat 1 1))
(equal-rat? (add-rat (make-rat -1 2) (make-rat 13 2)) (make-rat 6 1))

(make-rat 1 1)
(make-rat -1 -1)
(make-rat 1 -1)
(make-rat -1 1)

(print-rat (make-rat -3 -5))

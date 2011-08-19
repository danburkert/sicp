(define (percent-change a b) (* 100 (/ (- b a) a)))

(define (improve y x)
  (/ (+ (/ x (square y))
        (* 2 y))
     3))

(define (good-enough? guess previous-guess)
  (< (abs (percent-change guess previous-guess))
     .001))

(define (crt-iter guess previous-guess x)
  (if (good-enough? guess previous-guess)
      guess
      (crt-iter (improve guess x) guess x)))

(define (crt x) (crt-iter 1.0 0 x))

(* (crt .001) (crt .001))

(crt 8)

(crt 900000000000000000000000000)

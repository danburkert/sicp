(define (average x y)
  (/ (+ x y) 2))

(define (percent-change a b) (* 100 (/ (- b a) a)))

; test percent_change funtion
(= (percent-change 1 3) 200)

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess previous-guess)
  (< (abs (percent-change guess previous-guess))
     .001))

(define (sqrt-iter guess previous-guess x)
  (if (good-enough? guess previous-guess)
      guess
      (sqrt-iter (improve guess x) guess x)))

(define (sqrt x) (sqrt-iter 1.0 0 x))

(* (sqrt .001) (sqrt .001))

(sqrt 900000000000000000000000000)

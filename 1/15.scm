(define (cube x) (* x x x))

(define (p x) (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

(sine 12.5)

; (sine 12.5)
; (p (sine 4.1666))
; (p (p (sine 1.38888)))
; (p (p (p (sine .46296293333))))
; (p (p (p (p (sine .154321)))))
; (p (p (p (p (p (sine .054144))))))
;
; p is called 5 times
;
; The order of growth in space and number
; number os steps is log base 3.  for every
; tripling of the angle, another 'unit' of
; space (p procedure) is needed.

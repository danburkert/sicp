(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))
; this procedure generates a recursive process, because
; the procedure has to keep track of the number of
; increments incurred:

; (+ 4 5)
; (inc (+ 3 5))
; (inc (inc (+ 2 5)))
; (inc (inc (inc (+ 1 5))))
; (inc (inc (inc (inc (+ 0 5)))))
; (inc (inc (inc (inc 5))))
; (inc (inc (inc 6)))
; (inc (inc 7))
; (inc 8)
; 9

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

; this procedure generates an iterative process, no state
; beyond the passed in variables is recorded:
; (+ 4 5)
; (+ 3 6)
; (+ 2 7)
; (+ 1 8)
; (+ 0 9)
; 9

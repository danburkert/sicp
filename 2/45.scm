; this was written / run on the Dr. Racket software package, mit scheme does
; not have support for painters (or at least not easily out of the box)

#lang racket

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

; old definitions

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))


(define (split transform1 transform2)
  (lambda (painter n)
    (if (= n 0)
      painter
      (let ((smaller ((split transform1 transform2) painter (- n 1)))) ; TODO: ask prof Weimer if this is less efficient than using a non-anonymous function inside the outer define
        (transform1 painter (transform2 smaller smaller))))))

(define right-split2 (split beside below))

(define up-split2 (split below beside))



; test

(paint (up-split einstein 4))
(paint (right-split einstein 4))

(paint (up-split2 einstein 4))
(paint (right-split2 einstein 4))

; for fun

(paint ((split beside beside) einstein 3))

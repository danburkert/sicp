; this was written / run on the Dr. Racket software package, mit scheme does
; not have support for painters (or at least not easily out of the box)

#lang racket

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))


(paint einstein)
(paint (flip-vert einstein))
(paint (flip-horiz einstein))

   
(define (flip-v painter)
  ((transform-painter (make-vect 0.0 1.0)
                      (make-vect 1.0 1.0)
                      (make-vect 0.0 0.0)) painter))


((transform-painter (make-vect 0.0 1.0)
                    (make-vect 1.0 1.0)
                    (make-vect 0.0 0.0))
 einstein)

; this was written / run on the Dr. Racket software package, mit scheme does
; not have support for painters (or at least not easily out of the box)

#lang racket

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (flip-v painter)
  ((transform-painter (make-vect 0.0 1.0)
                      (make-vect 1.0 1.0)
                      (make-vect 0.0 0.0)) painter))

(define (flip-h painter)
  ((transform-painter (make-vect 1.0 0.0)
                      (make-vect 0.0 0.0)
                      (make-vect 1.0 1.0)) painter))

(define (rotate-180 painter)
  ((transform-painter (make-vect 1.0 1.0)
                      (make-vect 0.0 1.0)
                      (make-vect 1.0 0.0)) painter))

(define (rotate-270 painter)
  ((transform-painter (make-vect 0.0 1.0)
                      (make-vect 0.0 0.0)
                      (make-vect 1.0 1.0)) painter))

; test
(paint einstein)

(paint (flip-vert einstein))
(paint (flip-v einstein))

(paint (flip-horiz einstein))
(paint (flip-h einstein))

(paint (rotate-180 einstein))
(paint (rotate-270 einstein))

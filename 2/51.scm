; this was written / run on the Dr. Racket software package, mit scheme does
; not have support for painters (or at least not easily out of the box)

#lang racket

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))
(define (rotate-180 painter)
  ((transform-painter (make-vect 1.0 1.0)
                      (make-vect 0.0 1.0)
                      (make-vect 1.0 0.0)) painter))

(define (rotate-270 painter)
  ((transform-painter (make-vect 0.0 1.0)
                      (make-vect 0.0 0.0)
                      (make-vect 1.0 1.0)) painter))


(define (my-beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0)))
    (let ((paint-left
           ((transform-painter (make-vect 0.0 0.0)
                               split-point
                              (make-vect 0.0 1.0)) painter1))
          (paint-right
           ((transform-painter split-point
                               (make-vect 1.0 0.0)
                               (make-vect 0.5 1.0)) painter2)))
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

(define (my-below painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-above
           ((transform-painter split-point
                               (make-vect 1.0 0.5)
                               (make-vect 0.0 1.0)) painter2))
          (paint-below
           ((transform-painter (make-vect 0.0 0.0)
                               (make-vect 1.0 0.0)
                               split-point) painter1)))
      (lambda (frame)
        (paint-below frame)
        (paint-above frame)))))

(define (my-below2 painter1 painter2)
  (rotate-270 (my-beside (rotate-270 (rotate-180 painter1))
                         (rotate-270 (rotate-180 painter2)))))
  

; test

(paint einstein)

(paint (beside einstein einstein))
(paint (my-beside einstein einstein))

(paint (below einstein einstein))
(paint (my-below einstein einstein))

(paint (my-below2 einstein einstein))

; this was written / run on the Dr. Racket software package, mit scheme does
; not have support for painters (or at least not easily out of the box)

; TODO: ask professor Weimer whether the primitive painter should take a frame
;       as an argument

#lang racket

(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

; a)

(define (outline-painter frame)
  (let ((origin (frame-origin frame)))
    (let ((a origin)
          (b (vector-add origin (frame-edge1 frame)))
          (c (vector-add origin
                         (vector-add (frame-edge1 frame)
                                     (frame-edge2 frame))))
          (d (vector-add origin (frame-edge2 frame))))
      (segments->painter
        (list (make-segment a b)
              (make-segment b c)
              (make-segment c d)
              (make-segment d a))))))

; b)

(define (cross-painter frame)
  (let ((origin (frame-origin frame)))
    (let ((a origin)
          (b (vector-add origin (frame-edge1 frame)))
          (c (vector-add origin
                         (vector-add (frame-edge1 frame)
                                     (frame-edge2 frame))))
          (d (vector-add origin (frame-edge2 frame))))
      (segments->painter
        (list (make-segment a c)
              (make-segment b d))))))

; c)


(define (diamond-painter frame)
  (let ((origin (frame-origin frame))
        (e1 (frame-edge1 frame))
        (e2 (frame-edge2 frame)))
    (let ((a (vector-add origin
                         (vector-scale 0.5 e1)))
          (b (vector-add origin
                         (vector-add e1
                                     (vector-scale 0.5 e2))))
          (c (vector-add origin
                         (vector-add e2
                                     (vector-scale 0.5 e1))))
          (d (vector-add origin
                         (vector-scale 0.5 e2))))
      (segments->painter
       (list (make-segment a b)
             (make-segment b c)
             (make-segment c d)
             (make-segment d a))))))

; d)
; I'm going to skip this part because its tedious...

; test
(define f (make-frame (make-vect 0.1 0.2)
                      (make-vect 0.3 0.5)
                      (make-vect 0.5 0.3)))


(paint (outline-painter f))
(paint (cross-painter f))
(paint (diamond-painter f))

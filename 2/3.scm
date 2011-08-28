(define (make-point x y)
  (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))

(define (make-segment start-point end-point)
  (cons start-point end-point))
(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))

(define (midpoint-segment segment)
  (make-point (average (x-point (start-segment segment))
                       (x-point (end-segment segment)))
              (average (y-point (start-segment segment))
                       (y-point (end-segment segment)))))

(define (length-segment segment)
  (sqrt (+ (square (- (x-point (start-segment segment))
                      (x-point (end-segment segment))))
           (square (- (y-point (start-segment segment))
                      (y-point (end-segment segment)))))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

; the first representation of a rectangle will be defined
; with the two diagonals of the rectangle.  In this case
; there is no relative axis, so height and width are just
; the names of the two kinds of segment lengths in the rectangle.

(define (make-rect diag-segment-a diag-segment-b)
  (cons diag-segment-a diag-segment-b))
(define (height-rect rectangle)
  (length-segment
    (make-segment
      (start-segment (car rectangle))
      (start-segment (cdr rectangle)))))
(define (width-rect rectangle)
  (length-segment
    (make-segment
      (start-segment (car rectangle))
      (end-segment (cdr rectangle)))))

(define (perim-rect rectangle)
  (* (+ (height-rect rectangle)
        (width-rect rectangle))
     2))

(define (area-rect rectangle)
  (* (height-rect rectangle) (width-rect rectangle)))

(area-rect (make-rect (make-segment (make-point 0 0)
                                      (make-point 10 10))
                        (make-segment (make-point 0 10)
                                      (make-point 10 0))))

; I think it is easy to see how I could change make-rect, width-rect,
; and height-rect to use a different format and the area and perimeter
; procedures would still work.  I would probably change the rectangle to
; store an origin (corner point) and the two segments terminating at that
; origin.

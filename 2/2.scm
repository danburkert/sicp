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

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

(print-point (make-point 4 5))

(print-point (midpoint-segment
               (make-segment (make-point 0 0)
                             (make-point 12 6))))

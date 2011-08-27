; a)
(define (cont-frac n d k)
  (define (iter i)
    (if (>= i k)
      (/ (n i) (d i))
      (/ (n i) (+ (d i) (iter (+ i 1))))))
  (iter 1))

; test
( / 1
    (cont-frac (lambda (i) 1.0)
               (lambda (i) 1.0)
               13))
; b)
(define (cont-frac n d k)
  (define (iter frac i)
    (let ((term (/ (n i) (+ (d i) frac))))
      (if (= i 1)
        term
        (iter term (- i 1)))))
  (iter 0 k))

; test
( / 1
    (cont-frac (lambda (i) 1.0)
               (lambda (i) 1.0)
               13))

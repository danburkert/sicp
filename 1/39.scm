(define (cont-frac n d k)
  (define (iter frac i)
    (let ((term (/ (n i) (+ (d i) frac))))
      (if (= i 1)
        term
        (iter term (- i 1)))))
  (iter 0 k))

(define e (+ 2 (cont-frac (lambda (i) 1.0)
                 (lambda (i)
                   (cond ((= (remainder i 3) 2)
                          (* (+ i 1) (/ 2 3)))
                         (else 1)))
                 100)))

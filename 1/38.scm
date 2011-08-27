(define (cont-frac n d k)
  (define (iter frac i)
    (let ((term (/ (n i) (- (d i) frac))))
      (if (= i 1)
        term
        (iter term (- i 1)))))
  (iter 0 k))

(define (tan-cf x k)
  (/ (cont-frac (lambda (i) (square x))
                (lambda (i) (- (* 2 i) 1))
                k)
     x))


(tan-cf 1.0 10) ; .575080915

(tan 1.0)

(define (make-from-mag-ang magnitude angle)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* magnitude (cos angle)))
          ((eq? op 'imag-part) (* magnitude (sin angle)))
          ((eq? op 'magnitude) magnitude)
          ((eq? op 'angle) angle)
          (else
            (error "Unknown operation -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)

; Original:
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

; Louis' Version:
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m)
                       (expmod base (/ exp 2) m))
                    m))
        (else
          (remainder (* base (expmod base (- exp 1) m))
                     m))))

; I believe that Louis' version would be exactly the same as the book
; version if the scheme interpreter used normal order evaluation (since
; the expmod procedure would be passed to square instead of just
; the value).
;
; Because Scheme used an applicative order evaluation, Louis has
; forced his expmod procedure to call itself recursively twice (in
; the worst case).  Because it also cuts the remaining complexity in
; half each time, the complexity is essentially linear.

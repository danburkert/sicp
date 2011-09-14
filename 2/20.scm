; this is essentially a one use filter function, and lo and behold
; scheme includes a filter function

(define (same-parity? . items)
  (if (even? (car items))
    (filter even? items)
    (filter odd? items)))

(same-parity? 1 2 3 4 5 6 7 8 9)

; applicative order evaluation: the program will evaluate the function p,
;   which is defined as itself, thus entering an infinite loop.
;
; normal order evaluation: the program will return 0, because the argument (p)
;   is never evaluated:
;
; (test 0 (p))
;
; (if (= 0 0)
; 0
; (p))

(define (p) (p))

(define (test x y)
  (if (= x 0)
    0
    y))

(test 0 (p))

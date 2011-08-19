; a-plus-abs-b takes arguments a and b.  It returns
; a + |b|, that is, a + b if b >= 0, or a - b if b < 0

(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

(a-plus-abs-b 1 -3)

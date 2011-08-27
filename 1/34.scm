(define (f g)
  (g 2))

(f f) ; "The object 2 is not applicable"

; Associative Order:

(f f)
(f 2)
(2 2)

; (f f) resolves to (2 2) which is clearly not valid

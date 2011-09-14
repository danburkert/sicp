; the challenge here is figuring out how to get the side effect of
; calling (proc (car items))

; TODO: talk to professor Weimer about best way to implement the side
; effect, or how to call two functions in a row, not using the return
; of one.

(define (for-each proc items)
  (if (or (proc (car items))
          (not (null? items)))
    (for-each proc (cdr items))))

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

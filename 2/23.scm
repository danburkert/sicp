(define (for-each proc items)
  (if (not (null? items))
    ((lambda (x) (for-each proc (cdr items))) (proc (car items))))))

; test

(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

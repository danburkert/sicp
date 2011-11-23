(define (encode message tree)
  (if (null? message)
    ()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (if (not (memq symbol (symbols tree)))
    (error "symbol not in tree -- ENCODE-SYMBOL" symbol)
    (cond ((leaf? tree) ())
          ((memq symbol (symbols (left-branch tree)))
           (cons '0 (encode-symbol symbol (left-branch tree))))
          ((memq symbol (symbols (right-branch tree)))
           (cons '1 (encode-symbol symbol (right-branch tree)))))))

; The order of growth of the encode-symbol function is O(N^2), because
; for each iteration of the functoin it much search the current nodes
; symbols, which is an n operation time (searching an unordered list).
; In the worst case the function will be called n times per symbol lookup,
; (in the case of the least frequently used symbol in a tree like in
; excercise 71), thus the total complexity is n*n = n^2.

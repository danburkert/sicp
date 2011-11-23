(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))




(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

(list->tree (list 1 3 5 7 9))

; a) partial tree is a recursive function which takes a flat list of
; elements and the number of elements of the list which should be
; made into a tree.  The function procedes to create a tree with the
; left branch being function applied recursively to the list of elements
; and the first (n - 1) `quotient` 2 elements.  The value of the tree element
; is the next element in the list, and the right subtree is the function
; recursively called on the second half of the list.  The base case is
; if n = 0, in which cast the tree returned is nil.


; b) the order of growth is O(n), because the function has to be recursively
; called for each of the elements of the list, but there are no other
; intensive operations.

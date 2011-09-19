(define (tree-map procedure tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
           (tree-map procedure sub-tree)
           (procedure sub-tree)))
       tree))

(define (square-tree tree) (tree-map square tree))

; test
(square-tree
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))

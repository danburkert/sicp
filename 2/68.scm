(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))
(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))
(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
    (list (symbol-leaf tree))
    (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
    (weight-leaf tree)
    (cadddr tree)))
(define (decode bits tree)
  (define (decode* bits current-branch)
    (if (null? bits)
      ()
      (let ((next-branch
              (choose-branch (car bits) current-branch)))
        (if (leaf? next-branch)
          (cons (symbol-leaf next-branch)
                (decode* (cdr bits) tree))
          (decode* (cdr bits) next-branch)))))
  (decode* bits tree))
(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit -- CHOOSE-BRANCH" bit))))
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))
(define (make-leaf-set pairs)
  (if (null? pairs)
    ()
    (let ((pair (car pairs)))
      (adjoin-set (make-leaf (car pair)   ; symbol
                             (cadr pair)) ; frequency
                  (make-leaf-set (cdr pairs))))))


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


(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                    (make-leaf 'B 2)
                    (make-code-tree (make-leaf 'D 1)
                                    (make-leaf 'C 1)))))

; test

(encode '(a d a b b c a) sample-tree) ; (0 1 1 0 0 1 0 1 0 1 1 1 0)

(encode '(a d a b b c z) sample-tree) ; throws error

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
      '()
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
    '()
    (let ((pair (car pairs)))
      (adjoin-set (make-leaf (car pair)   ; symbol
                             (cadr pair)) ; frequency
                  (make-leaf-set (cdr pairs))))))
(define (encode message tree)
  (if (null? message)
    '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))
(define (encode-symbol symbol tree)
  (if (not (memq symbol (symbols tree)))
    (error "symbol not in tree -- ENCODE-SYMBOL" symbol)
    (cond ((leaf? tree) '())
          ((memq symbol (symbols (left-branch tree)))
           (cons '0 (encode-symbol symbol (left-branch tree))))
          ((memq symbol (symbols (right-branch tree)))
           (cons '1 (encode-symbol symbol (right-branch tree)))))))
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))
(define (successive-merge leaf-set)
  (if (= 1 (length leaf-set))
    leaf-set
    (let ((left (car leaf-set))
          (right (cadr leaf-set))
          (rest (cddr leaf-set)))
      (if (null? rest)
        (make-code-tree left right)
        (successive-merge
          (adjoin-set (make-code-tree left right)
                      rest))))))



; test

(define message '(GET A JOB
                      SHA NA NA NA NA NA NA NA NA
                      GET A JOB
                      SHA NA NA NA NA NA NA NA NA
                      WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
                      SHA BOOM))

(define tree (generate-huffman-tree '((NA 16) (YIP 9) (SHA 3) (A 2)
                                      (GET 2) (JOB 2) (WAH 1) (BOOM 1))))

(equal? message (decode (encode message tree) tree)) ; true

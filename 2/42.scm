(define (enumerate-interval low high)
  (if (> low high)
    ()
    (cons low (enumerate-interval (+ low 1) high))))
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))
(define (flatmap proc seq)
  (accumulate append () (map proc seq)))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list empty-board)
      (filter
        (lambda (positions) (safe? k positions))
        (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

; if the board can be thought of queen's positions as (i, j) coordinates where i is the row and j is the
; column, I will represent the board as a list of queens sorted in column order, and storing the j (row)
; coordinate, thus the representation (list 1 3 2 ...) would represent a queen in row 1 of the first column,
; row 3 of the 2nd column, row 2 of the 3 column, etc.

; adjoin-position, tests that the new position is the correct one, otherwise returns rest-of-queens
(define (adjoin-position new-row k rest-of-queens)
  (if (eq? (length rest-of-queens)
           (- k 1))
    (append rest-of-queens (list new-row))
    ()))

; test
(adjoin-position 2 3 (list 1 3))
(adjoin-position 2 2 (list 1 3))

; empty-board
(define empty-board ())

; safe?

(define (safe? k positions)
  (let ((row (list-ref positions (- k 1))))
    (define (col-iter i)
      (if (< i k)
        (if (or (eq? (+ row (- k i))
                     (list-ref positions (- i 1)))
                (eq? (- row (- k i))
                     (list-ref positions (- i 1)))
                (eq? row
                     (list-ref positions (- i 1))))
          false
          (col-iter (+ i 1)))
        true))
    (col-iter 1)))

; test
(not (safe? 4 (list 4 1 3 4)))
(not (safe? 4 (list 1 3 2 4)))
(not (safe? 4 (list 1 3 2 4)))
(not (safe? 4 (list 1 2 3 4)))
(not (safe? 4 (list 1 2 3 3)))
(not (safe? 4 (list 4 3 2 1)))
(not (safe? 4 (list 1 2 3 1)))
(safe? 4 (list 2 1 1 4))


; test queens

(queens 4)

(queens 8)

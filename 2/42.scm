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

(define (place-queen new-row rest-of-queens)
  (append (list new-row) rest-of-queens))

(define (contains? list element)
  (cond ((null? list) false)
        ((= (car list) element) true)
        (else (contains? (cdr list) element))))

(define (diagonal-contain? new-queen safe-queens)
  (define (iter i safe-queens)
    (cond ((null? safe-queens) false)
          ((or (= (+ (car safe-queens) i) new-queen)
               (= (- (car safe-queens) i) new-queen)) true) ; check diagonals
          (else (iter (+ i 1) (cdr safe-queens)))))
  (iter 1 safe-queens))

(define (safe? positions)
  (let ((new-queen (car positions))
        (safe-queens (cdr positions)))
    (cond ((contains? safe-queens new-queen) false) ; check for same row
          ((diagonal-contain? new-queen safe-queens) false) ; check diagonals
          (else true))))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
      ()
      (filter
        (lambda (positions) (safe? positions))
        (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (place-queen new-row rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

; test

(place-queen 2 (list 1 2 3 4))

(contains? (list 3 4 5) 9)

(diagonal-contain? 4 (list 1 3 7))

(safe? (list 4 1 3 7 3 5 6 7))

(queens 8)

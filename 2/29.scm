(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

; a

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

; b

(define (branch-weight branch)
  (let ((structure (branch-structure branch)))
    (cond ((null? structure) 0)
          ((not (pair? structure)) structure)
          (else (total-weight structure)))))
(define (total-weight mobile)
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

; c

(define (balanced? mobile)
  (define (branch-torque branch)
    (* (branch-weight branch)
       (branch-length branch)))
  (define (branch-balanced? branch)
    (let ((structure (branch-structure branch)))
      (if (pair? structure)
        (balanced? structure)
        true)))
  (and (= (branch-torque (left-branch mobile))
          (branch-torque (right-branch mobile)))
       (branch-balanced? (left-branch mobile))
       (branch-balanced? (right-branch mobile))))

; d

(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-structure branch)
  (cdr branch))

; test

(define mob (make-mobile (make-branch 1.9 2.7)
                         (make-branch 3.2 (make-mobile (make-branch 1.3 1.3)
                                                       (make-branch 2.6 3.9)))))

(branch-length (left-branch mob))
(branch-structure (left-branch mob))
(left-branch mob)
(right-branch mob)
(total-weight mob)
(balanced? mob)

(define bal-mob (make-mobile (make-branch 4.0 2.5)
                             (make-branch 1.0 (make-mobile (make-branch 3.0 4.0)
                                                           (make-branch 2.0 6.0)))))

(define unbal-mob (make-mobile (make-branch 4.0 2.5)
                               (make-branch 1.0 (make-mobile (make-branch 3.0 4.0)
                                                             (make-branch 3.0 6.0)))))

(balanced? bal-mob)

(balanced? unbal-mob)

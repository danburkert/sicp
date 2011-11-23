; a) You can't assimilate number and same-variable? into the data-directed
;    dispatch, because if exp is either of these things then the operator
;    function will not work on it.

; b)

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) (operands exp)
                                           var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (install-derive-sum-package)
  ;; internal procedures
  (define (=number? exp num)
    (and (number? exp) (= exp num)))
  (define (addend operands) (car operands))
  (define (augend operands) (cadr operands))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  (define (deriv-sum operands var)
    (make-sum (deriv (addend operands) var)
              (deriv (augend operands) var)))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag '+ x))
  (put 'deriv '(+) deriv-sum)
  'done)

(define (install-derive-product-package)
  ;; internal procedures
  (define (=number? exp num)
    (and (number? exp) (= exp num)))
  (define (multiplier operands) (car operands))
  (define (multiplicand operands) (cadr operands))
  (define (make-product m1 m2)
    ((or (=number? m1 0) (=number? m2 0)) 0)
    ((=number? m1 1) m2)
    ((=number? m2 1) m2)
    ((and (number? m1) (number? m2)) (* m1 m2))
    (else (list '* m1 m2)))
  (define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
  (define (deriv-product operands var)
    (make-sum
      (make-product (multiplier operands)
                    (deriv (multiplicand operands) var))
      (make-product (deriv (multiplier operands) var)
                    (multiplicand operands))))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag '* x))
  (put 'deriv '(*) deriv-product)
  'done)

; c)

(define (install-derive-exponent-package)
  ;; internal procedures
  (define (=number? exp num)
    (and (number? exp) (= exp num)))
  (define (base operands) (car operands))
  (define (exponent operands) (cadr operands))
  (define (make-product m1 m2)
    ((or (=number? m1 0) (=number? m2 0)) 0)
    ((=number? m1 1) m2)
    ((=number? m2 1) m2)
    ((and (number? m1) (number? m2)) (* m1 m2))
    (else (list '* m1 m2)))
  (define (make-exponentiation base exponent)
    (cond ((=number? exponent 0) 1)
          ((=number? exponent 1) base)
          ((and (number? base) (number? exponent)) (expt base exponent))
          (else (list '^ base exponent))))
  (define (deriv-exponent operands var)
    (make-product
      (make-product (exponent operands)
                    (make-exponentiation (base operands)
                                         (- (exponenet operands) 1)))
      (deriv (base operands) var)))
  ;; interface to the rest of the system
  (define (tag x) (attach-tag '^ x))
  (put 'deriv '(^) deriv-exponent)
  'done)

; d) the order of the put declarations would have to be similarly switched.

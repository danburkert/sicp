(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        (else
          (error "unknown expression type -- DERIV" exp))))


; a

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

(define (addend s) (car s))

(define (augend s) (caddr s))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))

(define (multiplier p) (car p))

(define (multiplicand p) (caddr p))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

; test

(define x (make-sum 3 'c))
(addend x)
(augend x)
(sum? x)

(define y (make-product 3 'c))
(multiplier y)
(multiplicand y)
(product? y)

(deriv '(x + (3 * (x + (y + 2)))) 'x) ; 4

(deriv '(x * (y * (x + 3))) 'x)



; b ; TODO: Ask professor Weimer about this question, specifically how you would write addend

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))

(define (addend s) (car s))

(define (augend s)
  (let ((a (cddr s)))
    (if (> (length a) 1)
      a
      (car a))))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))

(define (multiplier p) (car p))

(define (multiplicand p)
  (let ((m (cddr p)))
    (if (> (length m) 1)
      m
      (car m))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

; test

(sum? '(a + b + c))

(addend '(a + b + c))

(augend '(a + b + c))

(augend '(a + b))

(product? '(a * b * c))

(multiplier '(a * b * c))

(multiplicand '(a * b * c))

(multiplicand '(a * b))

(deriv '(x + 3 * (x + y + 2)) 'x) ; 4

(deriv '(x * y * (x + 3)) 'x) ; ((x * y) + (y * (x + 3)))

(deriv '(x * y + 3 * x) 'x)

(memq '+ '(x + 3 * 4))

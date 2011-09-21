(define (enumerate-interval low high)
  (if (> low high)
    ()
    (cons low (enumerate-interval (+ low 1) high))))
(define (flatmap proc seq)
  (accumulate append () (map proc seq)))

(define (ordered-triples-sum n s)
  (define (triple-sum-s? triple)
    (= s
       (+ (car triple) (cadr triple) (caddr triple))))
  (filter triple-sum-s?
          (unique-triples n)))

(define (unique-triples n)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k) (list i j k))
                             (enumerate-interval 1 (- j 1))))
                      (enumerate-interval 1 (- i 1))))
            (enumerate-interval 1 n)))

; test

(unique-triples 5)

(triple-sum-s? (list 1 2 6) 8)

(ordered-triples-sum 10 8)

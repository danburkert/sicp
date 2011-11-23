(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((equal? given-key (key (car set-of-records)))
         (car set-of-records))
        (else (lookup given-key (cdr set-of-records)))))

(define (lookup given-key tree-of-records)
  (if (null? tree-of-records)
    false
    (let ((current-record (entry set-of-records)))
      (let ((current-key (key current-record)))
        (cond ((equal? given-key current-key) current-record)
              ((< given-key current-key) (lookup given-key (left-branch set-of-records)))
              (else (lookup given-key (right-branch set-of-records))))))))

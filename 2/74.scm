; a)
; Each division must have a method 'get-records' which returns a list of all records,
; and a method 'get-name' which can retrieve the name from a specified record.  these
; methods should be implemented in the data-directed manner.

(define (get-record employee generic-file)
  ((get 'get-record (division generic-file))
   employee (original-file generic-file)))

(define (make-generic-file division file)
  (cons division file))
(define (division generic-file)
  (car generic-file))
(define (original-file generic-file)
  (cdr generic-file))

; b)
; This should be done in a data-directed manner, thus every record should be tagged
; with the record type, and appropriate methods should be stored in the table.

(define (get-salary generic-record)
  ((get 'get-salary (division generic-record))
   (original-record generic-record)))

(define (make-generic-record division record)
  (cons division record))
(define (division generic-record)
  (car generic-record))
(define (original-record generic-record)
  (cdr generic-record))

; c)

(define (find-employee-record employee generic-files)
  (car (map (lambda (generic-file) (get-record employee generic-file))
            generic-files)))

; d)  The new division must add their get-record and get-salary functions to the table.

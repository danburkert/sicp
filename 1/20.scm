(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (remainder a b))))

; normal order evaluation:
; a = 206
; b = 40
(gcd 206 40)

(if (= 40 0)
    206
    (gcd 40 (remainder 206 40)))

; a = 40
; b = (remainder 206 40)
(gcd 40 (remainder 206 40))

(if (= (remainder 206 40) 0)
    40
    (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

; count += 1
(if (= 4 0)
    40
    (gcd (remainder 206 40) (remainder 40 (remainder 206 40))))

; a = (remainder 206 40)
; b = (remainder 40 (remainder 206 40))
(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))

(if (= (remainder 40 (remainder 206 40)) 0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

; count += 1
(if (= (remainder 40 4) 0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

; count += 1
(if (= 4 0)
    (remainder 206 40)
    (gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

;a = (remainder 40 (remainder 206 40))
;b = (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
(gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))

; ... this is getting boring...


; applicative order evaluation:

(gcd 206 40)

(gcd 40 (remainder 206 40))

(gcd 40 6)

(gcd 6 (remainder 40 6))

(gcd 6 4)

(gcd 4 (remainder 6 4))

(gcd 4 2)

(gcd 2 (remainder 4 2))

(gcd 2 2)

(gcd 2 (remainder 2 2))

(gcd 2 0)

2

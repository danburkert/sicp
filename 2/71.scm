; for n = 5


; (
;         /\
;  (A5 16)  ({A1 A2 A3 A4} 15)
;                 /\
;           (A4 8)  ({A1 A2 A3} 7)
;                         /\
;                   (A3 4)  ({A1 A2} 3)
;                                /\
;                           (A2 2) (A1 1)
; )
;
; I'm not going to sketch for n = 10, because it is tedious
;
; In general, in such a huffman encoding 1 bit is needed to encode the most
; frequent symbol.  (n-1) bits are needed to encode the least frequent symbol.

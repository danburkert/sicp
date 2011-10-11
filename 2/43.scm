; swapping the order of calls means that instead of a linear recursive process
; the function is now tree recursive.  This happens because for ever new column
; the previous columns are processed again.  This means that the O is exponential
; with respect to T, or O(T^board-size)

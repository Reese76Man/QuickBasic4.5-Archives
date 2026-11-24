DEFINT A-Z
INPUT "Enter .SPT filename:", f$
g$ = f$ + ".DTA"
f$ = f$ + ".SPT"
OPEN f$ FOR INPUT AS 1
OPEN g$ FOR OUTPUT AS 2
t$ = "REM DATA FOR " + f$
PRINT #2, t$
10 t$ = "DATA "
FOR st = 1 TO 35: INPUT #1, p$: : t$ = t$ + p$ + ","
IF EOF(1) <> 0 THEN GOTO 15
NEXT st
15 t$ = LEFT$(t$, LEN(t$) - 1): PRINT #2, t$: t$ = ""
IF EOF(1) = 0 THEN GOTO 10
CLOSE 1, 2



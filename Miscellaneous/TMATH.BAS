DEFDBL A-Z
ON ERROR GOTO 6
cd$ = COMMAND$
1 IF RIGHT$(cd$, 1) = CHR$(32) THEN cd$ = LEFT$(cd$, LEN(cd$) - 1): GOTO 1
COLOR 4: PRINT
PRINT "T-Math v1.0 QuickDos TRONiX Developer's Math Utility"
COLOR 9
PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴": PRINT : COLOR 7
IF LEN(cd$) < 3 THEN PRINT "Usage: TMATH [##] [+,-,/,*,^,S] [##]": END
FOR t = 1 TO LEN(cd$)
w$ = MID$(cd$, t, 1)
IF w$ = CHR$(32) THEN ct = ct + 1: GOTO 2
IF ct = 0 THEN f$ = f$ + w$
IF ct = 1 THEN g$ = UCASE$(w$)
IF ct = 2 THEN s$ = s$ + w$
2 IF ct = 3 THEN ct = 1: GOTO 3
NEXT t
3 f = VAL(f$): s = VAL(s$): IF y = 0 THEN y = 1 ELSE f = sum
IF g$ = "" THEN GOTO 5
IF g$ = "+" THEN sum = f + s
IF g$ = "-" THEN sum = f - s
IF g$ = "*" OR g$ = "X" THEN sum = f * s
IF g$ = "/" THEN sum = f / s
IF g$ = "^" THEN sum = f ^ s
IF g$ = "S" THEN sum = SQR(f)
IF y = 1 THEN y = 2: IF g$ <> "S" THEN PRINT f;
4 IF g$ <> "S" THEN PRINT " "; g$; " "; s; : IF t <= LEN(cd$) THEN s$ = "": g$ = "": GOTO 2
IF g$ = "S" THEN PRINT g$ + "QRT("; f; ")"; : IF t <= LEN(cd$) THEN g$ = LEFT$(s$, 1): s$ = "": ct = 2: GOTO 2
5 IF g$ <> "" AND y <> 1 THEN PRINT " = "; sum: END
6 PRINT "Error: Problem can not be solved!": END
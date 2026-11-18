DEFINT A-Z
DECLARE SUB gettext (x, y, t$, stp)
COLOR 7, 0: CLS : LOCATE 1, 20: PRINT "Tronix Security Defence System"
LOCATE 2, 20: PRINT "------------------------------"
p$ = UCASE$(CHR$(114) + CHR$(101) + CHR$(101) + CHR$(115) + CHR$(101) + CHR$(109) + CHR$(97) + CHR$(110) + CHR$(106) + CHR$(97) + CHR$(99) + CHR$(107))
LOCATE 5, 1: PRINT "Enter Password:"
gettext 5, 16, t$, LEN(p$)
IF t$ <> p$ THEN RUN

SUB gettext (x, y, t$, stp)
t$ = "": GOTO here:
back: G$ = UCASE$(INKEY$): LOCATE x, LEN(t$) + y, 1: IF G$ = "" THEN GOTO back:
IF ((ASC(G$) >= 32 AND ASC(G$) <= 92) OR G$ = " ") AND LEN(t$) < stp THEN t$ = t$ + G$
IF LEN(t$) > 0 AND G$ = CHR$(8) THEN t$ = LEFT$(t$, LEN(t$) - 1)
IF G$ = CHR$(13) THEN GOTO gow:
here:   IF y = 12 THEN
                IF (LEN(t$) = 2 OR LEN(t$) = 5) AND G$ <> CHR$(8) THEN t$ = t$ + "/"
                IF LEN(t$) > 2 THEN MID$(t$, 3) = "/"
                IF LEN(t$) > 5 THEN MID$(t$, 6) = "/"
        END IF
        COLOR 11, 9: LOCATE x, y: PRINT STRING$(LEN(t$), "X"); STRING$(stp - LEN(t$), " ")
GOTO back:
gow:
        IF y = 12 THEN
                IF LEN(t$) = 8 THEN MID$(t$, 3) = "/": MID$(t$, 6) = "/"
                IF LEN(t$) <> 8 OR VAL(t$) = 0 THEN t$ = "N/A"
                COLOR 11, 0: LOCATE x, y: PRINT STRING$(LEN(t$), "X"); STRING$(10 - LEN(t$), " ")
        END IF
        IF y >= 24 THEN COLOR 11, 0: LOCATE x, y - 1: PRINT USING "$######.##"; VAL(t$)

LOCATE , , 0
END SUB


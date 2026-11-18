DEFINT A-Y
DECLARE SUB GRID ()
DECLARE SUB GETTEXT (x, y, t$, stp)
DECLARE SUB STATS (t$)
SCREEN 0: WIDTH 80, 43: x = 1: xb = 1
DIM bill$(20), title$(7), due$(20)
DIM due(20), ndue(20), pdue(20)  AS SINGLE
reg$ = CHR$(71) + CHR$(114) + CHR$(101) + CHR$(103)
title$(1) = "The Bill  "
title$(2) = "Due Date  "
title$(3) = "Total Due "
title$(4) = "Next Due  "
title$(5) = "Past Due  "
title$(6) = "Paid Total"
title$(7) = "Balance   "

5 '                       ***BEGIN MONEY MANAGER***
COLOR 9, 0: LOCATE 1, 21: PRINT "Tronix Developers Money Manager v1.0": GRID
COLOR 11, 1: FOR t = 0 TO 6: LOCATE 3, ((11 * t) + 1): PRINT title$(t + 1): NEXT t
LOCATE 39, 1: PRINT "[A]dd Bill   [ENTER/P]ay Bill   [D]elete Bill               [ESC/Q]uit to dos"
LOCATE 40, 1: PRINT "                                                                             "
90 G$ = "": status$ = "This program registered to " + reg$ + ".": GOTO 105
'               `          ***BEGIN CHOICES***
100 G$ = UCASE$(INKEY$): IF G$ = "" THEN GOTO 190
105 FOR t = 1 TO 10
        LOCATE (xb * 2) + 3, t: COLOR 11, 0: PRINT CHR$(SCREEN((xb * 2) + 3, t))
        LOCATE (x * 2) + 3, t: COLOR 11, 1: PRINT CHR$(SCREEN((x * 2) + 3, t))
NEXT t:  g2$ = RIGHT$(G$, 1): xb = x
IF LEN(G$) > 1 THEN
        IF g2$ = "H" OR g2$ = "K" THEN x = x - 1: IF x = 0 THEN x = 17
        IF g2$ = "P" OR g2$ = "M" THEN x = x + 1: IF x = 18 THEN x = 1
        G$ = "": GOTO 90
END IF
IF x <> xb THEN G$ = "": GOTO 105
IF G$ = CHR$(27) OR G$ = "Q" THEN WIDTH 80, 25:  COLOR 7, 0: CLS : PRINT "Thanks for using MONEY MANAGER v1.0": PRINT "Tronix Developers 1995": PRINT : END
IF G$ = "A" THEN GOTO 200
190 '                ***THINGS TO DO IF KEY IS NOT PRESSED***
COLOR 9, 0: LOCATE 1, 1: PRINT TIME$: LOCATE 1, 68: PRINT DATE$
STATS status$
GOTO 100

200 '                   ***ENTER NEW BILL***
IF bill$(x) <> "" THEN status$ = "Sorry, that spot is already in use.": G$ = "": GOTO 105
STATS "Enter name of bill. EXAMPLES: LIGHT, VISA, WATER, RENT, HOUSE."
GETTEXT ((x * 2) + 3), 1, t$, 10: IF t$ = "" THEN GOTO 100 ELSE bill$(x) = t$
STATS "Enter next due date. EXAMPLES: 12/05/97, 05/28/97. Or leave blank."
GETTEXT ((x * 2) + 3), 12, t$, 8: due$(x) = t$
STATS "Enter amount due. EXAMPLES: 356.56, 1095, 124343.54"
LOCATE (x * 2) + 3, 23: PRINT "$"
GETTEXT ((x * 2) + 3), 24, t$, 9: due(x) = VAL(t$)
STATS "Enter amount due next. EXAMPLES: 356.56, 1095, 124343.54"
LOCATE (x * 2) + 3, 34: PRINT "$"
GETTEXT ((x * 2) + 3), 35, t$, 9: ndue(x) = VAL(t$)
STATS "Enter amount due if past due. EXAMPLES: 356.56, 1095, 124343.54"
LOCATE (x * 2) + 3, 45: PRINT "$"
GETTEXT ((x * 2) + 3), 46, t$, 9: pdue(x) = VAL(t$)
GOTO 100

SUB GETTEXT (x, y, t$, stp)
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
        IF y < 24 THEN
                COLOR 11, 9: LOCATE x, y: PRINT t$; STRING$(10 - LEN(t$), " ")
        ELSE
                COLOR 11, 9: LOCATE x, y: PRINT t$; STRING$(9 - LEN(t$), " ")
        END IF
GOTO back:
gow:  
        IF y = 12 THEN
                IF LEN(t$) = 8 THEN MID$(t$, 3) = "/": MID$(t$, 6) = "/"
                IF LEN(t$) <> 8 OR VAL(t$) = 0 THEN t$ = "N/A"
                COLOR 11, 0: LOCATE x, y: PRINT t$; STRING$(10 - LEN(t$), " ")
        END IF
        IF y >= 24 THEN COLOR 11, 0: LOCATE x, y - 1: PRINT USING "$######.##"; VAL(t$)

LOCATE , , 0
END SUB

SUB GRID
DEFINT A-Y
FOR t = 3 TO 40
LOCATE t, 1: IF p = 0 THEN p = 1 ELSE p = 0
FOR y = 1 TO 7
IF p = 0 THEN PRINT "컴컴컴컴컴�";
IF p = 1 THEN PRINT "          �";
NEXT y, t
END SUB

SUB STATS (t$)
LOCATE 41, 1: COLOR 11, 9: PRINT "STATUS: "; t$; STRING$(69 - LEN(t$), " ")
END SUB


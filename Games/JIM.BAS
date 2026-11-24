'$DYNAMIC
'$INCLUDE: 'jim.dat'
DEFINT A-Y
DEFDBL Z
CLS : SCREEN 13: RANDOMIZE TIMER

DIM BLNK(1 TO 405) AS INTEGER   ' SET IMAGE ARRAYS
DIM S(1 TO 405)  AS INTEGER
DIM U(1 TO 405)  AS INTEGER
DIM P(1 TO 405)  AS INTEGER
DIM e(1 TO 405)  AS INTEGER
DIM r(1 TO 405)  AS INTEGER
DIM j(1 TO 405)  AS INTEGER
DIM I(1 TO 405)  AS INTEGER
DIM M(1 TO 405)  AS INTEGER
DIM JIM(1 TO 405)  AS INTEGER
DIM JM2(1 TO 405)  AS INTEGER
DIM JM1(1 TO 405)  AS INTEGER
DIM JM3(1 TO 405)  AS INTEGER
GET (1, 1)-(40, 20), BLNK


FOR t = 1 TO 405: READ P1$: S(t) = VAL("&H" + P1$): NEXT t   'Load IMAGES
FOR t = 1 TO 405: READ P1$: U(t) = VAL("&H" + P1$): NEXT t
FOR t = 1 TO 405: READ P1$: P(t) = VAL("&H" + P1$): NEXT t
FOR t = 1 TO 405: READ P1$: e(t) = VAL("&H" + P1$): NEXT t
FOR t = 1 TO 405: READ P1$: r(t) = VAL("&H" + P1$): NEXT t
FOR t = 1 TO 405: READ P1$: j(t) = VAL("&H" + P1$): NEXT t
FOR t = 1 TO 405: READ P1$: I(t) = VAL("&H" + P1$): NEXT t
FOR t = 1 TO 405: READ P1$: M(t) = VAL("&H" + P1$): NEXT t
FOR t = 1 TO 405: READ P1$: JIM(t) = VAL("&H" + P1$): NEXT t
FOR t = 1 TO 405: READ P1$: JM2(t) = VAL("&H" + P1$): NEXT t
FOR t = 1 TO 405: READ P1$: JM1(t) = VAL("&H" + P1$): NEXT t
FOR t = 1 TO 405: READ P1$: JM3(t) = VAL("&H" + P1$): NEXT t

zps = 1: GOSUB 8000: k = tm: o = 1: zw = 1             'SET VARIABLES
w = 11: a$ = "Tronix Presents": GOSUB 999
w = 11: a$ = "A Diceman Production": GOSUB 999
w = 11: a$ = "Greater than all the gods": GOSUB 999

1 CLS : cc = 17         ' START INTRO
FOR j = 24 TO 320
zps = .05: GOSUB 8000
FOR t = 16 TO 30: LINE (j + t, 0)-(j + t, 200), t: NEXT t: c = 31
FOR t = 31 TO 45: c = c - 1: LINE (j + t, 0)-(j + t, 200), c: NEXT t
IF j AND 2 THEN
        cc = cc + 1: IF cc > 240 THEN cc = 17
        PAINT (319, 1), CHR$(cc) + CHR$(cc + 1) + CHR$(cc + 2) + CHR$(cc + 3) + CHR$(cc + 4) + CHR$(cc + 5) + CHR$(cc + 6) + CHR$(cc + 7) + CHR$(cc + 8), 16
END IF
IF j <= 300 THEN PUT (j - 23, 50), JIM, PSET
IF j = 300 THEN PUT (j - 23, 50), BLNK, PSET
IF j = 60 THEN PUT (j - 55, 50), S, PSET
IF j = 95 THEN PUT (j - 55, 50), U, PSET
IF j = 130 THEN PUT (j - 55, 50), P, PSET
IF j = 165 THEN PUT (j - 55, 50), e, PSET
IF j = 200 THEN PUT (j - 55, 50), r, PSET
IF j = 240 THEN PUT (j - 55, 50), j, PSET
IF j = 275 THEN PUT (j - 55, 50), I, PSET
IF j = 310 THEN PUT (j - 55, 50), M, PSET
FOR tm = 1 TO k: NEXT tm
NEXT j: k = k * 1
FOR j = 24 TO 156: PUT (j - 23, 90), JIM, PSET
FOR tm = 1 TO k: NEXT tm
NEXT j: PUT (j - 23, 90), JM2, PSET      'END INTRO

5 e = 1: w = 17: a$ = "Become Super-Jim     (Begin Game)": GOSUB 999
e = 1: w = 18: a$ = "Ancient scrolls (Super-Jim story)": GOSUB 999
e = 1: w = 19: a$ = "Become mortal       (Exit to DOS)": GOSUB 999

c$ = SPACE$(40) + "Tronix Presents... SUPER JIM ... Programming Corey Badeaux ... Graphical Art Corey Badeaux ... Concept & Design Corey Badeaux ... Special thanks to James (Jimbonizer) Pilet ... Choose your option" + SPACE$(40)
9 z = TIMER: e = e + 1: IF e = 5 THEN e = 1
IF e = 1 THEN PUT (j - 23, 90), JM1, PSET
IF e = 2 THEN PUT (j - 23, 90), JM2, PSET
IF e = 3 THEN PUT (j - 23, 90), JM3, PSET
IF e = 4 THEN PUT (j - 23, 90), JM2, PSET
10 a$ = UCASE$(INKEY$)
LOCATE o + 16, 1: FOR t = 1 TO 36: COLOR INT(RND * 255) + 1: PRINT CHR$(SCREEN(o + 16, t)); : NEXT t
zw = zw + .0005: LOCATE 1, 1: COLOR 30: PRINT MID$(c$, INT(zw), 40): IF zw > LEN(c$) - 40 THEN zw = 1
IF TIMER - z > 2 THEN GOTO 9
IF a$ = "" THEN GOTO 10
LOCATE o + 16, 1: FOR t = 1 TO 36: COLOR 31: PRINT CHR$(SCREEN(o + 16, t)); : NEXT t
IF RIGHT$(a$, 1) = "H" THEN o = o - 1: IF o < 1 THEN o = 3
IF RIGHT$(a$, 1) = "P" THEN o = o + 1: IF o > 3 THEN o = 1
IF a$ = CHR$(13) THEN
        IF o = 2 THEN GOTO 100
        IF o = 3 THEN GOTO 1000
END IF
GOTO 10

100 DEF SEG = &HA000
BSAVE "temp.vid", 0, 64000
CLS : e = 2: COLOR 16
LOCATE 1, 1: PRINT "Super Jim aka Jimbonizer was born in": GOSUB 200
LOCATE 1, 1: PRINT "the USA, but has powers from beyond.": GOSUB 200
LOCATE 1, 1: PRINT "Disquised as a typical TC employee,  ": GOSUB 200
LOCATE 1, 1: PRINT "he is set out on a mission, to get   ": GOSUB 200
LOCATE 1, 1: PRINT "the secret superchip Pentium 200 from": GOSUB 200
LOCATE 1, 1: PRINT "Mr. Richard. But Mr. Richard has his ": GOSUB 200
LOCATE 1, 1: PRINT "own band of followers to try and stop": GOSUB 200
LOCATE 1, 1: PRINT "Super Jim including Mr. Briski, Tech ": GOSUB 200
LOCATE 1, 1: PRINT "Support, Sales Department, and more. ": GOSUB 200
LOCATE 1, 1: PRINT "Jim's only hope is the powers he has ": GOSUB 200
LOCATE 1, 1: PRINT "and help from his buddies, Frank, Dan": GOSUB 200
LOCATE 1, 1: PRINT "CJ, & Reese.  The mission is long and": GOSUB 200
LOCATE 1, 1: PRINT "hard, but the rewards of recovering  ": GOSUB 200
LOCATE 1, 1: PRINT "the chip could result possibly  in   ": GOSUB 200
LOCATE 1, 1: PRINT "saving the world.                    ": GOSUB 200
SLEEP
DEF SEG = &HA000: BLOAD "temp.vid", 0: KILL "temp.vid": e = 1: GOTO 10

200 FOR t = 0 TO 320: y2 = 0: FOR y = 0 TO 8
IF POINT(t, y) = 16 THEN PSET (t, y + (e * 9)), INT(RND * 7) + 52
NEXT y, t: e = e + 1: RETURN

999 q = 21 - (LEN(a$) / 2)
FOR t = 16 TO 30: COLOR t: LOCATE w, q: PRINT a$
zps = .1: GOSUB 8000: NEXT t: IF tm = 50 THEN w = w + 1
IF e = 1 THEN e = 0: RETURN
zps = .2: GOSUB 8000: FOR t = 30 TO 16 STEP -1: COLOR t: LOCATE w, q: PRINT a$
zps = .1: GOSUB 8000: NEXT t
COLOR 30: RETURN

1000 SCREEN 0: WIDTH 80, 25: PRINT "Tronix Developers 1995  Corey Badeaux": PRINT : END

8000  z = TIMER: tm = 0
      DO UNTIL (TIMER - z > zps) OR (TIMER - z < 0)
      tm = tm + 1
      IF INKEY$ = CHR$(27) THEN GOTO 1000
      LOOP
RETURN



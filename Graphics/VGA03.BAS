DEFINT A-Y
SCREEN 12: CLS : RANDOMIZE TIMER: C = 0
10 LOCATE 25, 1: PRINT "TRONIX ' 94         'SABOTAGAL LINES'         BY: DICEMAN"
x = INT(RND * 400): y = INT(RND * 300) + 1
x1 = INT(RND * 400): y1 = INT(RND * 300) + 1
X2 = INT(RND * 400): Y2 = INT(RND * 300) + 1
x3 = INT(RND * 400): y3 = INT(RND * 300) + 1
X4 = INT(RND * 400): Y4 = INT(RND * 300) + 1
e1 = INT(RND * 600): f1 = INT(RND * 400) + 1
e2 = INT(RND * 600): f2 = INT(RND * 400) + 1
e3 = INT(RND * 600): f3 = INT(RND * 400) + 1
e4 = INT(RND * 600): f4 = INT(RND * 400) + 1
ee = 1: dd = 1: ff = 1

30 a$ = RIGHT$(STR$(INT(RND(1) * 9) + 1), 1): d$ = RIGHT$(STR$(INT(RND(1) * 9) + 1), 1): FOR t = 1 TO 20: FOR z = 1 TO 70: NEXT z
IF a$ = "5" THEN q = q + 1: IF q > 30 THEN q = 0: GOTO 10
IF a$ = "4" THEN x = x + 2: X2 = X2 - 2: x3 = x3 - 2: X4 = X4 + 2
IF a$ = "6" THEN x = x - 2: X2 = X2 + 2: x3 = x3 + 2: X4 = X4 - 2
IF a$ = "2" THEN y = y - 2: Y2 = Y2 - 2: y3 = y3 + 2: Y4 = Y4 + 2
IF a$ = "8" THEN y = y + 2: Y2 = Y2 + 2: y3 = y3 - 2: Y4 = Y4 - 2
IF a$ = "7" THEN x = x + 2: X2 = X2 + 2: x3 = x3 - 2: X4 = X4 - 2
IF a$ = "3" THEN x = x - 2: X2 = X2 - 2: x3 = x3 + 2: X4 = X4 + 2
IF a$ = "9" THEN y = y + 2: Y2 = Y2 - 2: y3 = y3 - 2: Y4 = Y4 + 2
IF a$ = "1" THEN y = y - 2: Y2 = Y2 + 2: y3 = y3 + 2: Y4 = Y4 - 2
IF d$ = "4" THEN e = e + 2: e2 = e2 - 2: e3 = e3 - 2: e4 = e4 + 2
IF d$ = "6" THEN e = e - 2: e2 = e2 + 2: e3 = e3 + 2: e4 = e4 - 2
IF d$ = "2" THEN f = f - 2: f2 = f2 - 2: f3 = f3 + 2: f4 = f4 + 2
IF d$ = "8" THEN f = f + 2: f2 = f2 + 2: f3 = f3 - 2: f4 = f4 - 2
IF d$ = "7" THEN e = e + 2: e2 = e2 + 2: e3 = e3 - 2: e4 = e4 - 2
IF d$ = "3" THEN e = e - 2: e2 = e2 - 2: e3 = e3 + 2: e4 = e4 + 2
IF d$ = "9" THEN f = f + 2: f2 = f2 - 2: f3 = f3 - 2: f4 = f4 + 2
IF d$ = "1" THEN f = f - 2: f2 = f2 + 2: f3 = f3 + 2: f4 = f4 - 2
REM c = INT(RND * 15) + 1
LINE (ox, oy)-(oe, of), C
LINE (oX2, oY2)-(oe2, of2), C
LINE (ox3, oy3)-(oe3, of3), C
LINE (oX4, oY4)-(oe4, of4), C

LINE (ox, oy)-(oX2, oY2), C
LINE (oX2, oY2)-(ox3, oy3), C
LINE (ox3, oy3)-(oX4, oY4), C
LINE (oX4, oY4)-(ox, oy), C
LINE (c1, c2)-(c3, c4), C
LINE (d1, d2)-(d3, d4), C
LINE (ox, oy)-(ox3, oy3), C
LINE (oX2, oY2)-(oX4, oY4), C
ox = x: oy = y: oX2 = X2: oY2 = Y2: ox3 = x3: oy3 = y3: oX4 = X4: oY4 = Y4
c2 = y + ((Y2 - y) / 2): c1 = x + ((X2 - x) / 2)
c4 = y3 + ((Y4 - y3) / 2): c3 = x3 + ((X4 - x3) / 2)
d1 = X2 + ((x3 - X2) / 2): d2 = Y2 + ((y3 - Y2) / 2)
d3 = X4 + ((x - X4) / 2): d4 = Y4 + ((y - Y4) / 2)
IF dd = 1 THEN LINE (c1, c2)-(c3, c4), 30
IF dd = 1 THEN LINE (d1, d2)-(d3, d4), 30
LINE (x, y)-(X2, Y2), 30
LINE (X2, Y2)-(x3, y3), 30
LINE (x3, y3)-(X4, Y4), 30
LINE (X4, Y4)-(x, y), 30
IF ee = 1 THEN LINE (x, y)-(x3, y3), 30
IF ee = 1 THEN LINE (X2, Y2)-(X4, Y4), 30

LINE (oe, of)-(oe2, of2), C
LINE (oe2, of2)-(oe3, of3), C
LINE (oe3, of3)-(oe4, of4), C
LINE (oe4, of4)-(oe, of), C
LINE (g1, g2)-(g3, g4), C
LINE (h1, h2)-(h3, h4), C
LINE (oe, of)-(oe3, of3), C
LINE (oe2, of2)-(oe4, of4), C
oe = e: of = f: oe2 = e2: of2 = f2: oe3 = e3: of3 = f3: oe4 = e4: of4 = f4
g2 = f + ((f2 - f) / 2): g1 = e + ((e2 - e) / 2)
g4 = f3 + ((f4 - f3) / 2): g3 = e3 + ((e4 - e3) / 2)
h1 = e2 + ((e3 - e2) / 2): h2 = f2 + ((f3 - f2) / 2)
h3 = e4 + ((e - e4) / 2): h4 = f4 + ((f - f4) / 2)
IF dd = 1 THEN LINE (g1, g2)-(g3, g4), 30
IF dd = 1 THEN LINE (h1, h2)-(h3, h4), 30
LINE (e, f)-(e2, f2), 30
LINE (e2, f2)-(e3, f3), 30
LINE (e3, f3)-(e4, f4), 30
LINE (e4, f4)-(e, f), 30
IF ee = 1 THEN LINE (e, f)-(e3, f3), 30
IF ee = 1 THEN LINE (e2, f2)-(e4, f4), 30

IF ff = 1 THEN LINE (x, y)-(e, f), 30
IF ff = 1 THEN LINE (X2, Y2)-(e2, f2), 30
IF ff = 1 THEN LINE (x3, y3)-(e3, f3), 30
IF ff = 1 THEN LINE (X4, Y4)-(e4, f4), 30
zz# = .00001: Gosub 8000
NEXT t
IF INKEY$ = "" THEN GOTO 30
SCREEN 0: WIDTH 80
PRINT "Thanks for watching 'SABOTAGAL LINES!' and may yours day be full of SCAMS!"
END

8000 z# = TIMER
      DO UNTIL (TIMER - z# > zz#) OR (TIMER - z# < 0)
      LOOP
      ' zz# = .01: Gosub 8000
RETURN
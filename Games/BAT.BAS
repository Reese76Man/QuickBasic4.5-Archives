DEFINT A-Z
CLS : SCREEN 13
DIM Image(1 TO 405)  AS INTEGER
DIM PreImage(1 TO 405)  AS INTEGER
DIM Subs(1 TO 405)  AS INTEGER
DIM PreSub(1 TO 405)  AS INTEGER
OPEN "bat_ship.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: Image(t) = VAL("&H" + p$): NEXT t: CLOSE 1
OPEN "bat_sub.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: Subs(t) = VAL("&H" + p$): NEXT t: CLOSE 1
CLS 'Draw battlefield
LINE (0, 50)-(320, 50), 3: PAINT (1, 1), 3, 3: PAINT (1, 199), 1, 3
CIRCLE (30, 16), 7, 15: PAINT (30, 16), 15, 15 ' Cloud 1
CIRCLE (40, 16), 9, 15: PAINT (40, 16), 15, 15
CIRCLE (50, 16), 7, 15: PAINT (50, 16), 15, 15

CIRCLE (210, 19), 7, 15: PAINT (210, 19), 15, 15 ' Cloud 2
CIRCLE (220, 19), 9, 15: PAINT (220, 19), 15, 15
CIRCLE (230, 19), 7, 15: PAINT (230, 19), 15, 15

CIRCLE (315, 5), 25, 14: PAINT (315, 5), 14, 14' The sun
LOCATE 1, 1: PRINT SPACE$(40): LOCATE 1, 1: PRINT "Check out this sizzling hot arcade game!"
y = 50: u = 40: yy = y: uu = u: GET (y, u)-(y + 39, u + 19), PreImage
q = 50: w = 150: qq = q: ww = w: GET (q, w)-(q + 39, w + 19), PreSub: q = q + 1
GOTO 20

10 q$ = INKEY$: zz# = .001: Gosub 8000
y = y + 1: IF y > 270 THEN y = 1
IF y > q AND dep = 0 THEN dep = 1: d = 10: k = y
IF dep = 1 THEN
        CIRCLE (k, u + d), 1, 1: d = d + 1: CIRCLE (k, u + d), 1, 4
        IF u + d > w AND d + u < w + 5 AND k > q AND k < q + 28 THEN
                dep = 0: LOCATE 1, 1: PRINT "BOOM!!!! Damn those torpedoes!!         ": CIRCLE (k, u + d), 1, 1
                FOR t = 1 TO 1000: PUT (q, w), Subs, OR: PUT (q, w), Subs, XOR: NEXT t
                LOCATE 1, 1: PRINT "                                        "
        END IF
        IF d > 175 THEN dep = 0: CIRCLE (k, u + d), 1, 1
END IF
IF RIGHT$(q$, 1) = "M" THEN q = q + 4: IF q > 270 THEN q = 270
IF RIGHT$(q$, 1) = "K" THEN q = q - 4: IF q < 10 THEN q = 10
IF RIGHT$(q$, 1) = "P" THEN w = w + 4: IF w > 175 THEN w = 175
IF RIGHT$(q$, 1) = "H" THEN w = w - 4: IF w < 75 THEN w = 75
IF q$ = CHR$(13) AND fire = 0 THEN fire = 1: h = w - 3: j = q + 12
IF fire = 1 THEN
        CIRCLE (j, h), 1, 1: h = h - 2: CIRCLE (j, h), 1, 14
        IF h < 54 THEN fire = 0: CIRCLE (j, h), 1, 1
END IF
IF UCASE$(q$) = "Q" OR q$ = CHR$(27) THEN GOTO 1000
20 PUT (yy, uu), PreImage, PSET: GET (y, u)-(y + 39, u + 19), PreImage: PUT (y, u), Image, XOR: yy = y: uu = u
IF qq <> q OR ww <> w THEN
        IF dep = 1 THEN CIRCLE (k, u + d), 1, 1
        PUT (qq, ww), PreSub, PSET: GET (q, w)-(q + 39, w + 19), PreSub: PUT (q, w), Subs, XOR: qq = q: ww = w
        IF dep = 1 THEN CIRCLE (k, u + d), 1, 4
END IF
GOTO 10

1000 SCREEN 0: WIDTH 80, 25: PRINT "Thanks for playing BATTLESUB v1.0.": PRINT : END

8000 z# = TIMER
      DO UNTIL (TIMER - z# > zz#) OR (TIMER - z# < 0)
      LOOP
      ' zz# = .01: Gosub 8000
RETURN
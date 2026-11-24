DEFINT A-Y
CLS : SCREEN 13: zv = 64: zt = 1: rou = 1
OUT &H3C8, 0: FOR t = 0 TO 255 * 3: OUT &H3C9, 0: NEXT t
FOR t = 0 TO 320: FOR y = 0 TO 200
PSET (t, y), y: NEXT y, t


5 OUT &H3C8, 0: FOR y = 0 TO (255 * zt) + lk: IF p = 0 THEN l = l + 1: IF l > 63 THEN p = 1
IF p = 1 THEN l = l - 1: IF l < 1 THEN p = 0: cnt = cnt + 1
IF cnt = 1000 THEN rou = rou + 1: cnt = 0: zv = 64: v = 0
IF rou = 1 THEN OUT &H3C9, l: OUT &H3C9, l: OUT &H3C9, l
IF rou = 2 THEN OUT &H3C9, l: OUT &H3C9, v: OUT &H3C9, v
IF rou = 3 THEN OUT &H3C9, l: OUT &H3C9, 0: OUT &H3C9, 0
IF rou = 4 THEN OUT &H3C9, v: OUT &H3C9, l: OUT &H3C9, 0
IF rou = 5 THEN OUT &H3C9, 0: OUT &H3C9, l: OUT &H3C9, 0
IF rou = 6 THEN OUT &H3C9, 0: OUT &H3C9, v: OUT &H3C9, l
IF rou = 7 THEN OUT &H3C9, 0: OUT &H3C9, 0: OUT &H3C9, l
IF rou = 8 THEN OUT &H3C9, l: OUT &H3C9, 63 - l: OUT &H3C9, v
IF rou = 9 THEN OUT &H3C9, 63 - v: OUT &H3C9, 63 - l: OUT &H3C9, l
IF rou = 10 THEN OUT &H3C9, v: OUT &H3C9, l: OUT &H3C9, 63 - v
IF rou = 11 THEN OUT &H3C9, l AND v: OUT &H3C9, l OR v: OUT &H3C9, l
IF rou = 12 THEN OUT &H3C9, v XOR l: OUT &H3C9, l AND v: OUT &H3C9, v
IF rou = 13 THEN OUT &H3C9, v: OUT &H3C9, l: OUT &H3C9, 63 - v
IF rou = 14 THEN OUT &H3C9, v XOR l: OUT &H3C9, l XOR v: OUT &H3C9, v XOR l
IF rou = 15 THEN OUT &H3C9, l: OUT &H3C9, v
IF rou = 16 THEN OUT &H3C9, l XOR v: OUT &H3C9, v AND l
IF rou = 17 THEN OUT &H3C9, l OR v: OUT &H3C9, v XOR l
IF rou = 18 THEN OUT &H3C9, l: OUT &H3C9, v: OUT &H3C9, 63 - l
IF rou = 19 THEN GOTO 1000
NEXT y
zv = zv - .15: IF zv < 0 THEN zv = 0 ELSE IF INKEY$ > "" THEN GOTO 1000
v = INT(zv): zz# = .01: Gosub 8000
IF lp = 0 THEN z = z + .1: IF z < 25 THEN lk = INT(z + 114) ELSE lp = 1
IF lp = 1 THEN z = z - .1: IF z > -5 THEN lk = INT(z + 114) ELSE lp = 0
IF lpl = 1 THEN gd = gd - 1: IF gd < 1 THEN lpl = 0
IF lpl = 0 THEN gd = gd + 1: IF gd > 157 THEN lpl = 1
OUT &H3D4, 13: OUT &H3D5, gd: GOTO 5

1000 SCREEN 0: WIDTH 80: CLS : COLOR 7, 0: PRINT "Programmed by: DICEMAN  TRONiX Developers 1994": END

8000 z# = TIMER
      DO UNTIL (TIMER - z# > zz#) OR (TIMER - z# < 0)
      LOOP
RETURN
DEFINT A-Y
SCREEN 12
5 zx = .175: x = 320: y = 200
cclr = INT(RND * 16) + 1
10 FOR t = 350 TO 0 STEP -10
p = INT(RND * 5) + 1
IF p = 1 THEN x = x + 7
IF p = 2 THEN x = x - 7
IF p = 3 THEN y = y + 7
IF p = 4 THEN y = y - 7
zx = zx + .01
CIRCLE (x, y), t, cclr, , , zx
NEXT t

zz# = .1: Gosub 8000

Goto 5


8000 z# = TIMER
      DO UNTIL (TIMER - z# > zz#) OR (TIMER - z# < 0)
      LOOP
      ' zz# = .01: Gosub 8000
RETURN

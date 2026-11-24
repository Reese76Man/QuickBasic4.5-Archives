DEFINT A-Z
SCREEN 13: RANDOMIZE TIMER: o = 100: DIM u(325)
10 zz# = .01: Gosub 8000
FOR y = 1 TO 4
p = INT(RND * 5) + 1
IF p = 1 THEN o = o + 1
IF p = 2 THEN o = o - 1
LINE (m - 4, 0)-(m - 4, o), 1
LINE (m - 4, 199)-(m - 4, o), 2
m = m + 1: u(m) = o - 1
IF m = 324 THEN m = 4
NEXT y
p1 = mb + 22: IF p1 > 324 THEN p1 = p1 - 324
CIRCLE (p1, ob), 7, 1
p3 = mb + 40: IF p3 > 324 THEN p3 = p3 - 324
CIRCLE (p3, ob2), 7, 1
p5 = mb + 58: IF p5 > 324 THEN p5 = p5 - 324
CIRCLE (p5, ob3), 7, 1
zd = zd + 1: IF zd > 79 THEN zd = 0
OUT &H3D4, 13: OUT &H3D5, zd

p2 = m + 22: IF p2 > 324 THEN p2 = p2 - 324
CIRCLE (p2, u(p2) - 7), 7, 7: mb = m: ob = u(p2) - 7
p4 = m + 40: IF p4 > 324 THEN p4 = p4 - 324
CIRCLE (p4, u(p4) - 7), 7, 7: mb = m: ob2 = u(p4) - 7
p6 = m + 58: IF p6 > 324 THEN p6 = p6 - 324
CIRCLE (p6, u(p6) - 7), 7, 7: mb = m: ob3 = u(p6) - 7
GOTO 10


8000 z# = TIMER
      DO UNTIL (TIMER - z# > zz#) OR (TIMER - z# < 0)
      LOOP
      ' zz# = .01: Gosub 8000
RETURN
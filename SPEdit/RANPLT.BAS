DEFINT A-Z
OPEN "ran.plt" FOR BINARY AS 1: IF LOF(1) > 0 THEN SEEK #1, 1
RANDOMIZE TIMER: h = 11
FOR t = 1 TO 768
r = r + h: IF r > 62 THEN r = 0: g = g + h: IF g > 62 THEN g = 0: b = b + h
IF b > 62 THEN b = 63
a$ = a$ + CHR$(r)
a$ = a$ + CHR$(g)
a$ = a$ + CHR$(b)
NEXT t
PUT #1, , a$
CLOSE 1


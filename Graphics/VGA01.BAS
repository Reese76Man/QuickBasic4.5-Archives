DEFINT A-Z
SCREEN 13
10 p = INT(RND * 255) + 1: l = INT(RND * 9) + 1: rt = INT(RND * 8) + 8
FOR t = 1 TO 320 STEP rt
FOR y = 1 TO 200 STEP rt
IF l = 1 THEN LINE (t, y)-(t + rt, y + rt), y OR t XOR p, BF
IF l = 2 THEN LINE (t, y)-(t + rt, y + rt), y OR t AND p, BF
IF l = 3 THEN LINE (t, y)-(t + rt, y + rt), y OR t OR p, BF
IF l = 4 THEN LINE (t, y)-(t + rt, y + rt), y XOR t XOR p, BF
IF l = 5 THEN LINE (t, y)-(t + rt, y + rt), y XOR t AND p, BF
IF l = 6 THEN LINE (t, y)-(t + rt, y + rt), y XOR t OR p, BF
IF l = 7 THEN LINE (t, y)-(t + rt, y + rt), y AND t XOR p, BF
IF l = 8 THEN LINE (t, y)-(t + rt, y + rt), y AND t AND p, BF
IF l = 9 THEN LINE (t, y)-(t + rt, y + rt), y AND t OR p, BF
NEXT y: NEXT t
GOTO 10


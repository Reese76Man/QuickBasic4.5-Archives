DEFINT A-Z
SCREEN 12: s1 = 1
LINE (1, 1)-(300, 300), 5, B
10 s1 = s1 + 1: IF s1 = 147 THEN s1 = s1 - 40
s2 = s1 - 40: s3 = s2 - 40: s4 = s3 - 40
IF s2 < 0 THEN s2 = 0
IF s3 < 0 THEN s3 = 0
IF s4 < 0 THEN s4 = 0
LINE (150 - sb1, 150 - sb1)-(150 + sb1, 150 + sb1), 0, B
LINE (150 - sb2, 150 - sb2)-(150 + sb2, 150 + sb2), 0, B
LINE (150 - sb3, 150 - sb3)-(150 + sb3, 150 + sb3), 0, B
LINE (150 - sb4, 150 - sb4)-(150 + sb4, 150 + sb4), 0, B
LINE (1, 1)-(150 - sb1, 150 - sb1), 0
LINE (1, 300)-(150 - sb1, 150 + sb1), 0
LINE (300, 1)-(150 + sb1, 150 - sb1), 0
LINE (300, 300)-(150 + sb1, 150 + sb1), 0
LINE (150 - sb1, 150 - sb1)-(150 - sb2, 150 - sb2), 0
LINE (150 + sb1, 150 - sb1)-(150 + sb2, 150 - sb2), 0
LINE (150 - s1b, 150 + sb1)-(150 - sb2, 150 + sb2), 0
LINE (150 + sb1, 150 + sb1)-(150 + sb2, 150 + sb2), 0
LINE (150 - sb3, 150 - sb3)-(150 - sb2, 150 - sb2), 0
LINE (150 + sb3, 150 - sb3)-(150 + sb2, 150 - sb2), 0
LINE (150 - sb3, 150 + sb3)-(150 - sb2, 150 + sb2), 0
LINE (150 + sb3, 150 + sb3)-(150 + sb2, 150 + sb2), 0
LINE (150 - sb3, 150 - sb3)-(150 - sb4, 150 - sb4), 0
LINE (150 + sb3, 150 - sb3)-(150 + sb4, 150 - sb4), 0
LINE (150 - sb3, 150 + sb3)-(150 - sb4, 150 + sb4), 0
LINE (150 + sb3, 150 + sb3)-(150 + sb4, 150 + sb4), 0


LINE (150 - s1, 150 - s1)-(150 + s1, 150 + s1), 1, B
LINE (150 - s2, 150 - s2)-(150 + s2, 150 + s2), 1, B
LINE (150 - s3, 150 - s3)-(150 + s3, 150 + s3), 1, B
LINE (150 - s4, 150 - s4)-(150 + s4, 150 + s4), 1, B
LINE (1, 1)-(150 - s1, 150 - s1), 9
LINE (1, 300)-(150 - s1, 150 + s1), 9
LINE (300, 1)-(150 + s1, 150 - s1), 9
LINE (300, 300)-(150 + s1, 150 + s1), 9
LINE (150 - s1, 150 - s1)-(150 - s2, 150 - s2), 9
LINE (150 + s1, 150 - s1)-(150 + s2, 150 - s2), 9
LINE (150 - s1, 150 + s1)-(150 - s2, 150 + s2), 9
LINE (150 + s1, 150 + s1)-(150 + s2, 150 + s2), 9
LINE (150 - s3, 150 - s3)-(150 - s2, 150 - s2), 9
LINE (150 + s3, 150 - s3)-(150 + s2, 150 - s2), 9
LINE (150 - s3, 150 + s3)-(150 - s2, 150 + s2), 9
LINE (150 + s3, 150 + s3)-(150 + s2, 150 + s2), 9
LINE (150 - s3, 150 - s3)-(150, 150), 9
LINE (150 + s3, 150 - s3)-(150, 150), 9
LINE (150 - s3, 150 + s3)-(150, 150), 9
LINE (150 + s3, 150 + s3)-(150, 150), 9
sb1 = sbb1: sb2 = sbb2: sb3 = sbb3: sb4 = sbb4
sbb1 = sy1: sbb2 = sy2: sbb3 = sy3: sbb4 = sy4
sy1 = s1: sy2 = s2: sy3 = s3: sy4 = s4
zz# = .01: Gosub 8000
GOTO 10

8000 z# = TIMER
      DO UNTIL (TIMER - z# > zz#) OR (TIMER - z# < 0)
      LOOP
      ' zz# = .01: Gosub 8000
RETURN
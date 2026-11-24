DEFINT A-Z
SCREEN 13: CLS : q = 85: u = 85

LINE (1, 1)-(170, 170), 11, B
LINE (1, q)-(85, 85), 11: LINE (85, 85)-(170, u), 11: qq = q: uu = u
PAINT (2, 2), 9, 11: PAINT (2, 169), 2, 11
GOTO 10

1 i$ = INKEY$: IF i$ = "" THEN GOTO 1
IF UCASE$(i$) = "Q" THEN SCREEN 0: WIDTH 80: CLS : END
IF i$ = "4" THEN q = q + 1: u = u - 1: LINE (2, qq)-(85, 85), 9: LINE (85, 85)-(169, uu), 2
IF i$ = "6" THEN q = q - 1: u = u + 1: LINE (2, qq)-(85, 85), 2: LINE (85, 85)-(169, uu), 9
10 LINE (2, q)-(85, 85), 11: LINE (85, 85)-(169, u), 11: qq = q: uu = u
GOTO 1



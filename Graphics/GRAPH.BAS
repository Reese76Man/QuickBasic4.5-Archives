DEFINT A-Z
SCREEN 12: WIDTH 80, 60
'WINDOW SCREEN (1, 1)-(640, 480)
h = -20: FOR t = 1 TO 80 STEP 3
LINE ((t * 8) + 5, 10)-((t * 8) + 5, 450), 6
h = h + 2: LOCATE 1, t: PRINT LTRIM$(STR$(h))
NEXT t: LOCATE 2, 40: PRINT "Y"
h = -20: FOR t = 1 TO 57 STEP 3
LINE (10, (t * 8) + 5)-(640, (t * 8) + 5), 6
h = h + 2: LOCATE t, 1: PRINT LTRIM$(STR$(h))
NEXT t: LOCATE 28, 2: PRINT "X"
LOCATE 58, 10: LINE INPUT "Enter Equation:"; e$


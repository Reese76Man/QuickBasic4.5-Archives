DEFINT A-Z
SCREEN 13: CLS
WINDOW SCREEN (1, 1)-(200, 200)
cc = 15: FOR k = 1 TO 10
FOR t = k TO 195 STEP 10
cc = cc + 1: IF cc > 31 THEN cc = 15
LINE (t, 1)-(1, 196 - t), cc
LINE (196, t)-(196 - t, 196), cc
LINE (1, 196 - t)-(196 - t, 196), cc
LINE (t, 1)-(196, t), cc
NEXT t, k


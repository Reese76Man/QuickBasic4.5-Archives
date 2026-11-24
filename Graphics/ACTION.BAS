DEFINT A-Z
DEFSNG V
DECLARE SUB Render (x, y, s, B, i$(), l)
c = 4: SCREEN 13'Render Demo v1.0
i$(1) = STRING$(3, c) + "*****************************" + STRING$(6, c)
i$(2) = STRING$(3, c) + "aa*aaaaaaaaaaaaaaaaaaaaaaaaaa" + STRING$(6, c)
i$(3) = STRING$(3, c) + "aa*aa*aaaaa*aaa*aa*aa*aa*aa*a" + STRING$(6, c)
i$(4) = STRING$(3, c) + "aa*aa***aa*a*aa**a*aa*aaa**aa" + STRING$(6, c)
i$(5) = STRING$(3, c) + "aa*aa*aaaa*a*aa*a**aa*aaa**aa" + STRING$(6, c)
i$(6) = STRING$(3, c) + "aa*aa*aaaaa*aaa*aa*aa*aa*aa*a" + STRING$(6, c)
i$(7) = STRING$(35, c)
g$(1) = STRING$(3, c) + "--yy--yy--yy--yy--y-yy-y---yy--y" + STRING$(6, c)
g$(2) = STRING$(3, c) + "-y-y-y-y-yy-yyyy-yy--y-yy-yy-yyy" + STRING$(6, c)
g$(3) = STRING$(3, c) + "--yy--yy--yy--yy--y--y-yy-yyy--y" + STRING$(6, c)
g$(4) = STRING$(3, c) + "-yyy-y-y-yyyyy-y-yy-y--yy-yyyyy-" + STRING$(6, c)
g$(5) = STRING$(3, c) + "-yyy-y-y--yy--yy--y-y--yy-yyy--y" + STRING$(6, c)
g$(6) = STRING$(40, c)
h$(1) = STRING$(3, c) + "DD11DD1D1D1DD1D11D11DD11DD1D111DD" + STRING$(6, c)
h$(2) = STRING$(3, c) + "D1D1D11D1D1D11D1D1D1D1D1D11DD1D11" + STRING$(6, c)
h$(3) = STRING$(3, c) + "D1D1DD1D1D1DD1D1D1D1DD11DD1D111D1" + STRING$(6, c)
h$(4) = STRING$(3, c) + "D1D1D11D1D1D11D1D1D1D111D11D1111D" + STRING$(6, c)
h$(5) = STRING$(3, c) + "DD11DD11D11DD1DD1D11D111DD1D11DD1" + STRING$(6, c)
h$(6) = STRING$(40, c)

x = 1: y = 1' Coordinates & Other shit

l = 7: VIEW SCREEN (0, 2)-(319, 199), c
FOR s = 0 TO 45: x = x - 3: y = y - 1: Render x, y, s, 0, i$(), l: NEXT s
FOR s = 45 TO 9 STEP -1: x = x + 3: y = y + 1: Render x, y, s, 0, i$(), l: NEXT s

l = 6: VIEW (1, 65)-(319, 199), c: y = y + 4: x = x - 5
FOR s = 0 TO 35: x = x - 3: y = y - 1: Render x, y, s, 0, h$(), l: NEXT s
FOR s = 35 TO 8 STEP -1: x = x + 4: y = y + 1: Render x, y, s, 0, h$(), l: NEXT s

l = 6: VIEW (1, 111)-(319, 199), c: y = y + 8
FOR s = 0 TO 35: x = x - 3: y = y - 1: Render x, y, s, 0, g$(), l: NEXT s
FOR s = 35 TO 8 STEP -1: x = x + 4: y = y + 1: Render x, y, s, 0, g$(), l: NEXT s

SLEEP 5: l = 7: VIEW SCREEN (0, 2)-(319, 199), c: y = 1: x = 35
FOR s = 9 TO 350 STEP 4: x = x - 70: y = y - 15: Render x, y, s, 0, i$(), l: NEXT s

x = 160: y = 100
FOR t = 0 TO 160: LINE (x + t, y + t)-(x - t, y - t), INT(RND * 11) + 15, BF
NEXT t: LINE (x + t, y + t)-(x - t, y - t), 0, BF

100 REM

SUB Render (x, y, s, B, i$(), l)
vt = TIMER + .04
Here: IF vt > TIMER THEN GOTO Here
tt = 0: FOR t = 1 TO l
tt = tt + 1 + s
t3 = 0: FOR t2 = 1 TO LEN(i$(t))
h = ASC(MID$(i$(t), t2, 1))
t3 = t3 + 1 + s
IF B = 0 THEN
        LINE (x + t3, y + tt)-(x + t3 + s, y + tt + s), h, BF
ELSE
        LINE (x + t3, y + tt)-(x + t3 + s, y + tt + s), h, B
END IF
NEXT t2, t
END SUB


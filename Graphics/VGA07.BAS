DEFINT A-Z
DECLARE SUB Render (x, y, s, B, i$(), l)
c = 4: SCREEN 13'Render Demo v1.0
i$(1) = STRING$(3, c) + "*****************************" + STRING$(6, c)
i$(2) = STRING$(3, c) + "aa*cddefghijklmnopqrstuvwxyz{" + STRING$(6, c)
i$(3) = STRING$(3, c) + "aa*cd*efghi*klm*op*rs*uv*xy*{" + STRING$(6, c)
i$(4) = STRING$(3, c) + "aa*cd***gh*j*lm**p*rs*uvw**z{" + STRING$(6, c)
i$(5) = STRING$(3, c) + "aa*cd*efgh*j*lm*o**rs*uvw**z{" + STRING$(6, c)
i$(6) = STRING$(3, c) + "aa*bd*efghi*klm*op*rs*uv*xy*{" + STRING$(6, c)
i$(7) = STRING$(35, c)
g$(1) = STRING$(3, c) + ",,bc,,de,,gg,,ii,,j,kl,m,,,oo,,q" + STRING$(6, c)
g$(2) = STRING$(3, c) + ",b,c,d,e,fg,hhii,jj,,l,mm,no,ppq" + STRING$(6, c)
g$(3) = STRING$(3, c) + ",,bc,,de,,gg,,ii,,j,,l,mm,noo,,q" + STRING$(6, c)
g$(4) = STRING$(3, c) + ",bbc,d,e,fgghh,i,jj,k,,mm,noopp," + STRING$(6, c)
g$(5) = STRING$(3, c) + ",bbc,d,e,,gg,,ii,,j,k,,mm,noo,,q" + STRING$(6, c)
g$(6) = STRING$(40, c)
h$(1) = STRING$(3, c) + "DD11JJ1v1v1!!1l11o11..11''1r111ss" + STRING$(6, c)
h$(2) = STRING$(3, c) + "D2D2J22v2v2!22l2o2o2.2.2'22rr2s22" + STRING$(6, c)
h$(3) = STRING$(3, c) + "D3D3JJ3v3v3!!3l3o3o3..33''3r333s3" + STRING$(6, c)
h$(4) = STRING$(3, c) + "D4D4J44v4v4!44l4o4o4.444'44r4444s" + STRING$(6, c)
h$(5) = STRING$(3, c) + "DD55JJ55v55!!5ll5o55.555''5r55ss5" + STRING$(6, c)
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

SUB Render (x, y, s, B, i$(), l)
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

        z# = TIMER
        DO UNTIL (TIMER - z# > .0005) OR (TIMER - z# < 0)
        LOOP
END SUB
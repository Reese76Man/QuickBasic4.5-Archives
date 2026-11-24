DEFINT A-Y
CLS : SCREEN 13
OUT &H60, &HF3: OUT &H60, .25
DIM Image(1 TO 405)  AS INTEGER
0 GET (1, 1)-(40, 20), Image      ' THIS IS THE MENU \/
CLS
1 FOR t = 16 TO 31: COLOR t: FOR z = 1 TO 400: NEXT z
LOCATE 1, 1: PRINT "      QBasic Sprite Editor v1.0"
NEXT t: PRINT : COLOR 4
PRINT
PRINT "              Options:": PRINT
PRINT "         1. Edit a Sprite"
PRINT "         2. Edit a Palette"
PRINT "         3. Edit a Picture"
PRINT "         0. Exit to DOS  "
PRINT
10 t$ = INKEY$
IF t$ = "1" THEN GOTO 100
IF t$ = "2" THEN GOTO 500
IF t$ = "0" THEN
                OUT &H60, &HF3: OUT &H60, 255
                SCREEN 0: WIDTH 80: CLS
                PRINT "This product is for TRONiX '94 members ONLY."
                SYSTEM

END IF
GOTO 10   'THIS IS THE LOAD SPRITE ROUTINE \/

50 LOCATE 3, 10: PRINT "                             "
LOCATE 3, 10: COLOR 1
INPUT "Load .SPT File:", F$: IF INSTR(F$, ".") = 0 THEN F$ = F$ + ".SPT"
COLOR 4
OPEN F$ FOR INPUT AS 1
t = 0
FOR st = 1 TO 405
INPUT #1, p$: t = t + 1: Image(t) = VAL("&H" + p$)
NEXT st: CLOSE 1: PUT (1, 1), Image, PSET: GOTO 101 'THIS IS THE SCREEN PUT\/

100 CLS : PUT (1, 1), Image, PSET: xp = 4: yp = 1: cl = 4
101 FOR t = 1 TO 20: FOR Y = 1 TO 40: pv = POINT(Y, t): COLOR pv
IF pv <> 0 THEN LOCATE t + 3, Y: PRINT "Û" ELSE LOCATE t + 3, Y: PRINT " "
NEXT Y: NEXT t  ' THIS IS THE PRINTED DATA FOR USERS

102     COLOR 4
        LOCATE 1, 10: PRINT "'R'=RVSE|'+/-'=COLOR|'S'=SAVE"
        LOCATE 2, 10: PRINT "'X'=EXIT|'C'  =CLS  |'L'=LOAD"
105     LOCATE 3, 10: PRINT "                             "
LOCATE 3, 10: COLOR cl: PRINT "Color:"; cl    ' THIS IS THE COLOR GET ROUTINE

110 l$ = INKEY$: p$ = CHR$(SCREEN(xp, yp)): COLOR cl
lc = POINT((yp * 8) - 4, (xp * 8) - 4): IF lc <> 0 THEN COLOR lc
LOCATE xp, yp: PRINT "*"  ' This is the pretty EDIT cursor.
111 IF l$ = "" THEN l$ = INKEY$: GOTO 111 'THIS IS WHERE THE CHOICES ARE MADE
LOCATE xp, yp: PRINT p$
IF UCASE$(l$) = "C" THEN CLS : GOTO 116
IF RIGHT$(l$, 1) = "M" THEN yp = yp + 1: IF yp > 40 THEN yp = 40
IF RIGHT$(l$, 1) = "H" THEN xp = xp - 1: IF xp < 4 THEN xp = 4
IF RIGHT$(l$, 1) = "P" THEN xp = xp + 1: IF xp > 23 THEN xp = 23
IF RIGHT$(l$, 1) = "K" THEN yp = yp - 1: IF yp < 1 THEN yp = 1
IF l$ = "+" THEN cl = cl + 1: IF cl > 255 THEN cl = 1: GOTO 105 ELSE GOTO 105
IF l$ = "-" THEN cl = cl - 1: IF cl < 1 THEN cl = 255: GOTO 105 ELSE GOTO 105
IF UCASE$(l$) = "L" THEN GOTO 50
IF UCASE$(l$) = "S" THEN GOTO 200
IF UCASE$(l$) = "X" THEN GOTO 0
IF UCASE$(l$) = "R" THEN GET (1, 1)-(40, 20), Image: PUT (1, 1), Image, PRESET: GOTO 101
IF l$ = CHR$(13) AND SCREEN(xp, yp) = 32 THEN LOCATE xp, yp: PRINT "Û": GOTO 116
IF l$ = CHR$(13) AND SCREEN(xp, yp) = 219 THEN LOCATE xp, yp: PRINT " ": GOTO 116
115 GOTO 110 ' THIS IS THE SCREEN GET ROUTINE

116 FOR t = 1 TO 20: FOR Y = 1 TO 40: : py = (Y * 8) - 4: px = (t + 2) * 8
PSET (Y, t), POINT(py, px): NEXT Y, t
GOTO 102 ' THIS IS THE SPRITE SAVE ROUTINE

200 LOCATE 3, 10: PRINT "                             ": LOCATE 3, 10: COLOR 1
INPUT "Save .SPT File:", F$: COLOR 4: IF INSTR(F$, ".") = 0 THEN F$ = F$ + ".SPT"
201 OPEN F$ FOR BINARY AS 1: IF LOF(1) > 0 THEN CLOSE 1: KILL F$: GOTO 201
GET (1, 1)-(40, 20), Image
FOR st = 1 TO 405: p$ = HEX$(Image(st)) + ",": PUT #1, , p$
NEXT st: CLOSE 1: GOTO 101

500 CLS : cl = 0
505 LOCATE 6, 10: PRINT "                             ": LOCATE 1, 1
COLOR cl
PRINT "******": PRINT "******": PRINT "******": PRINT "******"
OUT &H3C7, cl: rd = INP(&H3C9): gn = INP(&H3C9): bl = INP(&H3C9)
LOCATE 6, 1: COLOR 4
PRINT "Red:"; rd: PRINT "Green:"; gn: PRINT "Blue:"; bl
LOCATE 1, 10: PRINT "On Color:"; cl
LOCATE 2, 10: PRINT "-/+ - Red control  | "
LOCATE 3, 10: PRINT "[/] - Green control| S - Save"
LOCATE 4, 10: PRINT ";/' - Blue control | L - Load"
LOCATE 5, 10: PRINT ",/. - Color control| X - Quit"
510 i$ = UCASE$(INKEY$): IF i$ = "" THEN GOTO 510
IF i$ = "+" THEN rd = rd + 1: IF rd > 63 THEN rd = 63
IF i$ = "-" THEN rd = rd - 1: IF rd < 0 THEN rd = 0
IF i$ = "]" THEN gn = gn + 1: IF gn > 63 THEN gn = 63
IF i$ = "[" THEN gn = gn - 1: IF gn < 0 THEN gn = 0
IF i$ = "'" THEN bl = bl + 1: IF bl > 63 THEN bl = 63
IF i$ = ";" THEN bl = bl - 1: IF bl < 0 THEN bl = 0
IF i$ = "." THEN cl = cl + 1: IF cl > 255 THEN cl = 255
IF i$ = "," THEN cl = cl - 1: IF cl < 0 THEN cl = 0
IF i$ = "X" THEN CLS : GOTO 1
IF i$ = "S" THEN GOTO 600
IF i$ = "L" THEN GOTO 700
IF i$ <> "." AND i$ <> "," THEN
        OUT &H3C7, cl - 1
        OUT &H3C9, rd: OUT &H3C9, gn: OUT &H3C9, bl
        OUT &HC8, cl - 1
END IF
GOTO 505

600 LOCATE 6, 10: PRINT "                             ": LOCATE 6, 10: COLOR 4
INPUT "Save .PLT File:", F$: COLOR 4: IF INSTR(F$, ".") = 0 THEN F$ = F$ + ".PLT"
601 OPEN F$ FOR BINARY AS 1: IF LOF(1) > 0 THEN CLOSE 1: KILL F$: GOTO 601
FOR t = 0 TO 255
OUT &H3C7, t
p$ = CHR$(INP(&H3C9)) + CHR$(INP(&H3C9)) + CHR$(INP(&H3C9))
PUT #1, , p$: NEXT t: CLOSE 1: GOTO 505

700 LOCATE 6, 10: PRINT "                             ": LOCATE 6, 10: COLOR 4
INPUT "Load .PLT File:", F$: COLOR 4: IF INSTR(F$, ".") = 0 THEN F$ = F$ + ".PLT"
701 OPEN F$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL F$: GOTO 505
FOR t = 0 TO 255
p$ = INPUT$(3, 1)
rd = ASC(LEFT$(p$, 1)): gn = ASC(MID$(p$, 2, 1)): bl = ASC(RIGHT$(p$, 1))
OUT &H3C7, t - 1: OUT &H3C9, rd: OUT &H3C9, gn: OUT &H3C9, bl: OUT &HC8, t - 1
NEXT t: CLOSE 1: GOTO 505

' ERROR HANDLING ROUTINE
1000 CLS : PRINT "An error has occurred!!!"
PRINT "Restarting Program.": FOR z = 1 TO 15000: NEXT z: RUN


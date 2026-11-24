DEFINT A-Z
'$DYNAMIC
DIM txt(500) AS STRING * 80
CLS : x = 2: y = 1: ps = 1: xb = 2: psb = 1
COLOR 7, 1: FOR t = 1 TO 22: LOCATE t + 1, 1: PRINT SPACE$(80): NEXT t
1 LOCATE 1, 1: COLOR 0, 7: PRINT "[F]ile   [S]earch   [O]ptions                                                   "
  LOCATE 1, 60: PRINT USING "Lines:##"; ln
  LOCATE 1, 70: PRINT USING "On:##|##"; ps; (ps + 20)
2 LOCATE 23, 1: COLOR 0, 7: PRINT "EDITOR is a TRONIX Production By Diceman                                        "
  LOCATE 1, 47: PRINT USING "X:## Y:##"; (x - 1); y
  LOCATE 23, 75: PRINT "INS": ovr = 1
5 t2 = 0: b = 0: IF ovr = 1 THEN LOCATE x, y, 1, 7, 8 ELSE LOCATE x, y, 1, 1, 8
10 a$ = INKEY$: IF a$ = "" THEN GOTO 10
IF a$ = "~" THEN
        COLOR 7, 1: FOR t = 1 TO 21
        LOCATE t + 1, 1: PRINT LEFT$(txt(t), 80) + SPACE$(80 - LEN(LEFT$(txt(t), 80)))
        NEXT t: GOTO 5
END IF
12 r$ = RIGHT$(a$, 1): IF a$ = CHR$(8) THEN b = 1: a$ = " ": r$ = ""
IF a$ = CHR$(13) THEN y = 1: r$ = "P"
IF b = 1 AND y < 1 THEN y = 1
IF b = 1 THEN LOCATE x, y, 1
IF a$ = CHR$(9) THEN t2 = 1
8 IF t2 > 0 THEN t2 = t2 + 1: a$ = " ": r$ = " "
IF r$ = a$ THEN
        COLOR 7, 1
        IF ovr = 1 THEN
                FOR t = 78 TO y STEP -1
                LOCATE x, t + 1: PRINT CHR$(SCREEN(x, t))
                NEXT t
        END IF
        LOCATE x, y: PRINT a$; : r$ = "M"
END IF
IF r$ = "R" THEN
 COLOR 0, 7
 IF ovr = 0 THEN ovr = 1: LOCATE 23, 75: PRINT "INS" ELSE ovr = 0: LOCATE 23, 75: PRINT "OVR"
END IF
IF r$ = "!" THEN GOTO 100
'IF r$ = "I" THEN x = 2
'IF r$ = "Q" THEN x = 22
IF r$ = "O" THEN
        y = 79: FOR t = 78 TO 1 STEP -1
        z = SCREEN(x, t): IF z <> 32 THEN y = t + 1: t = 1
        NEXT t
END IF
IF r$ = "G" THEN
        y = 1: FOR t = 1 TO 79
        z = SCREEN(x, t): IF z <> 32 THEN y = t: t = 79
        NEXT t
END IF
IF r$ = "S" OR (b = 1 AND y > 1) THEN
        COLOR 7, 1: IF b = 1 THEN y = y - 1
        FOR t = y TO 79
        LOCATE x, t: PRINT CHR$(SCREEN(x, t + 1))
        NEXT t
END IF
IF r$ = "P" THEN x = x + 1: IF x > 22 THEN x = 22
IF r$ = "H" THEN x = x - 1: IF x < 2 THEN x = 2
IF r$ = "M" THEN y = y + 1: IF y > 79 THEN y = 79
IF t2 > 0 AND t2 < 6 THEN GOTO 8
IF r$ = "K" THEN y = y - 1: IF y < 1 THEN y = 1
COLOR 0, 7: LOCATE 1, 47: PRINT USING "X:## Y:##"; (x - 1); y

psb = 0: FOR t = 79 TO 1 STEP -1
z = SCREEN(x, t): IF z <> 32 THEN psb = t: t = 1
NEXT t: txt(x - 1) = "*"
IF psb > 0 THEN
        FOR t = 1 TO psb
        txt(x - 1) = txt(x - 1) + CHR$(SCREEN(x, t))
        NEXT t
END IF
GOTO 5

100 LOCATE 1, 1: COLOR 0, 7: PRINT "(S)ave/(L)oad/(Q)uit                         "
101 a$ = INKEY$: IF a$ = "" THEN GOTO 101
IF a$ = "L" OR a$ = "l" THEN GOTO 150
IF a$ = "Q" OR a$ = "q" THEN COLOR 7, 0: CLS : PRINT "Thanks for using EDITOR, Peaceout!": END
IF a$ = CHR$(27) THEN GOTO 1
110 GOTO 101

150 REM Load
LOCATE 1, 1: INPUT "Please Enter Filename:", f$: IF f$ = "" THEN GOTO 1
OPEN f$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: GOTO 1 ELSE CLOSE 1
OPEN f$ FOR INPUT AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL f$: GOTO 101
t = 0: ps = 1
155 t = t + 1: LINE INPUT #1, txt(t): IF EOF(1) <> -1 THEN GOTO 155
CLOSE 1: ln = t: LOCATE 1, 1: PRINT "                                  ": COLOR 7, 1
FOR t = 1 TO 21
LOCATE t + 1, 1: PRINT LEFT$(txt(t), 80) + SPACE$(80 - LEN(LEFT$(txt(t), 80)))
NEXT t: GOTO 1


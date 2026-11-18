DEFINT A-Z
CLS
PRINT ".VOC to .SNG file converter v1.0"
PRINT "   Written by: Corey Badeaux"
PRINT "      UNREGISTERED VERSION"
lst = 255: cnt = 0: file$ = COMMAND$
IF file$ = "" THEN
        PRINT "  USAGE: VOC2SNG <infile>.voc": PRINT
        GOTO 20
END IF
1 j = INSTR(file$, ".")
IF j = 0 THEN file$ = file$ + ".VOC": GOTO 1
IF j > 0 THEN file1$ = LEFT$(file$, j) + "SNG"
PRINT "Incorporate .SNG compression <Y/N>:";
2 q$ = INKEY$: IF q$ = "" THEN GOTO 2 ELSE IF UCASE$(q$) = "N" THEN sg = 1
IF sg = 0 THEN PRINT "YES!" ELSE PRINT "NO!"
3 OPEN file1$ FOR BINARY AS 1: IF LOF(1) > 0 THEN CLOSE 1: KILL file1$: GOTO 3
OPEN file$ FOR BINARY AS 2: IF LOF(2) = 0 THEN CLOSE 2: GOTO 20
q$ = "Tronix .SNG file - Copyright Tronix Developers 1995" + CHR$(26) + CHR$(26)
PUT #1, , q$
5 q$ = INPUT$(2048, 2)
LOCATE 5, 1: PRINT "Reading bytes:"; LOC(2); " of "; LOF(2); " from "; file$
             PRINT "Writing bytes:"; LOF(1); " to "; file1$
FOR T = 1 TO LEN(q$) STEP 2: p = ASC(MID$(q$, T, 1))
r$ = r$ + CHR$(p): NEXT T
PUT #1, , r$: r$ = "": IF EOF(2) <> -1 THEN GOTO 5
PRINT : PRINT "DONE!"
20 CLOSE 1, 2: PRINT : END


DEFINT A-Z
COLOR 9, 0: CLS : ON ERROR GOTO 100
2 COLOR 12: PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�": COLOR 9
PRINT "        LOADCOMB v1.0 - TRONIX '94": COLOR 11
PRINT "Combine LOADCODE's Multiple files into one!"
PRINT "LOADCODE is a Tronix Production by DICEMAN!": COLOR 4
PRINT "               UNREGISTERED": COLOR 12
PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�": COLOR 9
COLOR 7, 0: u$ = COMMAND$: IF u$ = "" THEN PRINT "USAGE: LCM [Root FILENAME or LOADCODE File]": PRINT : END
OPEN "!" + LEFT$(u$, 11) FOR OUTPUT AS 1: PRINT "Opening Root file:"; u$
8 ct = ct + 1: g$ = LTRIM$(STR$(ct)) + u$
OPEN g$ FOR BINARY AS 2: IF LOF(2) = 0 THEN CLOSE 2: KILL g$: GOTO 30 ELSE CLOSE 2
OPEN g$ FOR INPUT AS 2: LOCATE 10: PRINT "On file:"; ct
10 LINE INPUT #2, q$: PRINT #1, q$: IF EOF(2) <> -1 THEN GOTO 10
CLOSE 2: KILL g$: GOTO 8
30 CLOSE 1: IF ct = 1 THEN KILL "!" + LEFT$(u$, 11)
PRINT "Done combining LOADCODE files.": CLOSE 1
END
100 CLOSE 1, 2: PRINT : PRINT "An error has occured opening file "; u$; ".": END



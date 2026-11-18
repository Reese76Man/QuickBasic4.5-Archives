$CONSOLE:ONLY
_DEST _CONSOLE

'$DYNAMIC     
DEFINT A-Z
x = 1000
DIM fs(1 TO x) AS STRING
ON ERROR GOTO 90
PRINT : COLOR 12
PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�": COLOR 9
PRINT "    F-FIND v1.0 - TRONiX Developers '95": COLOR 11
PRINT "  Find files quickly and find text in files"
PRINT "  F-FIND is a Tronix Production by DICEMAN": COLOR 12
PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�": COLOR 3: PRINT
IF LEN(COMMAND$) < 3 THEN PRINT "  Usage: FFIND [file extention] [search string]"
IF LEN(COMMAND$) < 3 THEN PRINT "Example: FFIND tr*.txt tronix": GOTO 101
IF INSTR(COMMAND$, CHR$(32)) = 0 THEN c$ = COMMAND$ ELSE c$ = LEFT$(COMMAND$, INSTR(COMMAND$, CHR$(32)) - 1)
IF (LEN(COMMAND$) - LEN(c$)) > 1 THEN t$ = MID$(COMMAND$, LEN(c$) + 2)
SHELL _HIDE "dir /s /b " + c$ + " >temp.dir"
OPEN "temp.dir" FOR INPUT AS 1
10 IF EOF(1) THEN GOTO 20
LINE INPUT #1, q$
IF LEN(q$) > 0 THEN
        p = p + 1: fs(p) = q$
END IF
20 IF EOF(1) = 0 AND p < x THEN GOTO 10 ELSE CLOSE 1
PRINT "Found"; p; c$; " files.": IF p = 0 THEN GOTO 100
IF t$ = "" THEN
        l = 0: FOR t = 1 TO p: l = l + 1: IF l = 22 THEN PRINT "[PAUSE]": GOSUB 75: l = 0
        PRINT fs(t): NEXT t: GOTO 100
END IF
PRINT "Now searching for: "; t$
FOR t = 1 TO p
OPEN fs(t) FOR INPUT AS 1
25 IF EOF(1) THEN GOTO 30
LINE INPUT #1, q$: IF INSTR(UCASE$(q$), UCASE$(t$)) > 0 THEN PRINT "Found text in file: "; fs(t): GOTO 30
IF EOF(1) = 0 THEN GOTO 25
30 CLOSE 1: NEXT t: PRINT : GOTO 100

75 q$ = INKEY$: IF q$ = "" THEN GOTO 75 ELSE RETURN

90 PRINT "An error has occured.. halting program. (Err:"; ERR; "Line:"; _ERRORLINE; ")": PRINT
100 CLOSE 1: IF _FILEEXISTS("temp.dir") THEN KILL "temp.dir"
101 COLOR 7, 0: PRINT "Tronix Developers F-Find v1.0  Written by DICEMAN aka Corey Badeaux": END

DEFINT A-Y
DEFLNG Z
DIM w(255)
IF INSTR(1, COMMAND$, "/?") > 0 OR COMMAND$ = "" THEN
PRINT
PRINT "MOST.EXE - Find the most popular character in a file."
PRINT "USAGE: MOST /[option] [filename]"
PRINT "Options:"
PRINT "/?     - Help screen."
PRINT "/A     - Write ALL info to file named ALL.DAT"
PRINT
END
END IF
lc = INSTR(1, COMMAND$, " "): fle$ = RIGHT$(COMMAND$, LEN(COMMAND$) - lc)
CLS : PRINT "Opening file "; fle$; ".": PRINT
OPEN fle$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL fle$: PRINT "File Not Found.": END
5 GOSUB GetByte
w(byte) = w(byte) + 1
GOTO 5
10 IF INSTR(1, COMMAND$, "/A") > 0 THEN
OPEN "all.dat" FOR BINARY AS 2
FOR t = 0 TO 255: q$ = LTRIM$(STR$(t)) + "." + STR$(w(t)) + CHR$(13) + CHR$(10): PUT #2, , q$: NEXT t: CLOSE 2
END IF

FOR l = 1 TO 10: FOR t = 0 TO 255
FOR k = 1 TO 10: IF p(k) = w(t) THEN GOTO 12
NEXT k
IF w(t) > p(l) THEN p(l) = w(t): k(l) = t
12 NEXT t
NEXT l

PRINT "Here are the top 10 bytes in this file:"
FOR t = 1 TO 10: PRINT LTRIM$(STR$(t)); "."; k(t); p(t): NEXT t
PRINT "Press any key"
15 IF INKEY$ = "" THEN GOTO 15
CLOSE 1: END
GetByte:
IF a = 0 AND EOF(1) <> -1 THEN a = 1: r$ = INPUT$(5120, 1): DEF SEG = VARSEG(r$): zad = SADD(r$) ELSE IF a = 0 AND EOF(1) = -1 THEN GOTO 10
zy = zy + 1: byte = PEEK(zad + zy - 1)
IF zy >= LEN(r$) THEN a = 0: zy = 0
RETURN


DEFINT A-Y
ON ERROR GOTO 1000
COLOR 12, 0: PRINT
COLOR 11, 0: PRINT "       T-COPY     TRONIX '96     By:DICEMAN"
COLOR 3: PRINT "       ------     ---v1.5---     ----------"
COLOR 12, 0:
IF COMMAND$ = "" THEN GOTO 2000
FOR t = 1 TO LEN(COMMAND$)
y$ = MID$(COMMAND$, t, 1)
IF y$ = CHR$(32) THEN q = q + 1: GOTO 8
IF q = 0 THEN f$ = f$ + y$
IF q = 1 THEN g$ = g$ + y$
IF q > 1 THEN GOTO 9
8 NEXT t: IF f$ = "" OR g$ = "" THEN GOTO 1000
9 OPEN f$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL f$: GOTO 1000
IF u = 0 THEN PRINT "  FILE:"; f$; "   LENGTH:"; LOF(1); "   TIME:"; TIME$
IF u = 0 THEN PRINT "0%                     50%                     100%": COLOR 9
IF u = 0 THEN PRINT "[±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±]": pp = 1
COLOR 7, 0
10 OPEN g$ FOR BINARY AS 2: IF LOF(2) <> 0 THEN pp = 2: INPUT "          Sure you want to overwrite(Y/N):", d$: IF d$ = "Y" OR d$ = "y" THEN CLOSE 2: KILL g$: GOTO 10 ELSE CLOSE 1, 2: END
COLOR 9, 0: LOCATE CSRLIN - pp, 2: PRINT : z = TIMER: u = 1
11 q$ = INPUT$(20480, 1): PUT #2, , q$
LOCATE CSRLIN - 1, 2: PRINT STRING$(INT(LOC(2) / LOF(1) * 50), "²")
IF EOF(1) <> -1 THEN GOTO 11
COLOR 4, 0
PRINT USING "          File took ###.## seconds to copy.    "; (TIMER - z): PRINT
SEEK #1, 1: SEEK #2, 1
15 q$ = INPUT$(12288, 1): g$ = INPUT$(12288, 2)
LOCATE CSRLIN - 1, 1
  IF q$ = g$ THEN
        PRINT USING "          Verifying Copy: ######## OK"; LOC(1)
  ELSE
              PRINT "          Verifying Copy: BAD COPY   ": GOTO 20
  END IF
IF EOF(1) <> -1 THEN GOTO 15
20 CLOSE 1, 2: COLOR 7, 0: PRINT " ": END
1000 IF u = 0 THEN u = 1: g$ = g$ + "\" + f$: CLOSE 1, 2: GOTO 9
PRINT : PRINT "        ERROR HAS OCCURED...COPYING STOPPED!": CLOSE 1, 2: COLOR 7, 0
2000 COLOR 1, 0: PRINT "         USAGE: TCOPY <infile> <outfile>": COLOR 7, 0: PRINT " ": END


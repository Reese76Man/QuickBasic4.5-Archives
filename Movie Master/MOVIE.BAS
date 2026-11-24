'$DYNAMIC
DEFINT A-Z
DECLARE SUB mop (a%, a$)
DIM op$(10)
free& = 3000 'SETMEM(0) / 110
5 SCREEN 0:  CLS : reg$ = CHR$(71) + CHR$(114) + CHR$(101) + CHR$(103) 

op$(1) = "  Search Mode  "
op$(2) = "   Add Movie   "
op$(3) = " Delete Movie  "
op$(4) = "Edit Movie File"
op$(5) = "  Alpha-Sorter "
op$(6) = "  Exit To DOS  ": op = 6

COLOR 9: LOCATE 2, 16: PRINT "MOVIE MASTER v1.0 - Video Tape Collection Tracking"
LOCATE 23, 27: PRINT "Registered to "; reg$
COLOR 11: LOCATE 5, 35: PRINT "Main Menu": mm = 1: l$ = ""
9 FOR t = 1 TO op: IF mm = t THEN COLOR 11, 1 ELSE COLOR 11, 0
  LOCATE 6 + t, 32: PRINT op$(t): NEXT t
10 g$ = UCASE$(INKEY$)
COLOR 1, 0: LOCATE 1, 1: PRINT "TIME:"; TIME$: LOCATE 1, 65: PRINT "DATE:"; DATE$
IF g$ = "" THEN GOTO 10
IF RIGHT$(g$, 1) = "P" THEN mm = mm + 1: IF mm > op THEN mm = 1
IF RIGHT$(g$, 1) = "H" THEN mm = mm - 1: IF mm < 1 THEN mm = op
IF RIGHT$(g$, 1) = "M" THEN mm = mm + 1: IF mm > op THEN mm = 1
IF RIGHT$(g$, 1) = "K" THEN mm = mm - 1: IF mm < 1 THEN mm = op
IF g$ = CHR$(27) OR g$ = "Q" THEN g$ = CHR$(13): mm = op
IF g$ = CHR$(13) THEN
        IF mm = op THEN COLOR 7, 0: CLS : PRINT "Program Written by: Corey Badeaux  Tronix Developers '95": PRINT : END
        IF mm = 1 THEN GOTO 100
        IF mm = 2 THEN GOTO 200
        IF mm = 3 THEN GOTO 300
        IF mm = 4 THEN SHELL "edit movies.dat": RUN
        IF mm = 5 THEN GOTO 400
END IF
GOTO 9

100 CLS : COLOR 9, 0
LOCATE 1, 30: PRINT "Search Movie Mode"
LOCATE 2, 30: PRINT "-----------------"
LOCATE 5, 1: PRINT "Enter whole name or key words of movie or number to search for."
LOCATE 7, 1: LINE INPUT "Or leave blank for ALL>>", mov$: mov$ = UCASE$(mov$)
IF LEN(mov$) > 3 AND LEFT$(mov$, 3) = "THE" THEN mov$ = RIGHT$(mov$, LEN(mov$) - 4)
IF VAL(mov$) > 0 THEN mov$ = " " + mov$ + " "
GOSUB dis1: mop 1, "": ln = 0: mop 4, a$
110 mop 4, a$
IF INSTR(UCASE$(a$), mov$) > 0 THEN PRINT " "; a$: ln = ln + 1
IF ln = 20 THEN COLOR 9: PRINT "**PAUSE**": SLEEP: a$ = INKEY$: ln = 0: GOSUB dis1
IF EOF(1) = 0 THEN GOTO 110
mop 5, "": COLOR 9, 0: PRINT "         Done Search.": SLEEP: a$ = INKEY$: RUN

77
dis1:
CLS : PRINT "Searching for:"; mov$
PRINT "Number | Movie": COLOR 11, 0
RETURN

200 CLS : COLOR 9, 0
LOCATE 1, 30: PRINT "ADD Movie Mode"
LOCATE 2, 30: PRINT "--------------"
LOCATE 5, 1: PRINT "Enter whole name of movie as to be shown in data file"
LOCATE 7, 1: LINE INPUT "Or leave blank to EXIT>>", mov$
IF mov$ = "" THEN RUN
LOCATE 9, 1: LINE INPUT "Enter Tape number>>", movn$
IF VAL(movn$) = 0 THEN movn$ = "NA"
movn$ = LEFT$(movn$, 3)
205 IF LEN(movn$) < 5 THEN movn$ = " " + movn$: GOTO 205
movn$ = movn$ + " - " + mov$
mop 1, "": mop 2, "": mop 4, a$: mop 3, a$
210 mop 4, a$
IF LEN(a$) > 8 AND mov$ <> "" THEN
           IF mov$ <> "" AND UCASE$(RIGHT$(a$, LEN(a$) - 8)) > UCASE$(mov$) THEN
                mov$ = "": mop 3, movn$
           END IF
END IF
mop 3, a$: IF EOF(1) = 0 THEN GOTO 210
IF mov$ <> "" THEN mop 3, movn$: mov$ = ""
mop 5, "": mop 6, "": RUN

300 CLS : COLOR 9, 0
LOCATE 1, 30: PRINT "Delete Movie Mode"
LOCATE 2, 30: PRINT "-----------------"
LOCATE 5, 1: PRINT "Enter whole name or key words of movie or number(s) to delete."
LOCATE 7, 1: LINE INPUT "Or leave blank to EXIT>>", mov$: mov$ = UCASE$(mov$)
IF mov$ = "" THEN RUN
IF LEN(mov$) > 3 AND LEFT$(mov$, 3) = "THE" THEN mov$ = RIGHT$(mov$, LEN(mov$) - 4)
IF VAL(mov$) > 0 THEN mov$ = " " + mov$ + " "
GOSUB dis1: mop 1, "": mop 2, "": ln = 0: mop 4, a$: mop 3, a$
310 mop 4, a$
IF INSTR(UCASE$(a$), mov$) > 0 THEN
        PRINT " "; a$; "  <<- Delete <Y/N>:";
315     g$ = UCASE$(INKEY$): IF g$ = "" THEN GOTO 315
        IF g$ = "Y" THEN PRINT g$ ELSE PRINT "N": mop 3, a$
ELSE
        mop 3, a$
END IF
IF EOF(1) = 0 THEN GOTO 310
mop 5, "": mop 6, "": COLOR 9, 0: PRINT "         Done Deleting.": SLEEP: a$ = INKEY$: RUN

400 CLS : COLOR 9, 0
REDIM mv(1 TO free&) AS STRING * 64
LOCATE 1, 30: PRINT "Alpha-sorter Mode"
LOCATE 2, 30: PRINT "-----------------"
LOCATE 3, 25: PRINT "Usable Memory:"; (free& * 64); "Bytes"
mop 1, "": ln = 0: LOCATE 6, 1: PRINT ">>Loading into Memory."
405 mop 4, a$: ln = ln + 1: mv(ln) = a$: IF EOF(1) = 0 THEN GOTO 405 ELSE mop 5, ""
LOCATE 4, 25: PRINT "Movies Found:"; (ln - 1)
LOCATE 7, 1: PRINT ">>Sorting:": tm = 0: ch = 0
406 tm = tm + 1: FOR t = 2 TO ln
IF t > 2 AND UCASE$(RIGHT$(mv(t - 1), LEN(mv(t - 1)) - 8)) > UCASE$(RIGHT$(mv(t), LEN(mv(t)) - 8)) THEN
        SWAP mv(t - 1), mv(t): ch = ch + 1: LOCATE 7, 12: PRINT USING "###-####"; tm; ch
END IF
NEXT t: IF ch > 0 THEN ch = 0: GOTO 406
PRINT ">>Saving to disk."
mop 2, ""
FOR t = 1 TO ln: mop 3, mv(t): NEXT t: mop 5, "": mop 6, "": RUN

REM $STATIC
SUB mop (a%, a$)
IF a% = 1 THEN OPEN "movies.dat" FOR INPUT AS 1: a$ = ""
IF a% = 2 THEN OPEN "temp.dat" FOR OUTPUT AS 2: a$ = ""
IF a% = 3 THEN PRINT #2, a$
IF a% = 4 THEN LINE INPUT #1, a$
IF a% = 5 THEN CLOSE 1, 2
IF a% = 6 THEN KILL "movies.dat": SHELL "ren temp.dat movies.dat"
END SUB


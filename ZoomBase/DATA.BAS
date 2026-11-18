DEFINT A-Z
DECLARE SUB find (a$)
ON ERROR GOTO 1
file$ = COMMAND$
IF file$ = "" THEN file$ = "BLANK.DAT"
OPEN "!" + file$ FOR BINARY AS 1: OPEN file$ FOR BINARY AS 2
IF LOF(1) = 0 AND LOF(2) = 0 THEN PRINT "ERROR FILE "; file$; " DOES NOT EXIST!": CLOSE 1, 2: KILL file$: KILL "!" + file$: PRINT : END
CLOSE 1, 2
SHELL "cd > db.log"
OPEN "db.log" FOR BINARY AS 1
log$ = INPUT$(LOF(1), 1)
CLOSE 1: KILL "db.log"
DIM f$(15), d$(200)
CLS : OPEN "!" + file$ FOR BINARY AS 1: IF LOF(1) > 0 THEN cmp = 1: st$ = "ON " ELSE st$ = "OFF": cmp = 0
CLOSE 1
IF cmp = 1 THEN PRINT : PRINT "Decompressing Data...."
GOSUB 40000
1 sp = 11: CLS : CLOSE 1, 2: pl = 1
2 COLOR 12: PRINT SPC(sp); " ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ": COLOR 1
PRINT SPC(sp); "           ZOOMBASE v1.0 - TRONIX '94": COLOR 11
PRINT SPC(sp); "              The Ultimate Database": COLOR 9
PRINT SPC(sp); "        ZOOMBASE is a Diceman Production": COLOR 12
PRINT SPC(sp); " ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ": COLOR 1
sp = sp + 13
PRINT SPC(sp); "Using Datafile:"; file$
PRINT SPC(sp); "       CHOOSE:"
sp = sp - 2
3 COLOR 7, 0: LOCATE 8, 1
PRINT SPC(sp); "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
PRINT SPC(sp); "³   Search and Edit Data  ³"
PRINT SPC(sp); "³     Add to Database     ³"
PRINT SPC(sp); "³   Alplhabetizer Sorter  ³"
PRINT SPC(sp); "³     COMPRESSOR: "; st$; "     ³"
PRINT SPC(sp); "³  Create a Database File ³"
PRINT SPC(sp); "³  Edit a Datafile Header ³"
PRINT SPC(sp); "³   Merge Two Datafiles   ³"
PRINT SPC(sp); "³Change to another DB file³"
PRINT SPC(sp); "³      Shell to DOS       ³"
PRINT SPC(sp); "³      Exit to DOS        ³"
PRINT SPC(sp); "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
GOTO 7
5 a$ = INKEY$
IF a$ = "" THEN COLOR 7, 0: LOCATE 3, 1: t = VAL(LEFT$(TIME$, 2))
IF a$ = "" THEN IF t > 12 THEN t = t - 12
IF a$ = "" THEN IF t = 0 THEN t = 12
IF a$ = "" THEN PRINT "TIME:"; STR$(t); RIGHT$(TIME$, 6): LOCATE 3, 59: PRINT "DATE: "; DATE$: GOTO 5
6 COLOR 7, 0: LOCATE old + 8, sp + 2: PRINT old$
7  q$ = "": FOR t = sp + 2 TO sp + 26: q$ = q$ + CHR$(SCREEN(pl + 8, t)): NEXT t
old$ = q$: old = pl
COLOR 0, 7: LOCATE pl + 8, sp + 2: PRINT q$
q$ = RIGHT$(a$, 1)
IF q$ = "H" OR q$ = "K" THEN pl = pl - 1: IF pl < 1 THEN pl = 10
IF q$ = "P" OR q$ = "M" THEN pl = pl + 1: IF pl > 10 THEN pl = 1
IF q$ = "H" OR q$ = "P" OR q$ = "M" OR q$ = "K" THEN a$ = "": GOTO 6
IF a$ = CHR$(13) THEN GOTO 8
GOTO 5
8 a$ = RIGHT$(STR$(pl), 1): COLOR 7, 0
IF a$ = "8" THEN GOTO 8000
IF a$ = "7" THEN GOTO 6000
IF a$ = "6" THEN GOTO 4000
IF a$ = "5" THEN GOTO 3000
IF a$ = "0" THEN COLOR 7: CLS : PRINT "Thanks for using ZOOMBASE ... Peaceout!": PRINT : IF cmp = 1 THEN PRINT "Compressing Data...": GOSUB 30000: END ELSE : END
IF a$ = "9" THEN COLOR 7: CLS : PRINT "TRONIX DOSSHELL Type 'EXIT' to return to ZOOMBASE": SHELL: SHELL LEFT$(log$, 2): SHELL "cd\" + MID$(log$, 4, LEN(log$)): GOTO 1
IF a$ = "4" AND cmp = 1 THEN cmp = 0: st$ = "OFF": GOTO 3
IF a$ = "4" AND cmp = 0 THEN cmp = 1: st$ = "ON ": GOTO 3
IF a$ = "1" THEN GOTO 100
IF a$ = "3" THEN GOTO 300
IF a$ = "2" THEN GOTO 600
GOTO 5

100 REM READATA
CLS : PRINT : PRINT : q = 0
GOTO 199

150 CLS : PRINT : PRINT : PRINT SPC(sp); "Type in Last Name(or first few char.):"; : LINE INPUT "", a$: IF a$ = "" THEN GOTO 150
CALL find(a$): l$ = a$: j = LEN(l$): IF j > 15 THEN GOTO 150
OPEN file$ FOR INPUT AS 1
LINE INPUT #1, hd$
155 LINE INPUT #1, q$: q = q + 1: a$ = LEFT$(q$, j): CALL find(a$): IF a$ <> l$ THEN GOTO 175
GOSUB 20000: GOSUB 10000
175 IF EOF(1) <> -1 THEN GOTO 155
CLOSE 1
GOTO 100


199 CLS : p = 1: lmt = 0
200 OPEN file$ FOR INPUT AS 1: LINE INPUT #1, hd$: tot = 0: IF EOF(1) = -1 THEN CLOSE 1: PRINT "SORRY, NO ACCOUNTS IN DATAFILE.": : GOSUB 10001: GOTO 1
201 LINE INPUT #1, q$: tot = tot + 1: IF tot < lmt + 201 AND tot > lmt THEN d$(tot - lmt) = q$
IF EOF(1) <> -1 THEN GOTO 201
CLOSE 1
202 q = lmt
255 IF q >= tot THEN GOTO 256
IF p < lmt + 1 AND p > 0 THEN lmt = lmt - 200: GOTO 200
IF q > lmt + 199 THEN lmt = lmt + 200: GOTO 200
q = q + 1: q$ = d$(q - lmt): IF q < p AND q < tot THEN GOTO 255
256 GOSUB 20000
257 ret = 1: GOSUB 10000: LOCATE 9, 1
PRINT "  ³MOVEMENT COMMANDS ³ MISCELANEOUS COMMANDS ³      EDITING COMMANDS     ³"
PRINT "  ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´"
PRINT "  ³CSR UP/DN:by 1    ³ [F]irst name search   ³ [1] Last Name  [7] Sex    ³"
PRINT "  ³CSR LT/RT:by 10   ³ [L]ast name search    ³ [2] First Name [8] ID ### ³"
PRINT "  ³PGE UP/DN:by 100  ³ [P]hone number search ³ [3] Middle Name[9] Brthday³"
PRINT "  ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ [M]iddle name search  ³ [4] Address    [A] Grade  ³"
PRINT "  ³[J]ump to account   B[I]rthday search     ³ [5] Phone #    [B] Summary³"
PRINT "  ³Se[X] search        [R]ace search         ³ [6] Race                  ³"
PRINT "  ³[Q]uit to main      [T]ransfer Account    ³ [D]elete acct. [S]ave acct³"
PRINT "  ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"
270 a$ = INKEY$
IF a$ = "" THEN COLOR 7, 0: LOCATE 2, 65: t = VAL(LEFT$(TIME$, 2))
IF a$ = "" THEN IF t > 12 THEN t = t - 12
IF a$ = "" THEN IF t = 0 THEN t = 12
IF a$ = "" THEN PRINT "TIME:"; STR$(t); RIGHT$(TIME$, 6): LOCATE 19, 1: GOTO 270
hd$ = RIGHT$(a$, 1)
IF hd$ = "H" THEN p = q + 1: GOTO 255
IF hd$ = "P" THEN p = q - 1: GOTO 202
IF hd$ = "M" THEN p = q + 10: GOTO 255
IF hd$ = "K" THEN p = q - 10: GOTO 202
IF hd$ = "I" THEN p = q + 100: GOTO 255
IF hd$ = "Q" THEN p = q - 100: GOTO 202
IF hd$ = "G" THEN p = 1: GOTO 202
IF hd$ = "O" THEN p = tot: GOTO 255
IF a$ = "1" THEN GOTO 804
IF a$ = "2" THEN GOTO 805
IF a$ = "3" THEN GOTO 806
IF a$ = "4" THEN GOTO 807
IF a$ = "5" THEN GOTO 808
IF a$ = "6" THEN GOTO 809
IF a$ = "7" THEN GOTO 810
IF a$ = "8" THEN GOTO 811
IF a$ = "9" THEN GOTO 812
CALL find(a$)
IF a$ = "A" THEN GOTO 813
IF a$ = "B" THEN GOTO 814
IF a$ = "M" THEN q = 0: GOTO 1000
IF a$ = "Q" THEN GOTO 299
IF a$ = "J" THEN INPUT "Enter Account to Jump to:", p:  CLS : GOTO 202
IF a$ = "D" THEN GOTO 700
IF a$ = "S" THEN GOTO 900
IF a$ = "T" THEN GOTO 5000
IF a$ = "I" THEN q = 0: GOTO 1100
IF a$ = "P" THEN q = 0: GOTO 500
IF a$ = "L" THEN q = 0: GOTO 150
IF a$ = "F" THEN q = 0: GOTO 400
IF a$ = "X" THEN q = 0: GOTO 1200
IF a$ = "R" THEN q = 0: GOTO 1300
GOTO 270
290 PRINT : PRINT "Can't Do that option...Press any Key": GOSUB 10001: CLOSE 1: GOTO 199
299 CLOSE 1: GOTO 1

300 CLS : PRINT : PRINT "SUPER ALPHA-SORTER now sorting last names only..."
PRINT : PRINT "Now Sorting Phase 1:";
OPEN file$ FOR INPUT AS 1: q = 0
OPEN "A.tmp" FOR OUTPUT AS 2
LINE INPUT #1, hd$: PRINT #2, hd$
310 FOR tt = 65 TO 90: PRINT CHR$(tt); ".";
320 LINE INPUT #1, q$: IF LEFT$(q$, 1) = CHR$(tt) THEN PRINT #2, q$
IF EOF(1) <> -1 THEN GOTO 320
330 CLOSE 1, 2: hd$ = CHR$(tt + 1) + ".tmp": OPEN file$ FOR INPUT AS 1
IF tt < 90 THEN OPEN hd$ FOR OUTPUT AS 2: LINE INPUT #1, hd$
NEXT tt
PRINT "DONE!": PRINT : CLOSE 1, 2: PRINT "Now Sorting Phase 2:A:";
FOR tt = 65 TO 90: hd$ = CHR$(tt) + ".tmp"
OPEN hd$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL hd$: GOTO 350 ELSE CLOSE 1
OPEN hd$ FOR INPUT AS 1: q = 0: temp = 0: ch = 0
OPEN "db.tmp" FOR OUTPUT AS 2
IF tt = 65 THEN LINE INPUT #1, h$: PRINT #2, h$: IF EOF(1) = -1 THEN CLOSE 1, 2: GOTO 349
340 LINE INPUT #1, q$: q = q + 1: d$(q) = q$: IF EOF(1) <> -1 OR q >= 200 THEN GOTO 340
IF q >= 200 THEN CLOSE 1, 2: KILL "db.tmp": SHELL "ren " + hd$ + " db.tmp"
345 temp = ch: FOR t = 1 TO q - 1: IF d$(t) > d$(t + 1) THEN SWAP d$(t), d$(t + 1): ch = ch + 1
NEXT t: IF temp <> ch THEN PRINT "."; : GOTO 345
FOR t = 1 TO q: PRINT #2, d$(t): NEXT t
CLOSE 1, 2: q = 0: temp = 0: ch = 0: PRINT "DONE!"
349 KILL hd$: SHELL "ren db.tmp " + hd$
350 IF tt < 90 THEN PRINT CHR$(tt + 1); ":";
NEXT tt: PRINT "DONE!": PRINT : PRINT "Now Sorting Phase 3:";
KILL file$: PRINT ".";
FOR tt = 65 TO 90: hd$ = CHR$(tt) + ".tmp"
OPEN hd$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL hd$: GOTO 360 ELSE CLOSE 1
SHELL "copy " + file$ + " + " + hd$ + " " + file$ + " > nul": PRINT CHR$(tt) + ".";
360 NEXT tt
KILL "*.tmp": PRINT ".";
PRINT "DONE!": PRINT : PRINT "Press any key to Exit": GOSUB 10001
GOTO 1

400 CLS : PRINT : PRINT : PRINT SPC(sp); "Type in First Name(or first few char.):"; : LINE INPUT "", a$: IF a$ = "" THEN GOTO 400
CALL find(a$): l$ = a$: j = LEN(l$): IF j > 15 THEN GOTO 400
OPEN file$ FOR INPUT AS 1
LINE INPUT #1, hd$
455 LINE INPUT #1, q$: q = q + 1: a$ = MID$(q$, 16, j): CALL find(a$): IF a$ <> l$ THEN GOTO 475
GOSUB 20000: GOSUB 10000
475 IF EOF(1) <> -1 THEN GOTO 455
CLOSE 1
GOTO 100

500 CLS : PRINT : PRINT : PRINT SPC(sp); "Type in Phone# (EX1.682-4549:EX2.277-2):"; : LINE INPUT "", a$: IF a$ = "" THEN GOTO 500
l$ = a$: j = LEN(l$): IF j > 8 THEN GOTO 500
OPEN file$ FOR INPUT AS 1
LINE INPUT #1, hd$
555 LINE INPUT #1, q$: q = q + 1: a$ = MID$(q$, 96, j): IF a$ <> l$ THEN GOTO 575
GOSUB 20000: GOSUB 10000
575 IF EOF(1) <> -1 THEN GOTO 555
CLOSE 1
GOTO 100

600 CLS : PRINT : PRINT : PRINT SPC(sp); "ADD TO DATABASE": d$ = STRING$(100, 32)
601 LINE INPUT "Enter Last name:", f$(1): a$ = f$(1): CALL find(a$): l1$ = a$: IF l1$ = "" OR LEN(l1$) > 15 THEN GOTO 602
602 LINE INPUT "Enter First name(Use [RETURN] to Cancel):", f$(2): a$ = f$(2): CALL find(a$): f1$ = a$: IF f1$ = "" OR LEN(f1$) > 15 THEN GOTO 1
OPEN file$ FOR INPUT AS 1
605 LINE INPUT #1, q$: a$ = MID$(q$, 1, LEN(l1$)): CALL find(a$): ln$ = a$: a$ = MID$(q$, 16, LEN(f1$)): CALL find(a$): fs$ = a$
IF ln$ = l1$ AND fs$ = f1$ THEN CLOSE 1: PRINT : PRINT "SORRY, That user is already in the database....Press any key": GOSUB 10001: GOTO 600
IF EOF(1) <> -1 THEN GOTO 605
CLOSE 1
606 LINE INPUT "Enter Middle name or Nickname:", f$(3): IF LEN(f$(3)) > 15 THEN GOTO 606
607 PRINT "Enter Address (Ex:1209 Green Ave. St.bernard  LA  70085)": LINE INPUT "Address:", f$(4): IF LEN(f$(4)) > 45 THEN GOTO 607
608 LINE INPUT "Enter Phone Number(Ex:(504)682-4549):", f$(5)
609 LINE INPUT "Enter Race (Use:W/B):", f$(6): IF f$(6) <> "W" AND f$(6) <> "B" THEN PRINT "NOT VALID, USE 'W' or 'B'.": GOTO 609
610 LINE INPUT "Enter Sex (Use:M/F):", f$(7): IF f$(7) <> "M" AND f$(7) <> "F" THEN PRINT "NOT VALID, USE 'M' or 'F'.": GOTO 610
611 LINE INPUT "Enter Student ID (Use '0' if unknown):", f$(8)
612 LINE INPUT "Enter Birthdate (Format:MM/DD/YY):", f$(9)
613 LINE INPUT "Enter Grade (Ex:08  or GRAD or NA):", f$(10): IF LEN(f$(10)) <> 2 THEN GOTO 613
614 LINE INPUT "Enter Summary(Ex:INFO, Ect.):", f$(11)
615  FOR t = 1 TO 11: f$(t) = f$(t) + d$: NEXT t: q$ = "": d$ = ""
f$(1) = LEFT$(f$(1), 15): f$(2) = LEFT$(f$(2), 15)
f$(3) = LEFT$(f$(3), 15): f$(4) = LEFT$(f$(4), 45)
f$(5) = LEFT$(f$(5), 20): f$(6) = LEFT$(f$(6), 1)
f$(7) = LEFT$(f$(7), 9): f$(8) = LEFT$(f$(8), 10)
f$(9) = LEFT$(f$(9), 10): f$(10) = LEFT$(f$(10), 5)
f$(11) = LEFT$(f$(11), 30): IF but = 1 THEN RETURN
FOR t = 1 TO 11: q$ = q$ + f$(t): NEXT t
PRINT : PRINT "Saving Data...";
OPEN file$ FOR APPEND AS 1
PRINT #1, q$
CLOSE 1
PRINT "Done!  Press any key": GOSUB 10001: GOTO 1

700 PRINT "Are you Sure(Y/N)?"
707 a$ = INKEY$: IF a$ = "" THEN GOTO 707 ELSE CALL find(a$)
709 IF a$ <> "Y" THEN CLS : GOTO 202
OPEN file$ FOR INPUT AS 1: OPEN "db.tmp" FOR OUTPUT AS 2
LINE INPUT #1, hd$: PRINT #2, hd$: p = 0
710 LINE INPUT #1, q$: p = p + 1: IF p <> q THEN PRINT #2, q$
IF EOF(1) <> -1 THEN GOTO 710
CLOSE 1, 2
KILL file$: SHELL "ren db.tmp " + file$: tot = tot - 1
p = q: CLS : GOTO 200

REM EDITING ROOM!
804 LINE INPUT "Enter Last name:", f$(1): IF f$(1) = "" OR LEN(f1$) > 15 THEN GOTO 804
GOTO 820
805 LINE INPUT "Enter First name:", f$(2): IF f$(2) = "" OR LEN(f$(2)) > 15 THEN GOTO 805
GOTO 820
806 LINE INPUT "Enter Middle name or Nickname:", f$(3): IF LEN(f$(3)) > 15 THEN GOTO 806
GOTO 820
807 PRINT "Enter Address (Ex:1209 Green Ave. St.bernard  LA  70085)": LINE INPUT "Address:", f$(4): IF LEN(f$(4)) > 45 THEN GOTO 807
GOTO 820
808 LINE INPUT "Enter Phone Number(Ex:(504)682-4549):", f$(5)
GOTO 820
809 LINE INPUT "Enter Race (Use:W/B):", f$(6): IF f$(6) <> "W" AND f$(6) <> "B" THEN PRINT "NOT VALID, USE 'W' or 'B'.": GOTO 809
GOTO 820
810 LINE INPUT "Enter Sex (Use:M/F):", f$(7): IF f$(7) <> "M" AND f$(7) <> "F" THEN PRINT "NOT VALID, USE 'M' or 'F'.": GOTO 810
GOTO 820
811 LINE INPUT "Enter Student ID (Use '0' if unknown):", f$(8)
GOTO 820
812 LINE INPUT "Enter Birthdate (Format:MM/DD/YY):", f$(9)
GOTO 820
813 LINE INPUT "Enter Grade (Ex:08  or GRAD or NA):", f$(10): IF LEN(f$(10)) <> 2 THEN GOTO 813
GOTO 820
814 LINE INPUT "Enter Summary(INFO, Ect...):", f$(11)
820 d$ = STRING$(100, 32)
but = 1: GOSUB 615: but = 0
CLS : GOTO 257

900 OPEN file$ FOR INPUT AS 1: OPEN "db.tmp" FOR OUTPUT AS 2
LINE INPUT #1, hd$: PRINT #2, hd$: p = 0: tt$ = ""
FOR t = 1 TO 11: tt$ = tt$ + f$(t): NEXT t
910 LINE INPUT #1, q$: p = p + 1: IF p <> q THEN PRINT #2, q$ ELSE PRINT #2, tt$
IF EOF(1) <> -1 THEN GOTO 910
CLOSE 1, 2
KILL file$: SHELL "ren db.tmp " + file$
p = q: GOTO 200

1000 CLS : PRINT : PRINT : PRINT SPC(sp); "Type in Middle Name(or first few char.):"; : LINE INPUT "", a$: IF a$ = "" THEN GOTO 1000
CALL find(a$): l$ = a$: j = LEN(l$): IF j > 15 THEN GOTO 1000
OPEN file$ FOR INPUT AS 1
LINE INPUT #1, hd$
1055 LINE INPUT #1, q$: q = q + 1: a$ = MID$(q$, 31, j): CALL find(a$): IF a$ <> l$ THEN GOTO 1075
GOSUB 20000: GOSUB 10000
1075 IF EOF(1) <> -1 THEN GOTO 1055
CLOSE 1
GOTO 100

1100 CLS : PRINT : PRINT : PRINT SPC(sp); "Type in Date (or first few char:Ex:09/30.):"; : LINE INPUT "", a$: IF a$ = "" THEN GOTO 1100
CALL find(a$): l$ = a$: j = LEN(l$): IF j > 8 THEN GOTO 1100
OPEN file$ FOR INPUT AS 1
LINE INPUT #1, hd$
1155 LINE INPUT #1, q$: q = q + 1: a$ = MID$(q$, 131, j): CALL find(a$): IF a$ <> l$ THEN GOTO 1175
GOSUB 20000: GOSUB 10000
1175 IF EOF(1) <> -1 THEN GOTO 1155
CLOSE 1
GOTO 100

1200 CLS : PRINT : PRINT : PRINT SPC(sp); "Type in SEX (M/F):"; : LINE INPUT "", a$: IF a$ = "" THEN GOTO 1200
CALL find(a$): l$ = a$: j = LEN(l$): IF j > 1 THEN GOTO 1200
OPEN file$ FOR INPUT AS 1
LINE INPUT #1, hd$
1255 LINE INPUT #1, q$: q = q + 1: a$ = MID$(q$, 112, j): CALL find(a$): IF a$ <> l$ THEN GOTO 1275
GOSUB 20000: GOSUB 10000
1275 IF EOF(1) <> -1 THEN GOTO 1255
CLOSE 1
GOTO 100

1300 CLS : PRINT : PRINT : PRINT SPC(sp); "Type in RACE (W/B):"; : LINE INPUT "", a$: IF a$ = "" THEN GOTO 1300
CALL find(a$): l$ = a$: j = LEN(l$): IF j > 1 THEN GOTO 1300
OPEN file$ FOR INPUT AS 1
LINE INPUT #1, hd$
1355 LINE INPUT #1, q$: q = q + 1: a$ = MID$(q$, 111, j): CALL find(a$): IF a$ <> l$ THEN GOTO 1375
GOSUB 20000: GOSUB 10000
1375 IF EOF(1) <> -1 THEN GOTO 1355
CLOSE 1
GOTO 100

3000 CLS : PRINT SPC(sp); "Database File Creator": PRINT
LINE INPUT "Name of file to create(ENTER Exits):", hd$: IF hd$ = "" OR hd$ = file$ THEN GOTO 1
PRINT : PRINT "Creating...";
OPEN hd$ FOR OUTPUT AS 2
OPEN file$ FOR INPUT AS 1
LINE INPUT #1, hd$: PRINT #2, hd$
CLOSE 1, 2: PRINT "DONE!": PRINT
3004 PRINT "Press any key to continue"
3005 IF INKEY$ = "" THEN GOTO 3005
GOTO 1

4000 CLS : PRINT SPC(sp); "Datafile Header Editor": PRINT : hd$ = ""
OPEN file$ FOR INPUT AS 1: LINE INPUT #1, hd$
PRINT "Old Header:"; hd$
LINE INPUT "Enter New Header:", hd$: IF hd$ = "" OR LEN(hd$) > 255 THEN GOTO 1
OPEN "db.tmp" FOR OUTPUT AS 2: PRINT #2, hd$
4005 IF EOF(1) <> -1 THEN LINE INPUT #1, hd$: PRINT #2, hd$: GOTO 4005
CLOSE 1, 2: KILL file$: SHELL "ren db.tmp " + file$
4006 GOTO 3004

5000 CLS : PRINT SPC(sp); "Transfer Account to another Datafile": PRINT
LINE INPUT "Enter Name of file to transfer Account information to:", hd$: IF hd$ = "" OR hd$ = file$ THEN GOTO 1
OPEN hd$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL hd$: GOTO 1
CLOSE 1: q$ = ""
FOR t = 1 TO 11: q$ = q$ + f$(t): NEXT t
OPEN hd$ FOR APPEND AS 1: PRINT #1, q$: CLOSE 1
PRINT : GOTO 202

6000 CLS : PRINT : PRINT SPC(sp); "Merge Two Accounts Together": PRINT
LINE INPUT "Enter Primary File:", hd$: IF hd$ = "" THEN GOTO 1
OPEN hd$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL hd$: GOTO 1
CLOSE 1: LINE INPUT "Enter Secondary File:", hd2$: IF hd2$ = "" THEN GOTO 1
OPEN hd2$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL hd2$: GOTO 1
CLOSE 1: IF hd$ = hd2$ THEN PRINT "Merged files are same file!": PRINT : GOTO 3004
LINE INPUT "Enter Merged File:", a$: IF a$ = "" OR a$ = file$ OR a$ = hd$ OR a$ = hd2$ THEN GOTO 1
OPEN hd$ FOR INPUT AS 1: OPEN hd2$ FOR INPUT AS 2
OPEN a$ FOR OUTPUT AS 3
LINE INPUT #2, q$: LINE INPUT #1, q$: PRINT #3, q$
6005 IF EOF(1) <> -1 THEN LINE INPUT #1, q$: PRINT #3, q$: GOTO 6005
6007 IF EOF(2) <> -1 THEN LINE INPUT #2, q$: PRINT #3, q$: GOTO 6007
CLOSE 1, 2, 3: PRINT : GOTO 3004

8000 CLS : PRINT SPC(sp); "Datafile Control Transfer": PRINT
LINE INPUT "Enter New Datafile:", hd$: IF hd$ = "" THEN GOTO 1
OPEN hd$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL hd$: GOTO 1
CLOSE 1
file$ = hd$: PRINT : GOTO 3004




10000 LOCATE 1, 1: FOR t = 1 TO 7: PRINT "                                                                              ": NEXT t: LOCATE 1, 1
PRINT "Ú"; : FOR t = 1 TO 77: PRINT "Ä"; : NEXT t: PRINT "¿": a$ = INKEY$
FOR t = 1 TO 6: PRINT "³"; SPC(77); "³": NEXT t: a$ = INKEY$
PRINT "À"; : FOR t = 1 TO 77: PRINT "Ä"; : NEXT t: PRINT "Ù": a$ = INKEY$
LOCATE 2, 2: PRINT "NUMBER:"; q; "out of"; tot; "  Zoombase v1.0    Datafile:"; file$
LOCATE 4, 2: PRINT "Last:"; f$(1); "   First:"; f$(2); "   Middle:"; f$(3)
LOCATE 5, 2: PRINT "Address:"; f$(4); " SEX:"; f$(7); "Race:"; f$(6)
LOCATE 6, 2: PRINT "Phone:"; f$(5); "   Birthday:"; f$(9); "   Prsnl ID:"; f$(8)
LOCATE 7, 2: PRINT "Grade:"; f$(10); "   Summary:"; f$(11)
IF ret = 1 THEN ret = 0: RETURN
LOCATE 12, 1: PRINT "<<Press any key to continue>>"
              PRINT "<<Press 'Q' to Quit to Main>>"
10001 j$ = INKEY$: IF j$ = "" THEN GOTO 10001
IF j$ = "Q" OR j$ = "q" THEN CLOSE 1: p = q: GOTO 202
RETURN


20000  f$(2) = MID$(q$, 16, 15): f$(1) = MID$(q$, 1, 15): f$(3) = MID$(q$, 31, 15): f$(4) = MID$(q$, 46, 45)
f$(5) = MID$(q$, 91, 20): f$(6) = MID$(q$, 111, 1): f$(7) = MID$(q$, 112, 9)
f$(8) = MID$(q$, 121, 10): f$(9) = MID$(q$, 131, 10): f$(10) = MID$(q$, 141, 5)
f$(11) = MID$(q$, 146, 30)
RETURN

30000 OPEN file$ FOR BINARY AS 1: IF LOF(1) = 0 THEN GOTO 30198
30098 OPEN "!" + file$ FOR BINARY AS 2: IF LOF(2) > 0 THEN CLOSE 2: KILL "!" + file$: GOTO 30098
30188 q$ = INPUT$(2048, 1)
FOR t = 1 TO LEN(q$)
q = ASC(MID$(q$, t, 1)): R$ = CHR$(q)
IF q = 32 THEN c = c + 1: GOTO 30191
IF q <> 32 AND c = 1 THEN R$ = CHR$(32) + R$: c = 0
IF c > 0 AND q <> 32 THEN R$ = "~" + CHR$(c) + R$: c = 0
PUT #2, , R$
30191 NEXT t: LOCATE 2, 1: PRINT "Percent done:"; INT(LOC(1) / LOF(1) * 100)
IF EOF(1) <> -1 THEN GOTO 30188
PRINT : PRINT USING "Percent compressed:###.##"; (LOF(2) / LOF(1) * 100)
30198 CLOSE 1: CLOSE 2: KILL file$: PRINT : RETURN

40000 OPEN "!" + file$ FOR BINARY AS 1: IF LOF(1) = 0 THEN GOTO 40197
40099 OPEN file$ FOR BINARY AS 2: IF LOF(2) > 0 THEN CLOSE 2: GOTO 40197
40189 q$ = INPUT$(2048, 1)
FOR t = 1 TO LEN(q$)
q = ASC(MID$(q$, t, 1)): R$ = CHR$(q)
IF R$ = "~" THEN c = 1: GOTO 40190
IF c = 1 THEN c = 0: R$ = STRING$(ASC(R$), 32)
PUT #2, , R$
40190 NEXT t: LOCATE 1, 1: PRINT "Percent done:"; INT(LOC(1) / LOF(1) * 100)
IF EOF(1) <> -1 THEN GOTO 40189
40197 CLOSE 1: CLOSE 2: KILL "!" + file$: RETURN

SUB find (a$) STATIC
FOR t = 1 TO LEN(a$)
q$ = MID$(a$, t, 1): IF q$ = "" THEN q$ = CHR$(0)
IF ASC(q$) > 96 THEN q$ = CHR$(ASC(q$) - 32)
b$ = b$ + q$
NEXT t
a$ = b$: b$ = "": q$ = ""
END SUB


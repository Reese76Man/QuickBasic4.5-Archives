DEFSNG A-Z
SCREEN 0: WIDTH 80, 25: CLS

OPEN "papa.emp" FOR INPUT AS 1
LINE INPUT #1, nme$
LINE INPUT #1, hw$: hw = VAL(hw$)
LINE INPUT #1, hw$: cm = VAL(hw$)
CLOSE 1

COLOR 12, 1: LOCATE 1, 27: PRINT "Papa John's Daily Work Log"
COLOR 1, 0: LOCATE , 27: PRINT STRING$(26, "Ä"): COLOR 11, 0

LOCATE 3, 1: PRINT "     Name: "; nme$; "          Commission:"; RTRIM$(STR$(cm)); "%         Hourly Wage: $"; LTRIM$(STR$(hw))
COLOR 1, 0: PRINT STRING$(80, "Ä"): COLOR 11, 0
LOCATE 5, 35: PRINT "Menu options"
COLOR 1, 0: PRINT STRING$(80, "Ä"): COLOR 11, 0
LOCATE 8, 25: PRINT "A) Make daily entry for "; DATE$
LOCATE 10, 25: PRINT "B) View statistical data"
LOCATE 12, 25: PRINT "C) View data file"
LOCATE 14, 25: PRINT "Q) Quit to DOS"
menu2: t$ = UCASE$(INKEY$)
IF t$ = "A" THEN GOTO entry
IF t$ = "B" THEN GOTO stats
IF t$ = "C" THEN GOTO vu
IF t$ = "Q" OR t$ = CHR$(27) THEN COLOR 7, 0: CLS : PRINT "Tronix Developers '96": PRINT : END
GOTO menu2:

entry:
FOR t = 5 TO 20: LOCATE t, 1: PRINT SPACE$(80): NEXT t
LOCATE 5, 1: PRINT "Daily Entrances For: "; DATE$
LOCATE 5, 65: PRINT "Totals"
COLOR 1, 0: PRINT STRING$(80, "Ä"): COLOR 11, 0
LOCATE 8, 1: INPUT "Hours worked today: ", hwt
LOCATE 8, 65: PRINT USING "$###.##"; (hwt * hw)
LOCATE 10, 1: INPUT "Commission Earned: ", ce
LOCATE 10, 65: PRINT USING "$###.##"; (ce)
LOCATE 12, 1: INPUT "Total Tips Received: ", tr
LOCATE 12, 65: PRINT USING "$###.##"; (tr)
IF hwt = 0 THEN RUN
LOCATE 14, 30: PRINT "Is this correct (Y/N)?"
back: t$ = UCASE$(INKEY$)
IF t$ = "Y" THEN GOTO onw:
IF t$ = "N" THEN GOTO entry
GOTO back:
onw: tw = tr + ce + (hwt * hw)
LOCATE 14, 1: PRINT SPACE$(80)
LOCATE 14, 1: PRINT "Total wages:"
LOCATE 14, 65: PRINT USING "$###.##"; (tw)
LOCATE 16, 1: PRINT "Average per hour:"
LOCATE 16, 65: PRINT USING "$###.##"; (tw / hwt)
LOCATE 18, 33: PRINT "Press any key"
back2: IF INKEY$ = "" THEN GOTO back2
nme2$ = LEFT$(nme$, 5) + ".PPJ"
OPEN nme2$ FOR APPEND AS 1
nme2$ = "!!" + DATE$ + "!!"
PRINT #1, nme2$
PRINT #1, hwt
PRINT #1, ce
PRINT #1, tr
CLOSE 1: RUN


stats: dw = 0: hwt = 0: ce = 0: tr = 0: tm = 0
FOR t = 5 TO 20: LOCATE t, 1: PRINT SPACE$(80): NEXT t
nme2$ = LEFT$(nme$, 5) + ".PPJ"
OPEN nme2$ FOR INPUT AS 1
back5: LINE INPUT #1, t$
IF LEFT$(t$, 2) = "!!" THEN
INPUT #1, hwt2: hwt = hwt + hwt2
INPUT #1, CE2: ce = ce + CE2
INPUT #1, tr2: tr = tr + tr2
tm = tm + 1
END IF
IF EOF(1) = 0 THEN GOTO back5:  ELSE CLOSE 1

tw = tr + ce + (hwt * hw)
LOCATE 6, 1: PRINT "Total entries:"
LOCATE 6, 65: PRINT tm
LOCATE 8, 1: PRINT "Total hours worked:"
LOCATE 8, 65: PRINT hwt
LOCATE 10, 1: PRINT "Total commission:"
LOCATE 10, 65: PRINT USING "$###.##"; (ce)
LOCATE 12, 1: PRINT "Total tips earned:"
LOCATE 12, 65: PRINT USING "$###.##"; (tr)
LOCATE 14, 1: PRINT "Total wages:"
LOCATE 14, 65: PRINT USING "$###.##"; (tw)
LOCATE 16, 1: PRINT "Average per hour:"
LOCATE 16, 65: PRINT USING "$###.##"; (tw / hwt)
LOCATE 18, 33: PRINT "Press any key"
back3: IF INKEY$ = "" THEN GOTO back3
RUN

vu:
nme2$ = LEFT$(nme$, 5) + ".PPJ"
CLS : SHELL "TV " + nme2$: RUN


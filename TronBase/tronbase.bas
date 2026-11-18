DECLARE SUB gettext (x, y, t$, stp)
DIM op$(10)
5 SCREEN 0:  CLS
month$ = LEFT$(DATE$, 2): day$ = MID$(DATE$, 4, 2): year$ = MID$(DATE$, 9, 2)

op$(1) = "Complete Inventory Report"
op$(2) = "Item Entry/Search/Edit"
op$(3) = "Change Time/Date"
op$(4) = "Exit To DOS  ": op = 4

COLOR 15: LOCATE 2, 16: PRINT "Tronix-Base v1.0.2 - Inventory tracking software"
COLOR 15: LOCATE 5, 35: PRINT "Main Menu": mm = 1: l$ = ""

9 FOR t = 1 TO op: IF mm = t THEN COLOR 0, 7 ELSE COLOR 7, 0
  LOCATE 6 + t, 30: PRINT op$(t): NEXT t
10 g$ = UCASE$(INKEY$)
COLOR 15, 0: LOCATE 1, 1: PRINT "TIME:"; TIME$: LOCATE 1, 65: PRINT "DATE:"; DATE$
IF g$ = "" THEN GOTO 10
IF RIGHT$(g$, 1) = "P" THEN mm = mm + 1: IF mm > op THEN mm = 1
IF RIGHT$(g$, 1) = "H" THEN mm = mm - 1: IF mm < 1 THEN mm = op
IF RIGHT$(g$, 1) = "M" THEN mm = mm + 1: IF mm > op THEN mm = 1
IF RIGHT$(g$, 1) = "K" THEN mm = mm - 1: IF mm < 1 THEN mm = op

IF g$ = "~" THEN
        FOR t = 1 TO 100: t = 1
        IF INKEY$ <> "~" THEN t = 1 ELSE t = 100
        NEXT t
END IF
IF g$ = CHR$(27) OR g$ = "Q" THEN g$ = CHR$(13): mm = op
IF g$ = CHR$(13) THEN
        IF mm = op THEN COLOR 7, 0: CLS : PRINT "Program Written by: Corey Badeaux  Tronix Developers '95": PRINT : END
        IF mm = 3 THEN GOTO 50
        IF mm = 2 THEN GOTO 100
        'IF mm = 1 THEN GOTO 100
        'IF mm = 4 THEN GOTO 500
END IF
GOTO 9

50 LOCATE 2, 1: PRINT "Time:  :   ": gettext 2, 6, hr$, 2
   gettext 2, 9, mn$, 2: IF VAL(hr$) <> 0 OR VAL(mn$) <> 0 THEN TIME$ = hr$ + ":" + mn$
   LOCATE 2, 65: PRINT "Date:  -  -19  ": gettext 2, 70, mn$, 2
   gettext 2, 73, dy$, 2: gettext 2, 78, yr$, 2
   IF VAL(mn$) <> 0 AND VAL(dy$) <> 0 THEN DATE$ = mn$ + "-" + dy$ + "-" + yr$
RUN

100 CLS : LOCATE 1, 25: PRINT "Inventory Item Maintainence"
    LOCATE 2, 1: PRINT " 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴"
    LOCATE 12, 1: PRINT " 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴"
    LOCATE 14, 1: PRINT " 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴"
    LOCATE 16, 1: PRINT " 컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴"
    LOCATE 3, 1: PRINT "Item Part #:#########"
    LOCATE 3, 45: PRINT "Cost $#####.##"
    LOCATE 5, 7: PRINT "Count:####"
    LOCATE 5, 40: PRINT "EXT. Cost $#####.##"
    LOCATE 7, 1: PRINT "Sale Price $#####.##"
    LOCATE 9, 1: PRINT "DESCRIPTION:"
    LOCATE 15, 33: PRINT "MENU OPTIONS"
    LOCATE 17, 1: PRINT "(ARROW KEYS) - Scroll +/- through Item Records     (Q/ESC) - Exit to Main   "
    LOCATE 18, 1: PRINT "(A) - Add NEW Item to record                       (D) - Delete Item Record "
    LOCATE 19, 1: PRINT "(I) - Item Search                                  (F) - Description Search "
   
    fln$ = "HOMEMART.INV": OPEN fln$ FOR BINARY AS 1
104 IF LOF(1) < 1 THEN g$ = "A": GOTO 112 ELSE ln = LOF(1) / 300: mm = 1
105 SEEK #1, (mm * 300) - 299: g$ = INPUT$(300, 1)
    item$ = MID$(g$, 1, 10): cost$ = MID$(g$, 11, 8): count$ = MID$(g$, 19, 5)
    extcost$ = STR$(VAL(count$) * VAL(cost$)): saleprice$ = MID$(g$, 24, 8)
    desc1$ = MID$(g$, 32, 60): desc2$ = MID$(g$, 92, 60): desc3$ = MID$(g$, 152, 60)
   
    IF srch = 1 AND INSTR(item$, item2$) = 0 THEN GOTO sr6
    IF srch = 2 AND INSTR(desc1$, item2$) = 0 THEN
       IF srch = 2 AND INSTR(desc2$, item2$) = 0 THEN
          IF srch = 2 AND INSTR(desc3$, item2$) = 0 THEN GOTO sr6
       END IF
    END IF

    LOCATE 3, 13: PRINT item$: LOCATE 3, 51: PRINT USING "#####.##"; VAL(cost$)
    LOCATE 5, 13: PRINT USING "#####"; VAL(count$)
    LOCATE 5, 51: PRINT USING "#####.##   "; VAL(extcost$)
    LOCATE 7, 13: PRINT USING "#####.##"; VAL(saleprice$)
    LOCATE 9, 13: PRINT desc1$: LOCATE 10, 13: PRINT desc2$
    LOCATE 11, 13: PRINT desc3$

    IF srch > 0 THEN
        srch2 = srch2 + 1
        LOCATE 13, 2: PRINT "ITEM:"; item2$; " Found:"; srch2
        LOCATE 13, 35: PRINT "Hit any key or ESC to end search."
sr5:    g$ = INKEY$: IF g$ = "" THEN GOTO sr5
        IF g$ = CHR$(27) THEN srch = 0: GOTO dl4:
sr6:    mm = mm + 1: IF mm > ln THEN srch = 0: LOCATE 13, 1: PRINT " Done Search." + SPACE$(65): SLEEP 2: LOCATE 13, 1: PRINT SPACE$(75): GOTO 104
GOTO 105
    END IF
110 g$ = UCASE$(INKEY$): IF g$ = "" THEN GOTO 110
    IF RIGHT$(g$, 1) = "H" THEN mm = mm + 10: IF mm > ln THEN mm = ln
    IF RIGHT$(g$, 1) = "P" THEN mm = mm - 10: IF mm < 1 THEN mm = 1
    IF RIGHT$(g$, 1) = "M" THEN mm = mm + 1: IF mm > ln THEN mm = ln
    IF RIGHT$(g$, 1) = "K" THEN mm = mm - 1: IF mm < 1 THEN mm = 1
    IF g$ = "Q" OR g$ = CHR$(27) THEN CLOSE 1: RUN
    IF g$ = "I" THEN
      LOCATE 13, 1: PRINT "Item to Search For:": gettext 13, 20, item2$, 10
      LOCATE 13, 1: PRINT SPACE$(75): IF item2$ = "" THEN GOTO dl4:
      srch = 1: srch2 = 0: GOTO 104
    END IF
    IF g$ = "F" THEN
      LOCATE 13, 1: PRINT "KeyWord to Search For:": gettext 13, 23, item2$, 20
      LOCATE 13, 1: PRINT SPACE$(75): IF item2$ = "" THEN GOTO dl4:
      mm = 1: srch = 2: srch2 = 0: GOTO 104
    END IF
    IF g$ = "D" THEN
dl1:   LOCATE 13, 1: PRINT "Are you sure (Y/N)?"
       g$ = UCASE$(INKEY$): IF g$ = "" THEN GOTO dl1
       IF g$ <> "Y" THEN GOTO dl4 ELSE CLOSE 1
       OPEN fln$ FOR BINARY AS 1: mm2 = 0
       OPEN "TEMP.TMP" FOR BINARY AS 2
dl2:   mm2 = mm2 + 1: g$ = INPUT$(300, 1): IF mm2 <> mm THEN PUT #2, , g$
       IF mm2 < ln THEN GOTO dl2
       CLOSE 1: KILL fln$: OPEN fln$ FOR BINARY AS 1: SEEK #2, 1
dl3:   g$ = INPUT$(300, 2): PUT #1, , g$: IF EOF(2) = 0 THEN GOTO dl3
       CLOSE 2: KILL "temp.tmp": LOCATE 13, 1: PRINT SPACE$(70): GOTO 104
dl4:   LOCATE 13, 1: PRINT SPACE$(70): GOTO 110
    END IF
112 IF g$ = "A" THEN GOTO 200 ELSE GOTO 105

200 SEEK #1, (LOF(1) + 1): LOCATE 13, 1: PRINT "Leave ITEM entry blank to EXIT"
201 gettext 3, 13, item$, 10: IF item$ = "" THEN CLOSE 1: RUN
    LOCATE 13, 1: PRINT SPACE$(70): item$ = LEFT$(item$ + SPACE$(10), 10)
    IF LOF(1) > 0 THEN
       OPEN fln$ FOR BINARY AS 2
       FOR t = 1 TO ln: g$ = INPUT$(300, 2)
       IF LEFT$(g$, 10) = item$ THEN CLOSE 2: LOCATE 13, 1: PRINT "Sorry, that ITEM is already in use, try again.": GOTO 201
       NEXT t: CLOSE 2
    END IF
    gettext 3, 51, cost$, 8: LOCATE 3, 51: PRINT USING "#####.##   "; VAL(cost$)
    cost$ = LEFT$(cost$ + SPACE$(8), 8)
    gettext 5, 13, count$, 5: LOCATE 5, 13: PRINT USING "#####   "; VAL(count$)
    count$ = LEFT$(count$ + SPACE$(5), 5)
    extcost$ = STR$(VAL(count$) * VAL(cost$)): LOCATE 5, 51: PRINT USING "#####.##   "; VAL(extcost$)
    gettext 7, 13, saleprice$, 8: LOCATE 7, 12: PRINT USING "#####.##   "; VAL(saleprice$)
    saleprice$ = LEFT$(saleprice$ + SPACE$(8), 8)
    gettext 9, 13, desc1$, 60: gettext 10, 13, desc2$, 60: gettext 11, 13, desc3$, 60
    desc1$ = LEFT$(desc1$ + SPACE$(60), 60): desc2$ = LEFT$(desc2$ + SPACE$(60), 60)
    desc3$ = LEFT$(desc3$ + SPACE$(60), 60)
    LOCATE 13, 1: PRINT "Is everything Correct (Y/N)?"
210 g$ = UCASE$(INKEY$)
    IF g$ = "Y" THEN GOTO 220
    IF g$ = "N" THEN GOTO 200 ELSE GOTO 210
220 fill$ = SPACE$(300 - 211): PUT #1, , item$: PUT #1, , cost$
    PUT #1, , count$: PUT #1, , saleprice$: PUT #1, , desc1$
    PUT #1, , desc2$: PUT #1, , desc3$: PUT #1, , fill$
    LOCATE 13, 1: PRINT SPACE$(70)
GOTO 104

SUB gettext (x, y, t$, stp)
IF LEFT$(t$, 1) = "~" THEN t$ = RIGHT$(t$, LEN(t$) - 1) ELSE t$ = ""
GOTO here:
back: g$ = UCASE$(INKEY$): LOCATE x, LEN(t$) + y, 1: IF g$ = "" THEN GOTO back:
IF ((ASC(g$) >= 32 AND ASC(g$) <= 92) OR g$ = " ") AND LEN(t$) < stp THEN t$ = t$ + g$
IF LEN(t$) > 0 AND g$ = CHR$(8) THEN t$ = LEFT$(t$, LEN(t$) - 1)
IF g$ = CHR$(13) THEN COLOR 15, 0: GOTO gow:
here:
        COLOR 0, 15: LOCATE x, y: PRINT t$; STRING$(stp - LEN(t$), " ")
GOTO back:
gow: LOCATE , , 0
END SUB


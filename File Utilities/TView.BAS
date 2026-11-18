'$DYNAMIC
DEFLNG A-Z
DIM ps(200) AS STRING * 255:  ON ERROR GOTO 91
DIM pt(5000) AS LONG
SCREEN 0
IF COMMAND$ = "" OR INSTR(COMMAND$, "?") > 0 THEN GOTO 88
OPEN COMMAND$ FOR BINARY AS 1
IF LOF(1) = 0 THEN CLOSE 1: KILL COMMAND$: GOTO 89
CLOSE 1: OPEN COMMAND$ FOR INPUT AS 1
10 CLS : LOCATE 22, 1, 0: COLOR 15, 0: PRINT "                  TRONiX Developers T-VIEW v1.5 By: C.Badeaux"
LOCATE 21, 1: FOR t = 1 TO 15: PRINT "°"; : NEXT t: FOR t = 1 TO 15: PRINT "±";
NEXT t: FOR t = 1 TO 9: PRINT "²"; : NEXT t: PRINT "Û"; : FOR t = 1 TO 9: PRINT "²";
NEXT t: FOR t = 1 TO 15: PRINT "±"; : NEXT t: FOR t = 1 TO 15: PRINT "°"; : NEXT t
IF cl > 0 THEN GOTO 51
bc = 0: cl = 15: l = 0: k = 0: lp = 1: lne = 0: sd = 1: be = 1: GOSUB 200: GOTO 51
50 g$ = UCASE$(INKEY$)
IF g$ = "" THEN
        COLOR 15, 0
        LOCATE 22, 1: PRINT "TIME:"; TIME$
        LOCATE 22, 65: PRINT "DATE:"; DATE$
        all = lp + lne: IF all + 19 > top THEN all2 = top ELSE all2 = all + 19
        LOCATE 23, 1: PRINT USING "X:####Ä####:#### Y:###"; all; all2; top; sd
        GOTO 50
END IF
IF g$ = CHR$(27) OR UCASE$(g$) = "Q" THEN GOTO 90
IF RIGHT$(g$, 1) = "P" AND (lp + lne + 19) < top THEN lp = lp + 1: IF lp > 179 THEN lne = lne + 179: lp = 1: GOSUB 200
IF RIGHT$(g$, 1) = "H" THEN lp = lp - 1: IF lp < 1 THEN lne = lne - 179: lp = 179: GOSUB 200
IF RIGHT$(g$, 1) = "Q" AND (lp + lne + 39) < top THEN lp = lp + 20
IF RIGHT$(g$, 1) = "Q" AND (lp + lne + 39) >= top AND top > 18 THEN lp = (top - lne - 19)
IF RIGHT$(g$, 1) = "Q" THEN IF lp > 179 THEN lp = lp - 179: lne = lne + 179: GOSUB 200
IF RIGHT$(g$, 1) = "I" THEN lp = lp - 20: IF lp < 1 THEN lp = lp + 179: lne = lne - 179: GOSUB 200
IF RIGHT$(g$, 1) = "M" THEN sd = sd + 5: IF sd > 254 THEN sd = 255
IF RIGHT$(g$, 1) = "K" THEN sd = sd - 5: IF sd < 1 THEN sd = 1
IF LEFT$(g$, 1) = "" THEN GOTO 51
IF g$ = "P" THEN
        OPEN COMMAND$ FOR INPUT AS 5
        OPEN "LPT1:BIN" FOR OUTPUT AS 6
her:    LINE INPUT #5, g$: PRINT #6, g$
        IF EOF(5) = 0 THEN GOTO her:
        CLOSE 5, 6
END IF
IF g$ = "+" THEN cl = cl + 1: IF cl > 15 THEN cl = 0
IF g$ = "-" THEN cl = cl - 1: IF cl < 0 THEN cl = 15
IF g$ = "]" THEN bc = bc + 1: IF bc > 15 THEN bc = 1
IF g$ = "[" THEN bc = bc - 1: IF bc < 1 THEN bc = 15
IF g$ = "*" THEN CLS : PRINT "TRONiX DOSSHELL. Type 'EXIT' to return to T-VIEW.": SHELL: GOTO 10
IF g$ = "?" THEN GOTO 300
51 COLOR cl, bc: LOCATE 1, 1: FOR t = 0 TO 19: PRINT "                                                                               "
LOCATE CSRLIN - 1: PRINT MID$(ps(lp + t), sd, 79): NEXT t
GOTO 50
88 PRINT
   PRINT "T-View v1.5  TRONiX Developers '96  Written By: DICEMAN"
   PRINT "    For more help, hit '?' while viewing a Textfile."
   PRINT "        Usage: Tview.EXE [Textfile to view]": PRINT : END
89 COLOR 7, 0: CLS : SCREEN 0: COLOR 7, 0: PRINT "Sorry, File not found.": END
90 COLOR 7, 0: CLS : SCREEN 0: COLOR 7, 0: PRINT "Thanks for using T-View v1.5 Written By: Corey Badeaux": END
91 COLOR 7, 0: CLS : SCREEN 0: COLOR 7, 0: PRINT "An error in textfile has occured.": END
200 ct = 0: o = 0: IF be = 0 THEN l = lne / 179
IF lne < 0 THEN lne = 0: lp = 1: GOTO 51
IF lne > top THEN lne = blne
IF lne > blne THEN ct = ct + (179 * l): SEEK #1, pt(l)
IF lne < blne THEN ct = ct + (179 * l): IF lne > 0 THEN SEEK #1, pt(l) ELSE SEEK #1, 1: ct = 0
blne = lne
205 LINE INPUT #1, e$: ct = ct + 1: IF INSTR(e$, CHR$(12)) > 0 THEN MID$(e$, INSTR(e$, CHR$(12))) = CHR$(32)
IF INSTR(e$, CHR$(7)) > 0 THEN MID$(e$, INSTR(e$, CHR$(7))) = CHR$(32)
IF ct > lne AND ct < lne + 200 THEN o = o + 1: ps(o) = e$: g$ = INKEY$
IF be = 1 THEN l = l + 1: IF l = 179 THEN l = 0: k = k + 1: pt(k) = SEEK(1)
IF ct = (200 + lne) AND be = 0 THEN GOTO 210
IF EOF(1) <> -1 THEN GOTO 205 ELSE IF be = 1 THEN top = ct
210 be = 0: g$ = "": RETURN

300 COLOR cl, 0: LOCATE 1, 1: FOR t = 0 TO 19: PRINT "                                                                               ": NEXT t
LOCATE 2, 1: PRINT "           T-VIEW v1.5  TRONiX Developers '96  Written By: C.Badeaux"
             PRINT "           ---------------------------------------------------------"
             PRINT : PRINT "                   To use T-VIEW, here are the commands:"
PRINT " (+/-) .... Changes Foreground Color     ([/]) .... Changes Background Color"
PRINT "(PGUP/DN) . Pages Up/Down 20 lines      (CSR:U/D) . Scrolls Text Up/Down 1 Line"
PRINT "(CSR:L/R) . Scrolls Text Left or Right    (?) ..... This Help Screen"
PRINT "  (*) ..... Shell to DOS                (ESC/Q) ... Exit Program"
PRINT "  (P) ..... Print Document "
LOCATE 20, 1: PRINT "                               -=<Hit Any Key>=-"
305 g$ = INKEY$: COLOR 15, 0: LOCATE 22, 1: PRINT "TIME:"; TIME$: LOCATE 22, 65: PRINT "DATE:"; DATE$
IF g$ = "" THEN GOTO 305 ELSE GOTO 51


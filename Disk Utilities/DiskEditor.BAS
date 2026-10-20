DEFINT A-Z
DECLARE SUB GETTEXT (x%, y%, t$, stp%)
DECLARE FUNCTION DRIVE1$ ()    ' Get the current DRIVE in DOS
DECLARE SUB Free (f1&, f2&, f3&, f4&)  'Ok this one gets info on the DISK.
				       'F1& = Sectors per Cluster
				       'F2& = Avaliable Clusters on Disk
				       'F3& = Bytes per Sector
				       'F4& = Clusters on Disk
				       'To get Free Space and Total Space:
				       'FREESPACE& = F1& * F2& * F3&
				       'TOTALSPCE& = F1& * F4& * F3&

SCREEN 0: WIDTH 80: CLS
REDIM in%(9), ot%(9)         'Define input and output
track = 1: sector = 1: head = 1: hd = 0
drive = ASC(DRIVE1$) - 65: f1& = drive + 1
Free f1&, f2&, f3&, f4&
IF drive > 1 THEN drive = drive + (&H80 - 2): hd = 1
GOSUB 1000
REM "HI/LO = AH/AL"
COLOR 11, 0: LOCATE 8, 34, 0: PRINT "           Tronix Developers '96 Disk Edit v1.0"
LOCATE 9, 34: PRINT "           Programmed by: Corey Badeaux"
COLOR 1, 0: LOCATE 8, 1: PRINT STRING$(32, "="); "|Position: |"
LOCATE 7, 33: PRINT STRING$(47, "=")
LOCATE 9, 23: PRINT "|Byte:    |          |": COLOR 12
LOCATE 10, 23: PRINT STRING$(57, "=")
LOCATE 13, 1: PRINT STRING$(80, "=")
LOCATE 14, 1: PRINT "(+) - Go Ahead a Track   (-) - Go Back a Track    (Q)uit to DOS"
LOCATE 15, 1: PRINT "(]) - Go Ahead a Sector  ([) - Go Back a Sector   (J)ump Track/Sector"
LOCATE 16, 1: PRINT "(T) - Change Track       (S) - Change Sector      (W)rite Trk/Sct"
LOCATE 17, 1: PRINT "(D) - Enter Drives(A-Z)  (H)ead Entry (1-Max)     (E)dit Mode"
LOCATE 18, 1: PRINT "(G)et Read Data          (P)aste Captured Data    (C)lear Captured Data"
LOCATE 19, 1: PRINT "(V) - Save Captured Data (L)oad Captured Data"

LOCATE 21, 1: PRINT STRING$(80, "=")
LOCATE 22, 1: PRINT "(B) - Change Byte        (ARROW KEYS) - Moves Cursor  (Q)uit to MAIN MENU"; ""
LOCATE 23, 1: PRINT "(T) - Enter TEXT Mode    (RETURN KEY) - Exit TEXT Mode"
COLOR 4, 0: LOCATE 13, 32: PRINT "* Menu Options *"
	    LOCATE 21, 32: PRINT "* Edit Options *"
50 sect$ = SPACE$(1024): st$ = "OK            "
FOR t = 0 TO 9: in%(t) = 0: NEXT t
in%(0) = VAL("&H0201")
IF wt = 1 THEN
	in%(0) = VAL("&H0301"): wt = 0: sect$ = ""
	FOR t = 1 TO 512: sect$ = sect$ + CHR$(PEEK((t * 2) - 2)): NEXT t
END IF
IF hd = 1 THEN
  n1 = track: n2 = sector: nn1 = 0: nn2 = 0
  IF n1 AND 1 THEN nn1 = nn1 + 1
  IF n1 AND 2 THEN nn1 = nn1 + 2
  IF n1 AND 4 THEN nn1 = nn1 + 4
  IF n1 AND 8 THEN nn1 = nn1 + 8
  IF n1 AND 16 THEN nn1 = nn1 + 16
  IF n1 AND 32 THEN nn1 = nn1 + 32
  IF n1 AND 64 THEN nn1 = nn1 + 64
  IF n1 AND 128 THEN nn1 = nn1 + 128
  IF n1 AND 256 THEN nn2 = nn2 + 64
  IF n1 AND 512 THEN nn2 = nn2 + 128

  IF n2 AND 1 THEN nn2 = nn2 + 1
  IF n2 AND 2 THEN nn2 = nn2 + 2
  IF n2 AND 4 THEN nn2 = nn2 + 4
  IF n2 AND 8 THEN nn2 = nn2 + 8
  IF n2 AND 16 THEN nn2 = nn2 + 16
  IF n2 AND 32 THEN nn2 = nn2 + 32
END IF
in%(1) = SADD(sect$)
in%(2) = VAL("&H" + RIGHT$("00" + HEX$(track - 1), 2) + RIGHT$("00" + HEX$(sector), 2))
IF hd = 1 THEN in%(2) = VAL("&H" + RIGHT$("00" + HEX$(nn1 - 1), 2) + RIGHT$("00" + HEX$(nn2), 2))
in%(3) = VAL("&H" + RIGHT$("00" + HEX$(head - 1), 2) + RIGHT$("00" + HEX$(drive), 2))
in%(4) = VAL("&H0000")
in%(5) = VAL("&H0000")
in%(6) = VAL("&H0000")
in%(7) = VAL("&H0000")
in%(8) = VAL("&H0000")
in%(9) = VARSEG(sect$)
CALL INT86XOLD(&H13, in%(), ot%())
in%(0) = VAL("&H0100")
in%(1) = VAL("&H0000")
in%(2) = VAL("&H0000")
CALL INT86XOLD(&H13, in%(), ot%())
stat = ot%(0): IF stat <> 0 THEN st$ = "Read Error :" + LEFT$(HEX$(stat), 2)

DEF SEG = &HB800
FOR t = 1 TO 512: y = ASC(MID$(sect$, t, 1)): POKE (t * 2) - 2, y: NEXT t
100 g$ = UCASE$(INKEY$)
101 COLOR 11, 0: LOCATE 10, 1, 0: PRINT "Track :"; track; "   "
LOCATE 11, 1: PRINT "Sector:"; sector; "   "
LOCATE 10, 15: PRINT "Head:"; head
IF drive < 2 THEN LOCATE 11, 15: PRINT "Drive:"; CHR$(65 + drive)
IF drive > 1 THEN LOCATE 11, 15: PRINT "Drive:"; CHR$(65 + drive - &H80 + 2)
LOCATE 12, 1: PRINT USING "On Block:########"; ((sector - 1) + ((head - 1) * maxsc&) + ((track - 1) * (maxhd * maxsc&)))
LOCATE 11, 27: PRINT USING "Sectors/Cluster:###  Bytes/Sector:####  Max Heads:###"; f1&; f3&; maxhd
LOCATE 12, 27: PRINT USING "Max Tracks:#####     Max Sectors:####"; maxtk; maxsc&
LOCATE 9, 1: PRINT "Status:"; st$
55 IF g$ = "+" THEN track = track + 1
IF g$ = "-" THEN track = track - 1: IF track < 1 THEN track = 1
IF g$ = "]" THEN sector = sector + 1
IF g$ = "[" THEN sector = sector - 1: IF sector < 1 THEN sector = 1
IF g$ = "J" THEN
	GETTEXT 10, 9, tra$, 4: tra = VAL(tra$)
	GETTEXT 11, 9, tra$, 3: sec = VAL(tra$): st$ = "New Trck/Sctr "
	IF tra <> 0 THEN track = tra
	IF sec <> 0 THEN sector = sec
END IF
IF g$ = "T" THEN
	GETTEXT 10, 9, tra$, 4: tra = VAL(tra$)
	IF tra <> 0 THEN track = tra: st$ = "New Track     "
END IF
IF g$ = "S" THEN
	GETTEXT 11, 9, tra$, 3: sec = VAL(tra$)
	IF sec <> 0 THEN sector = sec: st$ = "New Sector    "
END IF
IF g$ = "H" THEN GETTEXT 10, 20, tra$, 2: IF VAL(tra$) > 0 THEN head = VAL(tra$): st$ = "New Head      "
IF g$ = "G" THEN cap$ = sect$: cap = 1: st$ = "Captured Text "
IF g$ = "V" THEN
	LOCATE 9, 1: PRINT "FileName:             ": GETTEXT 9, 10, tra$, 8
	IF tra$ <> "" THEN
	       tra$ = tra$ + ".TS"
	       OPEN tra$ FOR BINARY AS 1: IF LOF(1) > 0 THEN SEEK #1, 1
	       PUT #1, , cap$: CLOSE 1
	END IF
END IF
IF g$ = "L" THEN
	LOCATE 9, 1: PRINT "FileName:             ": GETTEXT 9, 10, tra$, 8
	IF tra$ <> "" THEN
	       tra$ = tra$ + ".TS"
	       OPEN tra$ FOR BINARY AS 1
	       IF LOF(1) > 0 THEN cap$ = INPUT$(512, 1): cap = 1
	       IF LOF(1) = 0 THEN CLOSE 1: KILL tra$
	       CLOSE 1
	END IF
END IF
IF cap = 1 AND g$ = "P" THEN DEF SEG = &HB800: FOR t = 1 TO 512: y = ASC(MID$(cap$, t, 1)): POKE (t * 2) - 2, y: NEXT t: st$ = "Pasting Data  "
IF g$ = "C" THEN cap = 0: st$ = "Clear Data    "
IF g$ = "D" THEN
	GETTEXT 11, 21, tra$, 1: tra$ = UCASE$(tra$): hd = 0
	IF tra$ >= "A" AND tra$ <= "Z" THEN
	   drive = ASC(tra$) - 65: f1& = drive + 1
	   Free f1&, f2&, f3&, f4&
	   IF drive > 1 THEN drive = drive + (&H80 - 2): hd = 1
	   GOSUB 1000
	   st$ = "New Drive     "
	END IF
END IF
IF g$ = "E" THEN LOCATE 9, 8: COLOR 7, 0: PRINT "EDIT MODE": GOSUB 500
IF g$ = "W" THEN wt = 1: st$ = "Writing Data  "
IF g$ = "Q" THEN CLS : END
LOCATE 9, 1: PRINT "Status:"; st$
IF g$ <> "" THEN IF INSTR("+-[]JHDTSW", RIGHT$(g$, 1)) > 0 THEN GOTO 50
GOTO 100
 


FOR t = 1 TO 512: y = ASC(MID$(sect$, t, 1)): POKE (t * 2) - 2, y: NEXT t

500 DEF SEG = &HB800
    x = 1: y = 1
    LOCATE 9, 24, 0: PRINT USING "Byte:###"; PEEK(((((x - 1) * 80) + y) * 2) - 2)
    LOCATE 1, 1, 1
505 g$ = INKEY$: IF g$ = "" THEN GOTO 505
IF text = 0 THEN
    IF UCASE$(g$) = "Q" THEN GOTO 510
    IF UCASE$(g$) = "B" THEN
       GETTEXT 9, 29, tra$, 3
       POKE ((((x - 1) * 80) + y) * 2) - 2, VAL(tra$)
    END IF
    IF UCASE$(g$) = "T" THEN text = 1: g$ = "": LOCATE 9, 8: COLOR 7, 0: PRINT "TEXT MODE"
END IF

IF text = 1 AND g$ <> "" THEN
	IF g$ = CHR$(13) THEN text = 0: LOCATE 9, 8: COLOR 7, 0: PRINT "EDIT MODE"
	IF ASC(g$) > 31 THEN PRINT g$: g$ = " M"
	IF g$ = CHR$(8) THEN g$ = " K"
END IF
    g2$ = UCASE$(RIGHT$(g$, 1))
507 IF g2$ = "H" THEN x = x - 1
    IF x < 1 THEN x = 1
    IF g2$ = "P" THEN x = x + 1
    IF x > 7 THEN x = 7
    IF y > 32 AND x = 7 THEN x = 6
    IF g2$ = "K" THEN y = y - 1
    IF g2$ = "M" THEN y = y + 1
    IF y > 32 AND x = 7 THEN y = 32
    IF y > 80 THEN y = 1: g2$ = "P": GOTO 507
    IF y < 1 AND x > 1 THEN y = 80: g2$ = "H": GOTO 507
    IF y < 1 AND x = 1 THEN y = 1
    LOCATE 9, 24, 0: PRINT USING "Byte:###"; PEEK(((((x - 1) * 80) + y) * 2) - 2)
    LOCATE 9, 34: PRINT USING "###"; (((x - 1) * 80) + y - 1)
    LOCATE 9, 38: PRINT "/ "; HEX$(((x - 1) * 80) + y - 1); " "
    LOCATE x, y, 1, 6, 8
GOTO 505
510 LOCATE 1, 1, 0: RETURN

1000 FOR t = 0 TO 9: in%(t) = 0: ot%(t) = 0: NEXT t
in%(0) = VAL("&H0800")
in%(3) = VAL("&H" + RIGHT$("0000" + HEX$(drive), 2))
CALL INT86XOLD(&H13, in%(), ot%())
maxhd = VAL("&H" + LEFT$(RIGHT$("0000" + HEX$(ot%(3)), 4), 2)) + 1
n1 = VAL("&H" + LEFT$(RIGHT$("0000" + HEX$(ot%(2)), 4), 2))
n2 = VAL("&H" + RIGHT$("0000" + HEX$(ot%(2)), 2))
dh = VAL("&H" + RIGHT$("0000" + HEX$(ot%(1)), 2))

  nn1 = 0: nn2 = 0
  IF n1 AND 1 THEN nn1 = nn1 + 1
  IF n1 AND 2 THEN nn1 = nn1 + 2
  IF n1 AND 4 THEN nn1 = nn1 + 4
  IF n1 AND 8 THEN nn1 = nn1 + 8
  IF n1 AND 16 THEN nn1 = nn1 + 16
  IF n1 AND 32 THEN nn1 = nn1 + 32
  IF n1 AND 64 THEN nn1 = nn1 + 64
  IF n1 AND 128 THEN nn1 = nn1 + 128

  IF n2 AND 1 THEN nn2 = nn2 + 1
  IF n2 AND 2 THEN nn2 = nn2 + 2
  IF n2 AND 4 THEN nn2 = nn2 + 4
  IF n2 AND 8 THEN nn2 = nn2 + 8
  IF n2 AND 16 THEN nn2 = nn2 + 16
  IF n2 AND 32 THEN nn2 = nn2 + 32
  IF n2 AND 64 THEN nn1 = nn1 + 256
  IF n2 AND 128 THEN nn1 = nn1 + 512
maxtk = nn1 + 1: maxsc& = nn2: nn2 = 0: nn1 = 0
RETURN

FUNCTION DRIVE1$
REDIM i%(9), o%(9)
i%(0) = VAL("&H1900")
CALL INT86XOLD(&H21, i%(), o%())
DRIVE1$ = CHR$(65 + VAL("&H" + RIGHT$(HEX$(o%(0)), 2)))
END FUNCTION

DEFLNG A-Z
SUB Free (f1&, f2&, f3&, f4&)
REDIM in%(7), ot%(7)         'Define input and output
in%(0) = VAL("&H3600")
in%(3) = VAL("&H" + RIGHT$("0000" + HEX$(f1&), 4))
CALL INT86OLD(&H21, in%(), ot%())
f1& = ot%(0): f2& = ot%(1): f3& = ot%(2): f4& = ot%(3)
END SUB

DEFINT A-Z
SUB GETTEXT (x, y, t$, stp)
t$ = ""
back: g$ = UCASE$(INKEY$): LOCATE x, LEN(t$) + y, 1: IF g$ = "" THEN GOTO back:
IF ((ASC(g$) >= 32 AND ASC(g$) <= 92) OR g$ = " ") AND LEN(t$) < stp THEN t$ = t$ + g$
IF LEN(t$) > 0 AND g$ = CHR$(8) THEN t$ = LEFT$(t$, LEN(t$) - 1)
IF g$ = CHR$(13) THEN GOTO gow:
LOCATE x, y: PRINT t$; STRING$(stp - LEN(t$), " ")
GOTO back:
gow: LOCATE , , 0
END SUB


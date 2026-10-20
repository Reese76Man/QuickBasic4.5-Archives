DEFINT A-Z
DECLARE SUB Gettext (x%, y%, t$, stp%)
DECLARE FUNCTION DRIVE1$ ()    ' Get the current DRIVE in DOS
DECLARE SUB Free (f1&, f2&, f3&, f4&)  'Ok this one gets info on the DISK.
SCREEN 0: WIDTH 80: COLOR 7, 0: CLS : rn$ = ""
FOR t = 155 TO 255: rn$ = rn$ + CHR$(t): NEXT t: t = 0
REDIM in%(9), ot%(9)         'Define input and output
COLOR 9: LOCATE 1, 21, 0: PRINT "Tronix Developers '96 Disk Lock v1.0"
COLOR 11: LOCATE 2, 25: PRINT "Programmed by: Corey Badeaux"
COLOR 1: LOCATE 3, 25: PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴": COLOR 11
IF DRIVE1$ < "C" THEN COLOR 7, 0: PRINT : PRINT "               Sorry, program must be ran off of a Hard Drive.": PRINT : END
LOCATE 5, 35: PRINT "Options:": lck = 0
LOCATE 6, 23: PRINT "[L]ock Floppy Disk."
LOCATE 7, 23: PRINT "[U]nlock Floppy Disk."
LOCATE 8, 23: PRINT "[Q]uit to DOS."
 
10 g$ = UCASE$(INKEY$)
IF g$ = "Q" THEN COLOR 7, 0: CLS : PRINT "Disk-Lock v1.0 - Tronix Developers '96": PRINT : END
IF g$ = "L" THEN GOTO 5000
IF g$ = "U" THEN GOTO 4999
GOTO 10

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

REM "HI/LO = AH/AL"
2000 st$ = "OK            ": IF nm = 500 THEN sect$ = ""
FOR t = 0 TO 9: in%(t) = 0: NEXT t
in%(0) = VAL("&H0201")
IF sect$ <> "" THEN
	in%(0) = VAL("&H03" + RIGHT$("00" + HEX$(nm), 2))
ELSE
	sect$ = SPACE$(f3&)
END IF
in%(1) = SADD(sect$)
in%(2) = VAL("&H" + RIGHT$("00" + HEX$(track - 1), 2) + RIGHT$("00" + HEX$(sector), 2))
in%(3) = VAL("&H" + RIGHT$("00" + HEX$(head - 1), 2) + RIGHT$("00" + HEX$(drive), 2))
in%(9) = VARSEG(sect$)
CALL INT86XOLD(&H13, in%(), ot%())

in%(0) = VAL("&H0100")
in%(1) = VAL("&H0000")
in%(2) = VAL("&H0000")
CALL INT86XOLD(&H13, in%(), ot%())
stat = ot%(0): IF stat <> 0 THEN st$ = "Read Error :" + LEFT$(HEX$(stat), 2)
IF try = 0 AND stat <> 0 THEN try = 1: GOTO 2000 ELSE try = 0
RETURN

4999 lck = 1
5000 CLS : LOCATE 1, 25: PRINT "Disk Lock Activated": lck = lck + 1
	   LOCATE 2, 25: PRINT "컴컴컴컴컴컴컴컴컴�"
	   IF g$ = "L" THEN g$ = "LOCK" ELSE g$ = "UNLOCK"
	   LOCATE 3, 25: PRINT "Mode:"; g$
5005 dv$ = "Disk (A) or (B):": Gettext 4, 5, dv$, 1: dv$ = UCASE$(dv$): IF dv$ = "" THEN RUN
IF dv$ <> "A" AND dv$ <> "B" THEN GOTO 5005
ps$ = "Enter Password:": Gettext 5, 5, ps$, 15: ps$ = UCASE$(ps$): IF LEN(ps$) < 3 THEN RUN
FOR ps = 1 TO LEN(rn$): ps2 = ps2 + 1: IF ps2 > LEN(ps$) THEN ps2 = 1
ps3 = ASC(MID$(rn$, ps, 1)): ps4 = ASC(MID$(ps$, ps2, 1))
pss = ps3 - ps4
IF pss < 0 THEN pss = pss + 256
ps2$ = ps2$ + CHR$(pss)
NEXT ps: ps = 0: ps2 = 0: ps3 = 0: ps4 = 0: pss = 0: ps$ = ps2$: ps2$ = ""

fl$ = "TEMP.TDC": e = 0: g$ = ""
5010 OPEN fl$ FOR BINARY AS 1: IF LOF(1) > 0 THEN CLOSE 1: KILL fl$: GOTO 5010
drive = ASC(dv$) - 65: f1& = drive + 1
Free f1&, f2&, f3&, f4&: GOSUB 1000
LOCATE 6, 27: PRINT "Drive Status"
LOCATE 7, 27: PRINT "컴컴컴컴컴컴"
LOCATE 8, 1: PRINT USING "Sectors/Cluster:###  Bytes/Sector:####  Max Heads:###"; f1&; f3&; maxhd
LOCATE 9, 1: PRINT USING "Max Tracks:#####     Max Sectors:####"; maxtk; maxsc&
LOCATE 10, 1: PRINT "Reading:";
track = 1: FOR head = 1 TO 2
FOR sector = 1 TO maxsc&: IF head = 1 AND sector = 1 THEN sector = 2
GOSUB 2000: PRINT ".";

'                       ***ENCRYPTION PROCESS***
FOR ps = 1 TO LEN(sect$): ps2 = ps2 + 1: IF ps2 > LEN(ps$) THEN ps2 = 1
ps3 = ASC(MID$(sect$, ps, 1)): ps4 = ASC(MID$(ps$, ps2, 1))
IF lck = 1 THEN pss = ps3 - ps4 ELSE pss = ps3 + ps4
IF pss < 0 THEN pss = pss + 256
IF pss > 255 THEN pss = pss - 256
sect2$ = sect2$ + CHR$(pss)
NEXT ps

PUT #1, , sect2$: sect$ = "": sect2$ = ""
NEXT sector, head: CLOSE 1: e = 0: g$ = ""
ps = 0: ps2 = 0: ps3 = 0: ps4 = 0: pss = 0: ps$ = ps2$: ps2$ = ""
6010 OPEN fl$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL fl$: RUN
track = 1: nm = 1
LOCATE 8, 1: PRINT USING "Sectors/Cluster:###  Bytes/Sector:####  Max Heads:###"; f1&; f3&; maxhd
LOCATE 9, 1: PRINT USING "Max Tracks:#####     Max Sectors:####"; maxtk; maxsc&
LOCATE 10, 1: PRINT SPACE$(70): LOCATE 10, 1: PRINT "Writing:";

FOR head = 1 TO 2: IF head = 1 THEN sector = 1 ELSE sector = 0
6020 sector = sector + 1: PRINT ".";
sect$ = INPUT$(f3&, 1): GOSUB 2000
IF EOF(1) <> 0 THEN GOTO 6100
IF sector < maxsc& THEN GOTO 6020
NEXT head
6100 CLOSE : KILL "TEMP.TDC": RUN

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
SUB Gettext (x, y, t$, stp)
LOCATE x, y: PRINT t$: y = y + LEN(t$): t$ = ""
back: g$ = UCASE$(INKEY$): LOCATE x, LEN(t$) + y, 1: IF g$ = "" THEN GOTO back:
IF ((ASC(g$) >= 32 AND ASC(g$) <= 92) OR g$ = " ") AND LEN(t$) < stp THEN t$ = t$ + g$
IF LEN(t$) > 0 AND g$ = CHR$(8) THEN t$ = LEFT$(t$, LEN(t$) - 1)
IF g$ = CHR$(13) THEN GOTO gow:
LOCATE x, y: PRINT t$; STRING$(stp - LEN(t$), " ")
GOTO back:
gow: LOCATE , , 0
END SUB


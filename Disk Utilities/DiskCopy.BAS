DEFINT A-Z
DECLARE SUB Gettext (x%, y%, t$, stp%)
DECLARE FUNCTION DRIVE1$ ()    ' Get the current DRIVE in DOS
DECLARE SUB Free (f1&, f2&, f3&, f4&)  'Ok this one gets info on the DISK.
				       'F1& = Sectors per Cluster
				       'F2& = Avaliable Clusters on Disk
				       'F3& = Bytes per Sector
				       'F4& = Clusters on Disk
				       'To get Free Space and Total Space:
				       'FREESPACE& = F1& * F2& * F3&
				       'TOTALSPCE& = F1& * F4& * F3&

SCREEN 0: WIDTH 80: COLOR 7, 0: CLS
REDIM in%(9), ot%(9)         'Define input and output
COLOR 9: LOCATE 1, 21, 0: PRINT "Tronix Developers '96 Disk Copy v1.0"
COLOR 11: LOCATE 2, 25: PRINT "Programmed by: Corey Badeaux"
COLOR 1: LOCATE 3, 25: PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴": COLOR 11
IF DRIVE1$ < "C" THEN COLOR 7, 0: PRINT : PRINT "               Sorry, program must be ran off of a Hard Drive.": PRINT : END
LOCATE 5, 35: PRINT "Options:"
LOCATE 6, 23: PRINT "[S]ave entire disk as .TDC-File."
LOCATE 7, 23: PRINT "[M]irror .TDC-File to disk."
LOCATE 8, 23: PRINT "[C]ompare .TDC to disk."
LOCATE 9, 23: PRINT "[V]iew contents of disk."
LOCATE 10, 23: PRINT "[Q]uit to DOS."
 
10 g$ = UCASE$(INKEY$)
IF g$ = "Q" THEN COLOR 7, 0: CLS : PRINT "Disk-Copy v1.0 - Tronix Developers '96": PRINT : END
IF g$ = "M" THEN GOTO 6000
IF g$ = "C" THEN GOTO 7000
IF g$ = "V" THEN GOTO 3000
IF g$ = "S" THEN GOTO 5000
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

3000 CLS : LOCATE 1, 30: PRINT "View Disk"
	   LOCATE 2, 30: PRINT "컴컴컴컴�"
3005 dv$ = "Disk (A), (B), or (Q)uit:": Gettext 5, 20, dv$, 1: dv$ = UCASE$(dv$): IF dv$ = "" THEN RUN
IF dv$ <> "A" AND dv$ <> "B" AND dv$ <> "Q" THEN GOTO 3005
IF dv$ = "Q" THEN RUN
CLS : SHELL "dir/w/s/p " + dv$ + ":"
SLEEP: g$ = INKEY$: RUN

5000 CLS : LOCATE 1, 25: PRINT "Save Disk to File"
	   LOCATE 2, 25: PRINT "컴컴컴컴컴컴컴컴�"
5005 dv$ = "Disk (A) or (B):": Gettext 4, 5, dv$, 1: dv$ = UCASE$(dv$): IF dv$ = "" THEN RUN
IF dv$ <> "A" AND dv$ <> "B" THEN GOTO 5005
fl$ = "Name disk:": Gettext 5, 5, fl$, 8: fl$ = UCASE$(fl$): IF fl$ = "" THEN RUN
fl$ = fl$ + ".TDC": e = 0: g$ = ""
5010 OPEN fl$ FOR BINARY AS 1: IF LOF(1) > 0 THEN CLOSE 1: KILL fl$: GOTO 5010
drive = ASC(dv$) - 65: f1& = drive + 1
Free f1&, f2&, f3&, f4&: GOSUB 1000
LOCATE 6, 1: PRINT "Bios reports these figures, just leave blank if they are correct."
LOCATE 7, 1: PRINT "Source Drive:"; dv$
LOCATE 8, 1: PRINT USING "Sectors/Cluster:###  Bytes/Sector:####  Max Heads:###"; f1&; f3&; maxhd
LOCATE 9, 1: PRINT USING "Max Tracks:#####     Max Sectors:####"; maxtk; maxsc&
Gettext 8, 53, g$, 2: g = VAL(g$): IF g <> 0 THEN maxhd = g: g$ = ""
Gettext 9, 15, g$, 2: g = VAL(g$): IF g <> 0 THEN maxtk = g: g$ = ""
Gettext 9, 36, g$, 2: g = VAL(g$): IF g <> 0 THEN maxsc& = g: g$ = ""
g = f3& / 256
g$ = CHR$(g): PUT #1, , g$
g$ = CHR$(maxtk): PUT #1, , g$
g$ = CHR$(maxhd): PUT #1, , g$
g$ = CHR$(maxsc&): PUT #1, , g$: g$ = "": g = 0
LOCATE 6, 1: PRINT SPACE$(70)
FOR track = 1 TO maxtk
FOR head = 1 TO maxhd
FOR sector = 1 TO maxsc&
GOSUB 2000: PUT #1, , sect$: sect$ = ""
LOCATE 11, 1: PRINT "Track :"; track; "   "
LOCATE 11, 20: PRINT "Sector:"; sector; "   "
LOCATE 11, 40: PRINT "Head:"; head
LOCATE 11, 55: PRINT "Status:"; st$: IF LEFT$(st$, 2) <> "OK" THEN e = e + 1
LOCATE 12, 1: PRINT USING "On Block:########"; ((sector - 1) + ((head - 1) * maxsc&) + ((track - 1) * (maxhd * maxsc&)))
LOCATE 12, 20: PRINT "Length of "; fl$; ":"; LOF(1), "Errors:"; e
NEXT sector, head, track: RUN

6000 CLS : LOCATE 1, 25: PRINT "Mirror .TDC to Disk"
	   LOCATE 2, 25: PRINT "컴컴컴컴컴컴컴컴컴�"
6005 dv$ = "Mirroring to Disk (A) or (B):": Gettext 4, 5, dv$, 1: dv$ = UCASE$(dv$): IF dv$ = "" THEN RUN
IF dv$ <> "A" AND dv$ <> "B" THEN GOTO 6005
fl$ = "Name of .TDC:": Gettext 5, 5, fl$, 8: fl$ = UCASE$(fl$): IF fl$ = "" THEN RUN
fl$ = fl$ + ".TDC": e = 0: g$ = ""
6010 OPEN fl$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL fl$: RUN
g$ = INPUT$(1, 1): f3& = ASC(g$) * 256
g$ = INPUT$(1, 1): maxtk = ASC(g$)
g$ = INPUT$(1, 1): maxhd = ASC(g$)
g$ = INPUT$(1, 1): maxsc& = ASC(g$)
LOCATE 7, 1: PRINT "Destination Drive:"; dv$
LOCATE 8, 1: PRINT USING "Bytes/Sector:####  Max Heads:###"; f3&; maxhd
LOCATE 9, 1: PRINT USING "Max Tracks:#####     Max Sectors:####"; maxtk; maxsc&

FOR track = 1 TO maxtk
FOR head = 1 TO maxhd: sector = 0
6020 IF (sector + 4) <= maxsc& THEN nm = 4 ELSE nm = (maxsc& - sector)
sector = sector + 1
sect$ = INPUT$((f3& * nm), 1): GOSUB 2000
sector = sector + nm - 1
IF EOF(1) <> 0 THEN GOTO 6100
LOCATE 11, 1: PRINT "Track :"; track; "   "
LOCATE 11, 20: PRINT "Sector:"; sector; "   "
LOCATE 11, 40: PRINT "Head:"; head
LOCATE 11, 55: PRINT "Status:"; st$: IF LEFT$(st$, 2) <> "OK" THEN e = e + 1
LOCATE 12, 1: PRINT USING "On Block:########"; ((sector - 1) + ((head - 1) * maxsc&) + ((track - 1) * (maxhd * maxsc&)))
LOCATE 12, 20: PRINT "Bytes read from "; fl$; ":"; LOC(1), "Errors:"; e
IF sector < maxsc& THEN GOTO 6020
NEXT head, track
6100 CLOSE : RUN

7000 CLS : LOCATE 1, 20: PRINT "Compare .TDC to Disk"
7005 dv$ = "Mirroring to Disk (A) or (B):": Gettext 3, 5, dv$, 1: dv$ = UCASE$(dv$): IF dv$ = "" THEN RUN
IF dv$ <> "A" AND dv$ <> "B" THEN GOTO 7005
fl$ = "Name of .TDC:": Gettext 4, 5, fl$, 8: fl$ = UCASE$(fl$): IF fl$ = "" THEN RUN
fl$ = fl$ + ".TDC": e = 0: g$ = "": df = 0
7010 OPEN fl$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL fl$: RUN
g$ = INPUT$(1, 1): f3& = ASC(g$) * 256
g$ = INPUT$(1, 1): maxtk = ASC(g$)
g$ = INPUT$(1, 1): maxhd = ASC(g$)
g$ = INPUT$(1, 1): maxsc& = ASC(g$)
LOCATE 7, 1: PRINT "Source Drive:"; dv$
LOCATE 8, 1: PRINT USING "Bytes/Sector:####  Max Heads:###"; f3&; maxhd
LOCATE 9, 1: PRINT USING "Max Tracks:#####     Max Sectors:####"; maxtk; maxsc&

FOR track = 1 TO maxtk
FOR head = 1 TO maxhd
FOR sector = 1 TO maxsc&:  st$ = "OK          ": nm = 500
sect2$ = INPUT$(f3&, 1): GOSUB 2000
IF sect2$ <> sect$ THEN st$ = "BAD COMPARE": OPEN "temp.tmp" FOR BINARY AS 2: PUT #2, , sect$: PUT #2, , sect2$: CLOSE 2
IF EOF(1) <> 0 THEN GOTO 7100
IF LEFT$(st$, 2) <> "OK" THEN e = e + 1
IF LEFT$(st$, 3) = "BAD" THEN df = df + 1
LOCATE 11, 1: PRINT "Track :"; track; "   "
LOCATE 11, 20: PRINT "Sector:"; sector; "   "
LOCATE 11, 40: PRINT "Head:"; head
LOCATE 11, 55: PRINT "Status:"; st$
LOCATE 12, 1: PRINT USING "On Block:########"; ((sector - 1) + ((head - 1) * maxsc&) + ((track - 1) * (maxhd * maxsc&)))
LOCATE 12, 20: PRINT "Bytes read from "; fl$; ":"; LOC(1), "Errors:"; e
LOCATE 13, 1: PRINT "Differences:"; df
NEXT sector, head, track
LOCATE 15, 1
IF e = 0 THEN PRINT "Perfect Mirror Copy."
7100  LOCATE 20, 1: PRINT "Hit any key"
      CLOSE : SLEEP: g$ = INKEY$: RUN

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


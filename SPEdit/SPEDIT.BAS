DEFINT A-Z
DECLARE SUB vgaprint (x, y, txt$, adj)
DECLARE SUB gettext (x%, y%, t$, stp%)
DIM Image1(1 TO 8192) AS INTEGER
DIM Image2(1 TO 5120) AS INTEGER
DIM Ie(1 TO 405)  AS INTEGER
DIM PreImage(1 TO 405)  AS INTEGER
DIM red1(256), red2(256) AS INTEGER
DIM grn1(256), grn2(256) AS INTEGER
DIM blu1(256), blu2(256) AS INTEGER
DIM ag(256) AS INTEGER
DIM SHARED acii(1000) AS INTEGER
beg$ = COMMAND$
FOR t = 1 TO 405: READ P$: Ie(t) = VAL("&H" + P$): NEXT t
FOR t = 1 TO ((26 + 16) * 15): READ acii(t): NEXT t: RESTORE
IF INSTR(beg$, "?") > 0 THEN
        PRINT : PRINT "Image Editor V1.0  Written by Corey Badeaux"
        PRINT "Usage  : SPEDIT.EXE <FILENAME>.<PIC>"
        PRINT "Example: SPEDIT TRONIX or SPEDIT TRONIX.PIC"
        PRINT "Filename is only optional."
        PRINT : END
END IF
1 CLS : SCREEN 13: COLOR 7: jk = 40: xzm = 1: yzm = 1
f$ = "temp$$.pic": OPEN f$ FOR BINARY AS 1: CLOSE 1: KILL f$
100 CLS : dt1 = 7: dt2 = 0: Menu = 0: x = 0: y = 0: bc = 0: dr = 0: g$ = "M"
wth& = 320: ht& = 200: ce = 0: bn = 0: ln = 0: bx = 0: GET (0, 150)-(319, 199), Image1
IF beg$ <> "" THEN
        f$ = beg$: GOSUB PIC:
        IF INSTR(beg$, ".") > 0 THEN beg$ = LEFT$(beg$, INSTR(beg$, ".") - 1)
        f$ = beg$: GOSUB pal:
        beg$ = ""
END IF
GET (270, 0)-(319, 199), Image2: GOTO 111

106 LINE (0, 150)-(270, 150), 11: LINE (270, 0)-(270, 150), 11
COLOR jk: vgaprint 0, 69, "Color-1", 0
LOCATE 2, 35: PRINT USING ">###< "; dt1
COLOR dt1
LOCATE 3, 35: PRINT "ллллл "
LOCATE 4, 35: PRINT "ллллл "
COLOR jk: LOCATE 6, 35: PRINT USING ">###< "; dt2
vgaprint 5, 69, "Color-2", 1
COLOR dt2
LOCATE 7, 35: PRINT "ллллл "
LOCATE 8, 35: PRINT "ллллл "
COLOR jk: vgaprint 10, 68, "Curent Color", 3
bc = POINT(x, y): LOCATE 10, 35: PRINT USING ">###< "; bc
COLOR bc
LOCATE 11, 35: PRINT "ллллл "
'LOCATE 12, 35: PRINT "ллллл "
COLOR jk: IF svdt = 0 THEN f$ = "OFF " ELSE f$ = "ON  "
LOCATE 12, 35: PRINT "I:"; f$
LOCATE 13, 35: PRINT USING "X:### "; x
LOCATE 14, 35: PRINT USING "Y:### "; y
vgaprint 21, 68, "Exit - Q/ESC", 2
vgaprint 22, 68, "Draw-", 3
vgaprint 23, 68, "Draw - D", 4
IF dr = 1 THEN LOCATE 18, 38: PRINT "ON "
IF dr = 0 THEN LOCATE 18, 38: PRINT "OFF"
109 bc = POINT(x, y)
110 g$ = UCASE$(INKEY$)
H = H + 1: PSET (x, y), H: IF H = 255 THEN H = 0
111 IF g$ = "" THEN GOTO 110 ELSE PSET (x, y), bc
IF g$ = CHR$(27) OR g$ = "Q" THEN
        SCREEN 0: WIDTH 80: COLOR 7, 0
        PRINT "'Only the ELITE shall survive' - Diceman": PRINT
        f$ = "temp$$.pic": OPEN f$ FOR BINARY AS 1: CLOSE 1: KILL f$
        END
END IF
IF LEFT$(g$, 1) = CHR$(0) THEN
        IF RIGHT$(g$, 1) = "M" THEN x = x + 1
        IF RIGHT$(g$, 1) = "P" THEN y = y + 1
        IF RIGHT$(g$, 1) = "K" THEN x = x - 1
        IF RIGHT$(g$, 1) = "H" THEN y = y - 1
END IF
IF g$ = "6" THEN x = x + 10
IF g$ = "2" THEN y = y + 10
IF g$ = "4" THEN x = x - 10
IF g$ = "8" THEN y = y - 10
IF g$ = "9" THEN x = x + 10: y = y - 10
IF g$ = "3" THEN y = y + 10: x = x + 10
IF g$ = "1" THEN x = x - 10: y = y + 10
IF g$ = "7" THEN y = y - 10: x = x - 10


IF Menu > 0 THEN
7  IF x > 269 THEN x = 269
   IF y > 149 THEN y = 149
END IF
IF Menu = 0 THEN
   IF x > 319 THEN x = 319
   IF y > 199 THEN y = 199
END IF
IF x < 0 THEN x = 0
IF y < 0 THEN y = 0

IF g$ = "+" OR g$ = "=" THEN dt1 = dt1 + 1: IF dt1 > 255 THEN dt1 = 0
IF g$ = "-" OR g$ = "_" THEN dt1 = dt1 - 1: IF dt1 < 0 THEN dt1 = 255

IF g$ = "." OR g$ = ">" THEN dt2 = dt2 + 1: IF dt2 > 255 THEN dt2 = 0
IF g$ = "," OR g$ = "<" THEN dt2 = dt2 - 1: IF dt2 < 0 THEN dt2 = 255

IF g$ = "R" THEN GOTO 100

IF g$ = "L" AND Menu > 0 THEN
        LOCATE 20, 1: COLOR jk: PRINT SPACE$(40): PRINT SPACE$(40)
        f$ = "Load .PIC file:"
        gettext 20, 1, f$, 8
PIC:    IF INSTR(f$, ".") = 0 THEN f$ = f$ + ".PIC"
        IF f$ = "" OR f$ = ".PIC" THEN GOTO ok:
        DEF SEG = &HA000: CLS : U& = 0: E& = 0
        OPEN f$ FOR BINARY AS 1
        IF LOF(1) = 0 AND beg$ = "" THEN CLOSE 1: KILL f$: GOTO ok:
        IF LOF(1) = 0 AND beg$ <> "" THEN CLOSE 1: KILL f$: RETURN

        ln& = (LOF(1) - 1) / ASC(INPUT$(1, 1))
back:   f$ = INPUT$(1024, 1)
        FOR H = 1 TO LEN(f$)
        POKE U& + (E& * 320), ASC(MID$(f$, H, 1))
        U& = U& + 1: IF U& = ln& THEN U& = 0: E& = E& + 1
        NEXT H
        IF EOF(1) = 0 THEN GOTO back:
        GET (0, 150)-(319, 199), Image1: GET (270, 0)-(319, 199), Image2
ok:     PUT (0, 150), Image1, PSET: PUT (270, 0), Image2, PSET
        CLOSE 1: H = 0: g$ = "M": Menu = 0
        IF beg$ <> "" THEN RETURN
END IF
        

IF g$ = "S" AND Menu > 0 THEN
        LOCATE 20, 1: COLOR jk: PRINT SPACE$(40): PRINT SPACE$(40)
        f$ = "Save .PIC file:"
        gettext 20, 1, f$, 8
        IF INSTR(f$, ".") = 0 THEN f$ = f$ + ".PIC"
        IF f$ = "" OR f$ = ".PIC" THEN GOTO sok:
        DEF SEG = &HA000: U = 0: uw = 0: ht& = 200: wth& = 320
        PUT (0, 150), Image1, PSET: PUT (270, 0), Image2, PSET
sback:  OPEN f$ FOR BINARY AS 1: IF LOF(1) > 0 THEN CLOSE 1: KILL f$: GOTO sback:
        H$ = CHR$(ht&): PUT #1, , H$: H$ = ""
        FOR t& = 1 TO ht& * wth&
        H$ = H$ + CHR$(POINT(U, uw))
        U = U + 1: IF U = wth& THEN U = 0: PUT #1, , H$: H$ = "": uw = uw + 1
        NEXT t&: IF U > 0 THEN PUT #1, , H$
sok:    PUT (0, 150), Image1, PSET: PUT (270, 0), Image2, PSET
        CLOSE 1: H = 0: g$ = "M": Menu = 0
END IF

IF g$ = "H" AND Menu > 0 THEN
        LOCATE 20, 1: COLOR jk: PRINT SPACE$(40): PRINT SPACE$(40)
        f$ = "Save .PIC image:"
        gettext 20, 1, f$, 8
        IF INSTR(f$, ".") = 0 THEN f$ = f$ + ".PIC"
        IF f$ = "" OR f$ = ".PIC" THEN GOTO youy:
        OPEN f$ FOR BINARY AS 1: CLOSE 1: KILL f$
        SHELL "ren temp$$.pic " + f$
youy:   PUT (0, 150), Image1, PSET: PUT (270, 0), Image2, PSET
        Menu = 0: g$ = "M"
END IF

IF g$ = "Y" AND Menu > 0 THEN
        LOCATE 20, 1: COLOR jk: PRINT SPACE$(40): PRINT SPACE$(40)
        f$ = "Load .PIC image:"
        gettext 20, 1, f$, 8
        IF INSTR(f$, ".") = 0 THEN f$ = f$ + ".PIC"
        IF f$ = "" OR f$ = ".PIC" THEN GOTO ok:
        OPEN f$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL f$: GOTO gki:  ELSE CLOSE 1
        SHELL "copy " + f$ + " temp$$.pic >nul": svdt = 1
gki:    PUT (0, 150), Image1, PSET: PUT (270, 0), Image2, PSET
        CLOSE 1: H = 0: Menu = 0: g$ = "M"
END IF

IF g$ = "P" AND svdt = 1 THEN
        U& = x: E& = y: f$ = "temp$$.pic"
        DEF SEG = &HA000
        OPEN f$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL f$: GOTO Lok:
        ln& = ((LOF(1) - 1) / ASC(INPUT$(1, 1))) + x
cik:    f$ = INPUT$(1024, 1)
        FOR H = 1 TO LEN(f$)
        IF E& < 200 AND U& < 320 THEN
          IF xzm = 1 AND yzm = 1 THEN
                      POKE U& + (E& * 320), ASC(MID$(f$, H, 1))
                ELSE
                      LINE (U&, E&)-(U& + xzm, E& + xzm), ASC(MID$(f$, H, 1)), BF
          END IF
        END IF
        U& = U& + xzm: IF U& = ln& THEN U& = x: E& = E& + yzm
        NEXT H
        IF EOF(1) = 0 THEN GOTO cik:
Lok:    CLOSE 1: H = 0
END IF

IF g$ = "G" AND gx = 1 THEN
        PSET (xb, yb), cg: bc = cg
        IF x = xb OR y = yb THEN svdt = 0: gx = 0: GOTO mkk:
        IF x < xb THEN U = x: wth& = xb - x ELSE U = xb: wth& = x - xb
        IF y < yb THEN uw = y: ht& = yb - y ELSE uw = yb: ht& = y - yb
        ht& = ht& + 1: wth& = wth& + 1
        gx = 0: g$ = "": W& = U + wth&: ju = U
kop:    OPEN "temp$$.pic" FOR BINARY AS 1: IF LOF(1) > 0 THEN CLOSE 1: KILL "temp$$.pic": GOTO kop:
        H$ = CHR$(ht&): PUT #1, , H$: H$ = ""
        FOR t& = 1 TO ht& * wth&
        H$ = H$ + CHR$(POINT(U, uw))
        U = U + 1: IF U = W& THEN U = ju: PUT #1, , H$: H$ = "": uw = uw + 1
        NEXT t&: IF U > 0 THEN PUT #1, , H$
        CLOSE 1: H = 0: svdt = 1
END IF
IF g$ = "G" AND gx = 0 THEN gx = 1: xb = x: yb = y: g$ = CHR$(13): cg = POINT(x, y)

IF g$ = "E" THEN svdt = 0: gx = 0: f$ = "temp$$.pic": OPEN f$ FOR BINARY AS 1: CLOSE 1: KILL f$

IF g$ = "I" AND svdt = 1 THEN
        f$ = "temp$$.pic"
        OPEN f$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL f$: GOTO mkk:
        OPEN "temp$$$.pic" FOR BINARY AS 2
        ju = ASC(INPUT$(1, 1))
        ln& = (LOF(1) - 1) / ju: lon& = ln&
        IF ln& > 255 THEN ln& = 255
        H$ = CHR$(ln&): PUT #2, , H$: H$ = ""
        FOR t = 1 TO ln&
        FOR H = (ju - 1) TO 0 STEP -1
        SEEK #1, (H * lon&) + t + 1
        f$ = INPUT$(1, 1)
        PUT #2, , f$
        NEXT H, t: CLOSE 1, 2: KILL "temp$$.pic"
        SHELL "ren temp$$$.pic temp$$.pic"
mkk:    CLOSE 1, 2: H = 0
END IF

IF g$ = "A" AND svdt = 1 THEN
        f$ = "temp$$.pic"
        OPEN f$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL f$: GOTO mkk:
        OPEN "temp$$$.pic" FOR BINARY AS 2
        ju = ASC(INPUT$(1, 1))
        ln& = (LOF(1) - 1) / ju
        H$ = CHR$(ju): PUT #2, , H$: H$ = ""
        FOR t = 1 TO ju
        FOR H = 0 TO (ln& - 1)
        SEEK #1, (t * ln&) - H + 1
        f$ = INPUT$(1, 1)
        PUT #2, , f$
        NEXT H, t: CLOSE 1, 2: KILL "temp$$.pic"
        SHELL "ren temp$$$.pic temp$$.pic"
        CLOSE 1, 2: H = 0
END IF

IF g$ = "U" AND svdt = 1 THEN
        f$ = "temp$$.pic"
        OPEN f$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL f$: GOTO mkk:
        OPEN "temp$$$.pic" FOR BINARY AS 2
        ju = ASC(INPUT$(1, 1)): H$ = CHR$(ju): PUT #2, , H$
bhr:    H$ = INPUT$(1024, 1): f$ = ""
        FOR t = 1 TO LEN(H$): f$ = f$ + CHR$(255 - ASC(MID$(H$, t, 1)))
        NEXT t: PUT #2, , f$: IF EOF(1) = 0 THEN GOTO bhr:
        CLOSE 1, 2: KILL "temp$$.pic"
        SHELL "ren temp$$$.pic temp$$.pic"
END IF

mn:
IF g$ = "M" THEN
        Menu = Menu + 1: IF Menu > 1 THEN Menu = 0
IF Menu = 0 THEN PUT (0, 150), Image1, PSET: PUT (270, 0), Image2, PSET
   IF Menu = 1 THEN
        GET (0, 150)-(319, 199), Image1: GET (270, 0)-(319, 199), Image2
        LINE (0, 151)-(319, 199), 15, BF
        LINE (270, 0)-(319, 150), 0, BF
        vgaprint 25, 0, "Tronix Developers Image Editor v2.0.", 0
        vgaprint 26, 0, "  ---Written by Corey Badeaux---   .", 0
        vgaprint 27, 0, "....................................", 0
        vgaprint 28, 0, "M-Menu On/off       R-Erase Screen", 0
        vgaprint 29, 0, "W-Blend .PLT        K-Pallette Editor", 0
        vgaprint 25, 40, "B-Draw a Box        C-Draw a Circle", 0
        vgaprint 26, 40, "F-Filled Box        V-Filled Circle", 0
        vgaprint 27, 40, "N-Draw Line         U-Image Negative", 0
        vgaprint 28, 40, "T-Import Text       O-Paint Filler", 0
        vgaprint 29, 40, "ENTER-Plot Dot 1    SPACE-Plot Dot 2", 0
        vgaprint 30, 0, ":/--Change Color 1  ;/<-Change Color 2", 0
        vgaprint 31, 0, "CSR/NM-Move Cursor  L/S-Lde/Sve Pctre", 0
        vgaprint 32, 0, "Z/X-Grab Color 1/2  Y/H-Lde/Sve Image", 0
        vgaprint 30, 40, "A-Mirror Image      I-Rotate Image", 0
        vgaprint 31, 40, "E-Erase Image       Y-Import Image", 0
        vgaprint 32, 40, "J-Zoom Edit         G/P-Get/Put Image", 0
   END IF
IF x > 269 THEN x = 269
IF y > 149 THEN y = 149
END IF

IF Menu <> 0 AND g$ = "W" THEN GOTO Blend:

IF g$ = "T" THEN
        COLOR dt1: LOCATE INT(y / 8) + 1, INT(x / 8) + 1: LINE INPUT "", f$
END IF

IF g$ = "O" THEN
        IF Menu <> 0 THEN PUT (0, 150), Image1, PSET: PUT (270, 0), Image2, PSET
        PAINT (x, y), dt1, dt2
        IF Menu <> 0 THEN
                GET (0, 150)-(319, 199), Image1: GET (270, 0)-(319, 199), Image2
                bc = dt1: g$ = "M": Menu = 0: GOTO 111
        END IF
END IF

IF g$ = "C" AND ce = 1 THEN
        ce = 0: g$ = "": PSET (xb, yb), ceb: ceb = 0
        IF Menu <> 0 THEN PUT (0, 150), Image1, PSET: PUT (270, 0), Image2, PSET
        CIRCLE (xb, yb), ABS(x - xb), dt1: g$ = ""
        IF Menu <> 0 THEN
                GET (0, 150)-(319, 199), Image1: GET (270, 0)-(319, 199), Image2
                IF y = yb THEN bc = dt1
                g$ = "M": Menu = 0: GOTO 111
        END IF
END IF
IF g$ = "C" AND ce = 0 THEN ce = 1: xb = x: yb = y: ceb = POINT(x, y): g$ = CHR$(13)


IF g$ = "K" THEN
        DEF SEG = &HA000
        BSAVE "tmp$.pic", 0, 64000
        CLS : GOSUB 500
        BLOAD "tmp$.pic", 0: KILL "tmp$.pic"
END IF

IF g$ = "J" THEN
        GOSUB ZoomEdit:
        DEF SEG = &HA000
        BSAVE "tmp$.pic", 0, 64000
        CLS : GOSUB 1000
        BLOAD "tmp$.pic", 0: KILL "tmp$.pic"
        IF f$ <> "ABORT" THEN PUT (x, y), Ie, PSET
END IF

IF g$ = "V" AND ce = 1 THEN
        ce = 0: g$ = "": PSET (xb, yb), ceb: ceb = 0
        IF Menu <> 0 THEN PUT (0, 150), Image1, PSET: PUT (270, 0), Image2, PSET
        CIRCLE (xb, yb), ABS(x - xb), dt1: g$ = ""
        PAINT (xb, yb), dt1, dt1
        IF Menu <> 0 THEN
                GET (0, 150)-(319, 199), Image1: GET (270, 0)-(319, 199), Image2
                IF y = yb THEN bc = dt1
                g$ = "M": Menu = 0: GOTO 111
        END IF
END IF
IF g$ = "V" AND ce = 0 THEN ce = 1: xb = x: yb = y: ceb = POINT(x, y): g$ = CHR$(13)

IF g$ = "N" AND ln = 1 THEN ln = 0: LINE (xb, yb)-(x, y), dt1: g$ = ""
IF g$ = "N" AND ln = 0 THEN ln = 1: xb = x: yb = y: g$ = CHR$(13)

IF g$ = "B" AND bx = 1 THEN bx = 0: LINE (xb, yb)-(x, y), dt1, B: g$ = ""
IF g$ = "B" AND bx = 0 THEN bx = 1: xb = x: yb = y: g$ = CHR$(13)

IF g$ = "F" AND bn = 1 THEN bn = 0: LINE (xb, yb)-(x, y), dt1, BF: g$ = ""
IF g$ = "F" AND bn = 0 THEN bn = 1: xb = x: yb = y: g$ = CHR$(13)

IF g$ = "Z" THEN dt1 = POINT(x, y)

IF g$ = "X" THEN dt2 = POINT(x, y)

IF g$ = "D" THEN IF dr = 0 THEN dr = 1 ELSE dr = 0
IF dr = 1 THEN g$ = CHR$(13)

IF g$ = CHR$(13) THEN PSET (x, y), dt1
IF g$ = CHR$(32) THEN PSET (x, y), dt2
IF Menu <> 0 THEN GOTO 106 ELSE GOTO 109

500 CLS : cl = 0: bcl = 0: COLOR jk
LOCATE 11, 7: PRINT "   Color Spectrum"
LOCATE 12, 7: PRINT " <----(0-255:###)---->"
vgaprint 1, 20, ":/-    Palette Editor Options", 0
vgaprint 2, 20, "------------------------------------", 0
vgaprint 3, 20, "O/P - Red control      S - Save .PLT", 0
vgaprint 4, 20, "k/l - Green control    L - Load .PLT", 0
vgaprint 5, 20, "N/M - Blue control     X - Quit to main", 0
vgaprint 6, 20, "W/E - Brightness", 0
vgaprint 7, 20, "R/T - Rotate Palette", 0
'LOCATE 6, 10: PRINT " [CURSOR KEYS]-Color Control "
LOCATE 5, 1: COLOR 12: PRINT "------+":
FOR t = 0 TO 255: LINE (t + 5, 110)-(t + 5, 190), t: NEXT t
505 LOCATE 1, 1
LINE (bcl + 5, 109)-(bcl + 5, 100), 0: LINE (bcl + 5, 200)-(bcl + 5, 191), 0
LINE (cl + 5, 109)-(cl + 5, 100), 12: LINE (cl + 5, 200)-(cl + 5, 191), 12
bcl = cl: COLOR cl
PRINT "лллллл"; : COLOR 12: PRINT "|": COLOR cl
PRINT "лллллл"; : COLOR 12: PRINT "|": COLOR cl
PRINT "лллллл"; : COLOR 12: PRINT "|": COLOR cl
PRINT "лллллл"; : COLOR 12: PRINT "|": COLOR jk
LOCATE 12, 20: PRINT USING "###"; cl
OUT &H3C7, cl: rd = INP(&H3C9): gn = INP(&H3C9): bl = INP(&H3C9)
LOCATE 6, 1
PRINT "Red  :"; rd
PRINT "Green:"; gn
PRINT "Blue :"; bl
510 I$ = UCASE$(INKEY$): IF I$ = "" THEN GOTO 510
IF I$ = "P" THEN rd = rd + 1: IF rd > 63 THEN rd = 63
IF I$ = "O" THEN rd = rd - 1: IF rd < 0 THEN rd = 0
IF I$ = "L" THEN gn = gn + 1: IF gn > 63 THEN gn = 63
IF I$ = "K" THEN gn = gn - 1: IF gn < 0 THEN gn = 0
IF I$ = "M" THEN bl = bl + 1: IF bl > 63 THEN bl = 63
IF I$ = "N" THEN bl = bl - 1: IF bl < 0 THEN bl = 0
IF RIGHT$(I$, 1) = "M" THEN cl = cl + 1
IF RIGHT$(I$, 1) = "P" THEN cl = cl - 10
IF RIGHT$(I$, 1) = "K" THEN cl = cl - 1
IF RIGHT$(I$, 1) = "H" THEN cl = cl + 10
IF cl > 255 THEN cl = 255
IF cl < 0 THEN cl = 0
IF I$ = "X" OR I$ = "Q" OR I$ = CHR$(27) THEN RETURN
IF I$ = "S" THEN GOTO 600
IF I$ = "L" THEN GOTO 700
IF LEFT$(I$, 1) <> CHR$(0) THEN OUT &H3C7, cl - 1: OUT &H3C9, rd: OUT &H3C9, gn: OUT &H3C9, bl: OUT &HC8, cl - 1
GOTO 505

600 LOCATE 6, 10: PRINT "                             ": LOCATE 6, 10: COLOR jk
     f$ = "Save .PAL file:"
     gettext 6, 10, f$, 8
     COLOR 4

IF INSTR(f$, ".") = 0 THEN f$ = f$ + ".PLT"
IF f$ = "" OR f$ = ".PLT" THEN GOTO 505
601 OPEN f$ FOR BINARY AS 1: IF LOF(1) > 0 THEN CLOSE 1: KILL f$: GOTO 601
FOR t = 0 TO 255
OUT &H3C7, t
P$ = CHR$(INP(&H3C9)) + CHR$(INP(&H3C9)) + CHR$(INP(&H3C9))
PUT #1, , P$: NEXT t: CLOSE 1: GOTO 505

700  LOCATE 6, 10: PRINT "                             ": LOCATE 6, 10: COLOR jk
     f$ = "Load .PAL file:"
     gettext 6, 10, f$, 8
     COLOR 4
pal: IF INSTR(f$, ".") = 0 THEN f$ = f$ + ".PLT"
     IF f$ = "" OR f$ = ".PLT" THEN GOTO 505
701 OPEN f$ FOR BINARY AS 1
IF LOF(1) = 0 AND beg$ = "" THEN CLOSE 1: KILL f$: GOTO 505
IF LOF(1) = 0 AND beg$ <> "" THEN CLOSE 1: KILL f$: RETURN
FOR t = 0 TO 255
P$ = INPUT$(3, 1): rd = ASC(LEFT$(P$, 1)): gn = ASC(MID$(P$, 2, 1)): bl = ASC(RIGHT$(P$, 1))
OUT &H3C7, t - 1: OUT &H3C9, rd: OUT &H3C9, gn: OUT &H3C9, bl: OUT &HC8, t - 1
NEXT t: CLOSE 1: IF beg$ <> "" THEN RETURN ELSE GOTO 505

1000 CLS : PUT (1, 1), PreImage, PSET: xp = 4: yp = 1: cl = dt1
1001 FOR t = 1 TO 20: FOR yt = 1 TO 40: pv = POINT(yt, t): COLOR pv
LOCATE t + 3, yt: PRINT "л"
NEXT yt: NEXT t   ' THIS IS THE PRINTED DATA FOR USERS

1002     COLOR jk
        LOCATE 1, 10: PRINT "'R'-RVSE|'+/-'-COLOR|[CR]-CL1"
        LOCATE 2, 10: PRINT "'X'-EXIT|'A'  -ABORT|[SP]-CL2"
1005    LOCATE 3, 10: PRINT "                             "
LOCATE 3, 10: COLOR cl: PRINT "Color:"; cl

1010 L$ = INKEY$: P$ = CHR$(SCREEN(xp, yp)): COLOR cl
lc = POINT((yp * 8) - 4, (xp * 8) - 4): IF lc <> 0 THEN COLOR lc
COLOR 15: LOCATE xp, yp: PRINT "*": COLOR lc
1011 COLOR 15: ccl = POINT(yp, xp - 3): LOCATE 3, 22: PRINT "Cur. Color:"; ccl: COLOR lc
IF L$ = "" THEN L$ = INKEY$: GOTO 1011
LOCATE xp, yp: PRINT P$
IF RIGHT$(L$, 1) = "M" THEN yp = yp + 1: IF yp > 40 THEN yp = 40
IF RIGHT$(L$, 1) = "H" THEN xp = xp - 1: IF xp < 4 THEN xp = 4
IF RIGHT$(L$, 1) = "P" THEN xp = xp + 1: IF xp > 23 THEN xp = 23
IF RIGHT$(L$, 1) = "K" THEN yp = yp - 1: IF yp < 1 THEN yp = 1
IF L$ = "+" THEN cl = cl + 1: IF cl > 255 THEN cl = 1: GOTO 1005 ELSE GOTO 1005
IF L$ = "-" THEN cl = cl - 1: IF cl < 1 THEN cl = 255: GOTO 1005 ELSE GOTO 1005
IF UCASE$(L$) = "A" THEN yp = 0: xp = 0: P$ = "": cl = 0: f$ = "ABORT": L$ = "": RETURN
IF UCASE$(L$) = "X" OR UCASE$(I$) = "Q" OR I$ = CHR$(27) THEN
        GET (1, 1)-(40, 20), Ie: yp = 0: xp = 0: P$ = "": cl = 0: L$ = ""
        RETURN
END IF
IF UCASE$(L$) = "R" THEN GET (1, 1)-(40, 20), Ie: PUT (1, 1), Ie, PRESET: GOTO 1001
IF L$ = CHR$(13) THEN COLOR cl: LOCATE xp, yp: PRINT "л": GOTO 1016
IF L$ = CHR$(32) THEN COLOR dt2: LOCATE xp, yp: PRINT "л": GOTO 1016
1015 GOTO 1010 ' THIS IS THE SCREEN GET ROUTINE

1016 FOR t = 1 TO 20: FOR yt = 1 TO 40: py = (yt * 8) - 4: px = (t + 2) * 8
PSET (yt, t), POINT(py, px): NEXT yt, t
GOTO 1002

ZoomEdit: FOR t = 1 TO 405: READ P$: Ie(t) = VAL("&H" + P$): NEXT t: RESTORE
yt = x: U = y: yy = x: uu = y: I$ = ""
GET (yt, U)-(yt + 39, U + 19), PreImage: GOTO 2005
2000 I$ = INKEY$: IF I$ = "" THEN GOTO 2000
2005 IF I$ = "8" THEN U = U - 5: IF U < 0 THEN U = 0
IF I$ = "2" THEN U = U + 5
IF I$ = "4" THEN yt = yt - 5: IF yt < 0 THEN yt = 0
IF I$ = "6" THEN yt = yt + 5
IF RIGHT$(I$, 1) = "M" THEN yt = yt + 1
IF RIGHT$(I$, 1) = "P" THEN U = U + 1
IF RIGHT$(I$, 1) = "K" THEN yt = yt - 1: IF yt < 0 THEN yt = 0
IF RIGHT$(I$, 1) = "H" THEN U = U - 1: IF U < 0 THEN U = 0
IF Menu > 0 THEN
        IF yt > 230 THEN yt = 230
        IF U > 130 THEN U = 130
ELSE
        IF yt > 280 THEN yt = 280
        IF U > 180 THEN U = 180
END IF
PUT (yy, uu), PreImage, PSET
IF I$ = CHR$(27) OR UCASE$(I$) = "Q" THEN GOTO 109
IF I$ = CHR$(13) OR I$ = CHR$(32) THEN I$ = "": x = yy: y = uu: U = 0: yt = 0: uu = 0: yy = 0: RETURN
GET (yt, U)-(yt + 39, U + 19), PreImage: PUT (yt, U), Ie, XOR: yy = yt: uu = U
GOTO 2000

DATA 140,14,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F
DATA F0F,F0F,F0F,F0F,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,F00,F,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,F00,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,F00,F
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,F00,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,F00,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,F00,F,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,F00,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,F00,F,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,F00,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA F00,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,F00,F,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,F00,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,F00,F,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,F00,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,F00,F
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,F00,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,F00,F,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,F00,F0F,F0F,F0F,F0F,F0F
DATA F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,F0F,0,0,0

Blend:
     LOCATE 20, 1: COLOR jk: PRINT SPACE$(40): PRINT SPACE$(40)
     f$ = "Blend Picture with .PAL file:"
     gettext 20, 1, f$, 8
     IF INSTR(f$, ".") = 0 THEN f$ = f$ + ".PLT"
     IF f$ = "" OR f$ = ".PLT" THEN GOTO en:
     OPEN f$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL f$: GOTO en:
     FOR t = 0 TO 255: P$ = INPUT$(3, 1)
     OUT &H3C7, (t)
     red2(t) = INP(&H3C9)
     grn2(t) = INP(&H3C9)
     blu2(t) = INP(&H3C9)
    
     red1(t) = ASC(LEFT$(P$, 1))
     grn1(t) = ASC(MID$(P$, 2, 1))
     blu1(t) = ASC(RIGHT$(P$, 1))
     NEXT t: CLOSE 1
     FOR t = 0 TO 255
     ag(t) = 255: totb = 255
     FOR yt = 0 TO 255
     tot = ABS(red1(yt) - red2(t))
     tot = tot + ABS(grn1(yt) - grn2(t))
     tot = tot + ABS(blu1(yt) - blu2(t))
     IF tot < totb THEN ag(t) = yt: totb = tot
     NEXT yt, t
     PUT (0, 150), Image1, PSET: PUT (270, 0), Image2, PSET
     DEF SEG = &HA000
     FOR t& = 0 TO 63999
     POKE t&, ag(PEEK(t&))
     NEXT t&
     GET (0, 150)-(319, 199), Image1: GET (270, 0)-(319, 199), Image2
     beg$ = "***": GOSUB pal: beg$ = ""
en:  PUT (0, 150), Image1, PSET: PUT (270, 0), Image2, PSET
     Menu = 0: g$ = "M": GOTO mn:


'Letters
DATA 1,1,1
DATA 1,0,1
DATA 1,1,1
DATA 1,0,1
DATA 1,0,1

DATA 1,1,0
DATA 1,0,1
DATA 1,1,1
DATA 1,0,1
DATA 1,1,0

DATA 1,1,1
DATA 1,0,0
DATA 1,0,0
DATA 1,0,0
DATA 1,1,1
          
DATA 1,1,0
DATA 1,0,1
DATA 1,0,1
DATA 1,0,1
DATA 1,1,0

DATA 1,1,1
DATA 1,0,0
DATA 1,1,1
DATA 1,0,0
DATA 1,1,1

DATA 1,1,1
DATA 1,0,0
DATA 1,1,1
DATA 1,0,0
DATA 1,0,0

DATA 1,1,1
DATA 1,0,0
DATA 1,1,0
DATA 1,0,1
DATA 1,1,1

DATA 1,0,1
DATA 1,0,1
DATA 1,1,1
DATA 1,0,1
DATA 1,0,1

DATA 1,1,1
DATA 0,1,0
DATA 0,1,0
DATA 0,1,0
DATA 1,1,1

DATA 0,1,1
DATA 0,0,1
DATA 0,0,1
DATA 1,0,1
DATA 0,1,0

DATA 1,0,1
DATA 1,1,0
DATA 1,1,0
DATA 1,0,1
DATA 1,0,1

DATA 1,0,0
DATA 1,0,0
DATA 1,0,0
DATA 1,0,0
DATA 1,1,1

DATA 1,0,1
DATA 1,1,1
DATA 1,1,1
DATA 1,0,1
DATA 1,0,1

DATA 1,0,1
DATA 1,1,1
DATA 1,1,1
DATA 1,1,1
DATA 1,0,1

DATA 1,1,1
DATA 1,0,1
DATA 1,0,1
DATA 1,0,1
DATA 1,1,1

DATA 1,1,0
DATA 1,0,1
DATA 1,1,0
DATA 1,0,0
DATA 1,0,0

DATA 0,1,0
DATA 1,0,1
DATA 1,0,1
DATA 1,1,1
DATA 0,1,1

DATA 1,1,0
DATA 1,0,1
DATA 1,1,0
DATA 1,0,1
DATA 1,0,1

DATA 0,1,1
DATA 1,0,0
DATA 1,1,0
DATA 0,0,1
DATA 1,1,0

DATA 1,1,1
DATA 0,1,0
DATA 0,1,0
DATA 0,1,0
DATA 0,1,0

DATA 1,0,1
DATA 1,0,1
DATA 1,0,1
DATA 1,0,1
DATA 1,1,1

DATA 1,0,1
DATA 1,0,1
DATA 1,0,1
DATA 1,0,1
DATA 0,1,0

DATA 1,0,1
DATA 1,0,1
DATA 1,0,1
DATA 1,1,1
DATA 1,0,1

DATA 1,0,1
DATA 1,0,1
DATA 0,1,0
DATA 1,0,1
DATA 1,0,1

DATA 1,0,1
DATA 1,0,1
DATA 0,1,0
DATA 0,1,0
DATA 0,1,0

DATA 1,1,1
DATA 0,0,1
DATA 0,1,0
DATA 1,0,0
DATA 1,1,1

' Some symbols
DATA 0,0,0
DATA 0,0,0
DATA 1,1,1
DATA 0,0,0
DATA 0,0,0

DATA 0,0,0
DATA 0,0,0
DATA 0,0,0
DATA 1,1,0
DATA 1,1,0

DATA 0,0,1
DATA 0,0,1
DATA 0,1,0
DATA 1,0,0
DATA 1,0,0

' NUMBERS
DATA 0,1,0
DATA 1,0,1
DATA 1,0,1
DATA 1,0,1
DATA 0,1,0

DATA 1,1,0
DATA 0,1,0
DATA 0,1,0
DATA 0,1,0
DATA 1,1,1

DATA 1,1,0
DATA 0,0,1
DATA 0,1,0
DATA 1,0,0
DATA 1,1,1

DATA 1,1,0
DATA 0,0,1
DATA 0,1,0
DATA 0,0,1
DATA 1,1,0

DATA 1,0,1
DATA 1,0,1
DATA 1,1,1
DATA 0,0,1
DATA 0,0,1

DATA 1,1,1
DATA 1,0,0
DATA 1,1,0
DATA 0,0,1
DATA 1,1,0

DATA 0,1,1
DATA 1,0,0
DATA 1,1,0
DATA 1,0,1
DATA 0,1,0

DATA 1,1,1
DATA 1,0,1
DATA 0,0,1
DATA 0,1,0
DATA 0,1,0

DATA 0,1,0
DATA 1,0,1
DATA 0,1,0
DATA 1,0,1
DATA 0,1,0

DATA 0,1,1
DATA 1,0,1
DATA 0,1,1
DATA 0,0,1
DATA 0,0,1

DATA 0,0,0
DATA 0,1,0
DATA 1,1,1
DATA 0,1,0
DATA 0,0,0

DATA 0,0,1
DATA 0,1,0
DATA 1,0,0
DATA 0,1,0
DATA 0,0,1

DATA 1,0,0
DATA 0,1,0
DATA 0,0,1
DATA 0,1,0
DATA 1,0,0

SUB gettext (x, y, t$, stp)
LOCATE x, y: PRINT t$: y = y + LEN(t$): t$ = ""
getback: g$ = UCASE$(INKEY$): LOCATE x, LEN(t$) + y, 1: IF g$ = "" THEN GOTO getback:
IF ((ASC(g$) >= 32 AND ASC(g$) <= 92) OR g$ = " ") AND LEN(t$) < stp THEN t$ = t$ + g$
IF LEN(t$) > 0 AND g$ = CHR$(8) THEN t$ = LEFT$(t$, LEN(t$) - 1)
IF g$ = CHR$(13) THEN GOTO gow:
LOCATE x, y: PRINT t$; STRING$(stp - LEN(t$), " ")
GOTO getback:
gow: LOCATE , , 0
END SUB

SUB vgaprint (x, y, txt$, adj) STATIC
DEF SEG = &HA000
x& = (x * 6) + 2 + adj: y = y * 4: txt$ = UCASE$(txt$): cr = 40
FOR t = 1 TO LEN(txt$)
byte = ASC(MID$(txt$, t, 1))
y2 = 0: x2& = 0
FOR t2 = 1 TO 15
y2 = y2 + 1: IF y2 = 4 THEN x2& = x2& + 1: y2 = 1
IF byte > 64 AND byte < 64 + 27 THEN
   IF acii(((byte - 65) * 15) + t2) = 1 THEN POKE (y2 + y) + ((x2& + x&) * 320), cr
END IF
IF byte > 44 AND byte < 61 THEN
   IF acii(((byte - 46 + 27) * 15) + t2) = 1 THEN POKE (y2 + y) + ((x2& + x&) * 320), cr
END IF
NEXT t2
y = y + 4
NEXT t
END SUB


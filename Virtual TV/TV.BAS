DEFLNG A-Z
SCREEN 13: cl = 1: ch = 4: vol = 1
DEF SEG = &HA000
FOR t = 0 TO 255
OUT &H3C8, t
OUT &H3C9, 0
OUT &H3C9, 0
OUT &H3C9, 0
NEXT t
BLOAD "tv.dat"

OUT &H3C8, 1
OUT &H3C9, 0
OUT &H3C9, 63
OUT &H3C9, 0

BSAVE "tmp.pic", 0, 64000: BLOAD "tmp.pic"


5 COLOR 1: LOCATE 2, 35: PRINT USING "CH ##"; ch

10 FOR t = 2 TO 255
r = INT(RND * 63)
OUT &H3C8, t: OUT &H3C9, r: OUT &H3C9, r: OUT &H3C9, r
NEXT t

u$ = UCASE$(INKEY$)
IF l = 1 AND z < TIMER THEN u$ = "V"
IF u$ = "" THEN GOTO 10
IF u$ = "+" AND l = 0 THEN ch = ch + 1: IF ch > 99 THEN ch = 1
IF u$ = "-" AND l = 0 THEN ch = ch - 1: IF ch < 1 THEN ch = 99
IF u$ = "+" AND l = 1 THEN vol = vol + 1:  z = TIMER + 4: IF vol > 21 THEN vol = 21
IF u$ = "-" AND l = 1 THEN vol = vol - 1: z = TIMER + 4: IF vol < 1 THEN vol = 1
IF u$ = CHR$(27) OR u$ = "Q" THEN GOTO 20
IF u$ = "V" THEN IF l = 0 THEN l = 1: z = TIMER + 4 ELSE l = 0: BLOAD "tmp.pic"
IF l = 1 THEN
LOCATE 20, 17: PRINT "VOLUME"
LOCATE 21, 9: PRINT "|----------+----------|"
LOCATE 21, 9 + vol: PRINT "*"
END IF
GOTO 5
20 FOR t = 0 TO 200: FOR y = 1 TO 250: NEXT y
LINE (t, t)-(320 - t, 200 - t), 0, B: NEXT t
SCREEN 0: WIDTH 80: KILL "tmp.pic": END


DEFINT A-Z
CLS : SCREEN 13
RANDOMIZE TIMER
DIM Image(1 TO 405)  AS INTEGER
LOCATE 4: INPUT "Load .SPT File:", l$: F$ = l$ + ".SPT": l$ = l$ + ".PIC"
OPEN F$ FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: Image(t) = VAL("&H" + p$): NEXT t: CLOSE 1
PUT (0, 0), Image, PSET
10 OPEN l$ FOR BINARY AS 1: i$ = "": IF LOF(1) > 0 THEN CLOSE 1: KILL l$: GOTO 10
i$ = CHR$(20)
FOR t = 0 TO 19: FOR y = 0 TO 39
i$ = i$ + CHR$(POINT(y, t))
NEXT y, t
PUT #1, , i$: CLOSE 1
PRINT "Press any key"
SLEEP: SCREEN 0: WIDTH 80: END






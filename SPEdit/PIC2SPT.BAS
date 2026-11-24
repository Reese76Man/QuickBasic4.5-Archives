DEFINT A-Y
CLS : SCREEN 13
DIM Image(1 TO 405)  AS INTEGER
LOCATE 10, 1: LINE INPUT "Load .PIC:", f$
pic:    IF INSTR(f$, ".") = 0 THEN f$ = f$ + ".PIC"
        IF f$ = "" OR f$ = ".PIC" THEN GOTO ok:
        DEF SEG = &HA000: CLS : u& = 0: e& = 0
        OPEN f$ FOR BINARY AS 1
        IF LOF(1) = 0 AND beg$ = "" THEN CLOSE 1: KILL f$: GOTO ok:
        IF LOF(1) = 0 AND beg$ <> "" THEN CLOSE 1: KILL f$: RETURN

        ln& = (LOF(1) - 1) / ASC(INPUT$(1, 1))
back:   f$ = INPUT$(1024, 1)
        FOR h = 1 TO LEN(f$)
        POKE u& + (e& * 320), ASC(MID$(f$, h, 1))
        u& = u& + 1: IF u& = ln& THEN u& = 0: e& = e& + 1
        NEXT h
        IF EOF(1) = 0 THEN GOTO back:
ok: CLOSE 1
200 LOCATE 3, 10: PRINT "                             ": LOCATE 3, 10: COLOR 1
INPUT "Save .SPT File:", f$: COLOR 4: IF INSTR(f$, ".") = 0 THEN f$ = f$ + ".SPT"
201 OPEN f$ FOR BINARY AS 1: IF LOF(1) > 0 THEN CLOSE 1: KILL f$: GOTO 201
GET (0, 0)-(39, 19), Image
FOR st = 1 TO 405: p$ = HEX$(Image(st)) + ",": PUT #1, , p$
NEXT st: CLOSE 1: PRINT "Done!"



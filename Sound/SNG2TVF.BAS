DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DEFINT A-Z
CLS
PRINT ".SNG to .TVF file converter v1.0"
PRINT "   Written by: Corey Badeaux": PRINT
lst = 255: cnt = 0: file$ = COMMAND$
IF file$ = "" THEN
        PRINT "  USAGE: SNG2TVF <infile>.SNG": PRINT
        GOTO 20
END IF
1 j = INSTR(file$, ".")
IF j = 0 THEN file$ = file$ + ".SNG": GOTO 1
IF j > 0 THEN file1$ = LEFT$(file$, j) + "TVF"
2 OPEN file1$ FOR BINARY AS 1: IF LOF(1) > 0 THEN CLOSE 1: KILL file1$: GOTO 2
OPEN file$ FOR BINARY AS 2: IF LOF(2) = 0 THEN CLOSE 2: GOTO 20
5 q$ = INPUT$(2048, 2)
LOCATE 5, 1: PRINT "Reading bytes:"; LOC(2); " of "; LOF(2)
             PRINT "Writing bytes:"; LOF(1)
FOR t = 1 TO LEN(q$): byte = ASC(MID$(q$, t, 1))
IF byte < 16 THEN p = 0: GOTO 6
IF byte < 32 THEN byte = byte - 16: p = 1: GOTO 6
IF byte < 48 THEN byte = byte - 32: p = 2: GOTO 6
IF byte < 64 THEN byte = byte - 48: p = 3: GOTO 6
IF byte < 80 THEN byte = byte - 64: p = 4: GOTO 6
IF byte < 96 THEN byte = byte - 80: p = 5: GOTO 6
IF byte < 112 THEN byte = byte - 96: p = 6: GOTO 6
IF byte < 128 THEN byte = byte - 112: p = 7: GOTO 6
IF byte < 144 THEN byte = byte - 128: p = 8: GOTO 6
IF byte < 160 THEN byte = byte - 144: p = 9: GOTO 6
IF byte < 176 THEN byte = byte - 160: p = 10: GOTO 6
IF byte < 192 THEN byte = byte - 176: p = 11: GOTO 6
IF byte < 208 THEN byte = byte - 192: p = 12: GOTO 6
IF byte < 224 THEN byte = byte - 208: p = 13: GOTO 6
IF byte < 240 THEN byte = byte - 224: p = 14: GOTO 6
IF byte < 256 THEN byte = byte - 240: p = 15
6 FOR x = 0 TO p: r$ = r$ + CHR$(byte * 16): NEXT x
NEXT t
PUT #1, , r$: r$ = "": IF EOF(2) <> -1 THEN GOTO 5
20 CLOSE 1, 2: END

DEFSNG A-Z
FUNCTION samplebyte% (bp%)
CALL writedsp(&H20, bp%) 'Command to sample one byte
samplebyte% = INP(bp% + 10)
END FUNCTION

SUB sbreset (bp%)

'Resets the Soundblaster chip -
'call with bp% = Base Port (normally &h220)

dspreset% = bp% + 6
OUT dspreset%, 1
FOR t% = 1 TO 10
        a% = INP(dspreset%)  'Delay loop, give SB time to reset
NEXT t%
OUT dspreset%, 0
dspread% = bp% + 10
FOR t% = 1 TO 10
        a% = INP(dspread%)
NEXT t%

END SUB

SUB writedsp (byte%, bp%)
dspcmd% = bp% + 12
OUT dspcmd%, byte%
END SUB


DEFINT A-Z
DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DECLARE SUB sbreset (bp%)

bp% = &H220   'Soundblaster Base Port, change to &h240 or whatever
              'for different hardware configuration

CALL sbreset(bp%) 'Reset the Soundblaster card
DIM k(500): FOR t = 1 TO 500: k(t) = 220 + 128: NEXT t: k = 135
hdr$ = "TRONiX Developers can not be stopped trashtalker!" + CHR$(26) + CHR$(26)
SCREEN 12: CLS : PRINT
PRINT "                       Tronix TVF recorder v1.0"
PRINT
INPUT "Enter .TVF file to record to:", f$: IF INSTR(f$, ".") = 0 THEN f$ = f$ + ".TVF"
IF f$ = ".TVF" THEN GOTO 20
INPUT "Enter Buffer (15 = 15K):", buf: IF buf < 1 OR buf > 25 THEN buf = 25
INPUT "Enter Speed or record (0-Fastest|0-2000):", sp: IF sp < 0 OR sp > 2000 THEN sp = 0
INPUT "Do you want Graphical Display during record(Y/N):", g$: IF UCASE$(g$) = "N" THEN kk = 1
buf = buf * 1024
2 OPEN f$ FOR BINARY AS 1: IF LOF(1) > 0 THEN CLOSE 1: KILL f$: GOTO 2
PUT #1, , hdr$: hdr$ = ""
PRINT "Speak into the Microphone to test, then hit any key to start recording."
LINE (130, 215)-(450, 478), 5, B: PAINT (131, 216), 1, 5
3 FOR t = 1 TO 1024
byte = samplebyte(bp%): k = k + 1: PSET (k, k(k)), 1: PSET (k, byte + 220), 11: k(k) = byte + 220: IF k > 445 THEN k = 135
NEXT t: p$ = INKEY$: IF p$ = "" THEN GOTO 3
FOR t = 131 TO 449: LINE (t, 216)-(t, 477), 1: NEXT t
r$ = SPACE$(buf): DEF SEG = VARSEG(r$): lp = SADD(r$)
PRINT : PRINT "Now Sampling...Press 'q' to stop"
5  FOR t = 0 TO (buf - 1): byte = samplebyte(bp%): POKE lp + t, byte: IF kk = 1 THEN GOTO 7
k = k + 1: PSET (k, k(k)), 1: PSET (k, byte + 220), 11: k(k) = byte + 220: IF k > 445 THEN k = 135
7 IF sp > 0 THEN FOR l = 0 TO sp: NEXT l
NEXT t: PUT #1, , r$: p$ = UCASE$(INKEY$)
IF p$ <> "Q" THEN GOTO 5
20 CLOSE 1: r$ = "": SCREEN 0: WIDTH 80: CLS : END

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


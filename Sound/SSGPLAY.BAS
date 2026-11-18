DEFINT A-Y
DEFLNG Z
DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DECLARE SUB sbreset (bp%)
SCREEN 12
' SBlaster Port usually &h220 ... bp%
CLS : PRINT : COLOR 1
DIM k(600) AS INTEGER: k = 45
PRINT "  SNGPlayer v1.0 Written by: DICEMAN for compressed tronix .SNG music files."
COLOR 9
PRINT "          For use only with Sound Blaster or compatable sound cards"
COLOR 11
PRINT "           This is an UNREGISTERED version copyright TRONiX '1995": PRINT
COLOR 4
INPUT "Name of sound file to play (DICE.SNG, ect.):", F$: IF F$ = "" THEN GOTO 300
INPUT "Enter your card's base port (220 = H220 - default):", bp$: IF bp$ <> "" THEN bp% = VAL("&h" + bp$) ELSE bp% = &H220
buf = 15: INPUT "Enter your speed (0 to 1500, 0 - Fastest):", sp: IF sp < 0 OR sp > 1500 THEN sp = 0
INPUT "Do you want Visual Display (Y/N):", c$: IF UCASE$(c$) = "N" THEN k = 0
CALL sbreset(bp%) 'Reset the Soundblaster card
PRINT "Now Playing file:"; F$
CALL writedsp(&HD1, bp%)  'Turn speaker on
OPEN F$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL F$: GOTO 300
IF k > 0 THEN LINE (40, 325)-(600, 378), 5, B: PAINT (140, 340), 1, 5
IF k > 0 THEN FOR t = 1 TO 595: k(t) = (128 + 220): NEXT t
ztm = TIMER
5 FOR l = 1 TO (buf * 512)
GOSUB GetByte
IF sp > 0 THEN FOR t = 0 TO sp: NEXT t
CALL writedsp(&H12, bp%): CALL writedsp(byte, bp%)
IF k > 0 THEN
        IF lp = 0 THEN lp = 1: GOTO 7 ELSE lp = 0
        k = k + 1: PRESET (k, k(k)), 1: PRESET (k, byte + 348), 11: k(k) = byte + 348: IF k > 590 THEN k = 45
END IF
7 NEXT l: LOCATE 20, 30: PRINT USING "Time Playing: ###.##"; (TIMER - ztm)
IF INKEY$ = "" THEN GOTO 5
10 CLOSE 1: GOTO 300

GetByte:
IF A = 0 AND EOF(1) <> -1 THEN A = 1: r$ = INPUT$(buf * 1024, 1): DEF SEG = VARSEG(r$): zad = SADD(r$) ELSE IF A = 0 AND EOF(1) = -1 THEN GOTO 10
zy = zy + 1: byte = PEEK(zad + zy - 1)
IF zy >= LEN(r$) THEN A = 0: zy = 0
110 RETURN

300 CALL writedsp(&HD3, bp%)   'Turn speaker off
SCREEN 0: WIDTH 80: CLS : COLOR 7, 0: PRINT "Thanks for using SNGPlay v1.0 TRONiX '94": END

DEFSNG A-Z
FUNCTION samplebyte% (bp%)
CALL writedsp(&H20, bp%) 'Command to sample one byte
samplebyte% = INP(datread%)
END FUNCTION

SUB sbreset (bp%)

'Resets the Soundblaster chip -
'call with bp% = Base Port (normally &h220)

dspreset% = bp% + 6
OUT dspreset%, 1
FOR t% = 1 TO 10
        A% = INP(dspreset%)  'Delay loop, give SB time to reset
NEXT t%
OUT dspreset%, 0
dspread% = bp% + 10
FOR t% = 1 TO 10
        A% = INP(dspread%)
NEXT t%

END SUB

SUB writedsp (byte%, bp%)
OUT (bp% + 12), byte%
END SUB


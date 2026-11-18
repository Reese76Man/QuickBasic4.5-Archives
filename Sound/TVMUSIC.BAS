DEFINT A-Y
DEFLNG Z
DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DECLARE SUB sbreset (bp%)
SCREEN 12
' SBlaster Port usually &h220 ... bp%
CLS : PRINT : COLOR 1
nte$ = "abcdefgabcdefghabcdefghiabcdefghijabcdefghijkabcdefghijklabcdefghijklm"
DIM k(500) AS INTEGER: k = 135: ll = 250: pp = 10
INPUT "Enter your card's base port (220 = H220 - default):", bp$: IF bp$ <> "" THEN bp% = VAL("&h" + bp$) ELSE bp% = &H220
INPUT "Enter your speed (0 to 1500, 0 - Fastest):", sp: IF sp < 0 OR sp > 1500 THEN sp = 0
CALL sbreset(bp%) 'Reset the Soundblaster card
CALL writedsp(&HD1, bp%)  'Turn speaker on
LINE (130, 215)-(450, 478), 5, B: PAINT (140, 220), 1, 5
FOR t = 1 TO 500: k(t) = (128 + 220): NEXT t
5 FOR l = 1 TO (1024)
GOSUB GetByte
IF sp > 0 THEN FOR t = 0 TO sp: NEXT t
CALL writedsp(&H10, bp%): CALL writedsp(byte, bp%)
k = k + 1: PRESET (k, k(k)), 1: PRESET (k, byte + 220), 11: k(k) = byte + 220: IF k > 445 THEN k = 135
6 NEXT l
IF INKEY$ = "" THEN GOTO 5
10 CLOSE 1: GOTO 300

GetByte:
nn = nn + 1: IF nn > LEN(nte$) THEN nn = 1
byte = ASC(MID$(nte$, nn, 1))
110 RETURN

300 CALL writedsp(&HD3, bp%)   'Turn speaker off
SCREEN 0: WIDTH 80: CLS : COLOR 7, 0: PRINT "Thanks for using UNISOUND v1.0 TRONiX '94": END

DEFSNG A-Z
FUNCTION samplebyte% (bp%)

'Samples a byte from the SB's ADC, and returns
'the resultant byte.  Call with BP% = SB base port
'(normally &h220)


CALL writedsp(&H20, bp%) 'Command to sample one byte
datavail% = bp% + 14
dly:
        IF INP(datavail%) AND &H80 = 0 THEN GOTO dly
datread% = bp% + 10
bt% = INP(datread%)
samplebyte% = bt%

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
'dspcmd% = bp% + 12
'FOR t% = 1 TO 8
'        q% = INP(dspcmd%) 'Delay to give SB time to process code
'NEXT t%

OUT (bp% + 12), byte%
END SUB


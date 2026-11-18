DEFINT A-Y
DEFLNG Z
DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DECLARE SUB sbreset (bp%)


bf = 128 - 80
FOR u = 1 TO 100 STEP 1
IF u > 0 THEN t = 0
IF u > 5 THEN t = 1
IF u > 10 THEN t = 1
IF u > 15 THEN t = 1
IF u > 20 THEN t = 2
IF u > 25 THEN t = 3
IF u > 30 THEN t = 2
IF u > 35 THEN t = 2
IF u > 40 THEN t = 1
IF u > 45 THEN t = 0
IF u > 100 THEN t = 0
IF u > 105 THEN t = 0
IF u > 110 THEN t = 1
IF u > 115 THEN t = 2
IF u > 120 THEN t = 3
IF u > 125 THEN t = 3
IF u > 130 THEN t = 2
IF u > 135 THEN t = 1
IF u > 140 THEN t = 1
IF u > 145 THEN t = 0

FOR p = 1 TO 2
IF u < 99 THEN bf = bf + t ELSE bf = bf - t: IF bf < 1 THEN bf = 15
IF bf > 255 THEN bf = 240
NEXT p
nte$ = nte$ + CHR$(bf): NEXT u
ll = 250: pp = 10: bp% = &H220

CALL sbreset(bp%) 'Reset the Soundblaster card
CALL writedsp(&HD1, bp%)  'Turn speaker on

5 FOR l = 1 TO (12288)

nn = nn + 1: IF nn > LEN(nte$) THEN nn = 1
byte = ASC(MID$(nte$, nn, 1))

CALL writedsp(&H10, bp%): CALL writedsp(byte, bp%)
NEXT l

CALL writedsp(&HD3, bp%)  'Turn speaker off
END

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
dspcmd% = bp% + 12
FOR t% = 1 TO 12
        q% = INP(dspcmd%) 'Delay to give SB time to process code
NEXT t%

OUT (bp% + 12), byte%
END SUB


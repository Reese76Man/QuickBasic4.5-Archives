DEFINT A-Y
DEFLNG W
DEFDBL Z
DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DECLARE SUB sbreset (bp%)
IF bp% = 0 THEN bp% = &H220
DIM k(500) AS INTEGER: k = 135: FOR t = 1 TO 500: k(t) = (220 + 128): NEXT t
CALL sbreset(bp%) 'Reset the Soundblaster card
2 SCREEN 12: WIDTH 80, 60: CLS : PRINT
OUT bp% + 4, &HC: t = INP(bp% + 5)
COLOR 4: PRINT SPC(23); "TRONiX Developer's WAVEFORM v1.0": PRINT : COLOR 12
PRINT SPC(20); " Written by DICEMAN aka Corey Badeaux": PRINT : COLOR 6
COLOR 4: PRINT SPC(16); "Currently recieving input from the "; : COLOR 12
p$ = "All."
IF t = 25 OR t = 17 THEN p$ = "MICROPHONE."
IF t = 31 OR t = 23 THEN p$ = "LINE IN."
IF t = 27 OR t = 19 THEN p$ = "CD PLAYER."
PRINT p$
LINE (130, 215)-(450, 478), 5, B: PAINT (140, 220), 1, 5: COLOR 2: PRINT

5 zy = TIMER + 2: u = 1: cnt = 0
6 byte = samplebyte(bp%)
  IF byte > 135 AND u = 1 THEN u = 2: cnt = cnt + 1
  IF byte < 115 AND u = 2 THEN u = 1: cnt = cnt + 1
  k = k + 1: PRESET (k, k(k)), 1
  PRESET (k, byte + 220), 11
  k(k) = byte + 220: IF k > 445 THEN k = 135
IF zy > TIMER THEN GOTO 6

LOCATE 11, 15: PRINT USING "Hertz:######.##"; cnt / 2 / 2
13 p$ = UCASE$(INKEY$): IF p$ <> "Q" THEN GOTO 5
15 CALL writedsp(&HD3, bp%)  'Turn speaker off
SCREEN 0

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
OUT bp% + 12, byte%
END SUB


DEFINT A-Y
DEFLNG Z
DEFDBL H
DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DECLARE SUB sbreset (bp%)
ON ERROR GOTO 290
f$ = COMMAND$: IF f$ = "" THEN GOTO 290
SCREEN 13: CLS : PRINT : COLOR 128
DIM k(500) AS INTEGER: k = 9: bp% = &H220
h = TIMER: FOR z2 = 1 TO 6000: t = INT(RND(t / 2)): NEXT z2: ht = TIMER - h: sp = 150 / ht
1 OUT &H3C7, 0: r = 0: g = 5: b = 10
FOR t = 0 TO 63: r = t
OUT &H3C9, r: OUT &H3C9, g: OUT &H3C9, b
OUT &H3C9, r: OUT &H3C9, g: OUT &H3C9, b
NEXT t
FOR t = 0 TO 63: r = 63 - t
OUT &H3C9, r: OUT &H3C9, g: OUT &H3C9, b
OUT &H3C9, r: OUT &H3C9, g: OUT &H3C9, b
NEXT t: y = y + 1: IF y = 6 THEN y = 0
LINE (256, 0)-(256, 200), 128: LINE (256, 8)-(1, 8), 128
LINE (256, 199)-(0, 199), 128
PAINT (1, 1), 35, 128: LOCATE 1, 1: PRINT SPACE$(40)
LOCATE 1, 1: PRINT "SB-Demo * Tronix * DICEMAN * C. Badeaux"
CALL sbreset(bp%): CALL writedsp(&HD1, bp%) 'Reset card & speaker ON
OPEN f$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL f$: GOTO 290
5 FOR l = 1 TO 12288: GOSUB GetByte
FOR t = 0 TO sp: NEXT t
CALL writedsp(&H12, bp%): CALL writedsp(byte, bp%)
k = k + 1: PRESET (k(k), k), 35: PRESET (byte, k), byte: k(k) = byte: IF k > 197 THEN k = 9
6 NEXT l
IF INKEY$ = "" THEN GOTO 5
10 CLOSE 1: GOTO 300

GetByte:
100 IF a = 0 AND EOF(1) <> -1 THEN a = 1: r$ = INPUT$(12288, 1): DEF SEG = VARSEG(r$): zad = SADD(r$) ELSE IF a = 0 AND EOF(1) = -1 THEN SEEK #1, 40: GOTO 100
zy = zy + 1: byte = PEEK(zad + zy - 1)
IF zy >= LEN(r$) THEN a = 0: zy = 0
110 RETURN
290 SCREEN 0: WIDTH 80: CLS : COLOR 7, 0
PRINT "SBDEMO <Soundfile>"
PRINT "Soundfile can be any 8-bit/8000Hz .VOC or .WAV file."
PRINT : END
300 CALL writedsp(&HD3, bp%)   'Turn speaker off
SCREEN 0: WIDTH 80: CLS : COLOR 7, 0: PRINT "Thanks for running SBDEMO * TRONiX '95": END

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
        a% = INP(dspreset%)  'Delay loop, give SB time to reset
NEXT t%
OUT dspreset%, 0
dspread% = bp% + 10
FOR t% = 1 TO 10
        a% = INP(dspread%)
NEXT t%

END SUB

SUB writedsp (byte%, bp%)
OUT (bp% + 12), byte%
FOR t% = 1 TO 20
        a% = INP(bp% + 12) 'Delay loop, give SB time to reset
NEXT t%
END SUB


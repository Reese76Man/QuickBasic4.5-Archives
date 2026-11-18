DEFINT A-X
DEFLNG Z
DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DECLARE SUB sbreset (bp%)
SCREEN 12
' SBlaster Port usually &h220 ... bp%
CLS : PRINT : COLOR 1
DIM k(500) AS INTEGER: k = 135
PRINT "      UNISOUND v1.0 Written by: DICEMAN for .VOC or .WAV sound files."
COLOR 9
PRINT "         For use only with Sound Blaster or compatable sound cards"
COLOR 11
PRINT "               This is a test copy Copyright TRONiX '1994": PRINT
COLOR 4
INPUT "Name of sound file to play (DICE.VOC, DICE.WAV, ect.):", f$: IF f$ = "" THEN GOTO 300
INPUT "Enter your card's base port (220 = H220 - default):", bp$: IF bp$ <> "" THEN bp% = VAL("&h" + bp$) ELSE bp% = &H220
buf = 10: INPUT "Enter your speed (0-1500,0=Fast):", sp: IF sp < 0 OR sp > 1500 THEN sp = 0
INPUT "Is sound file in 16-bit mode(Y/N):", c$: IF UCASE$(c$) = "Y" THEN bit = 16: PRINT "Make sure you set the rate of input to an EVEN number!"
INPUT "Enter rate of input (1-10, 1 - Best Quality):", sp2: IF sp2 < 1 OR sp2 > 10 THEN sp2 = 1
INPUT "Do you want Visual Display (Y/N):", c$: IF UCASE$(c$) = "N" THEN k = 0
CALL sbreset(bp%) 'Reset the Soundblaster card
PRINT "Now Playing file:"; f$
CALL writedsp(&HD1, bp%)  'Turn speaker on
OPEN f$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL f$: GOTO 300
IF k > 0 THEN LINE (130, 215)-(450, 478), 5, B: PAINT (140, 220), 1, 5
IF k > 0 THEN FOR t = 1 TO 500: k(t) = (128 + 220): NEXT t
ytm = TIMER: GOTO 6
5 yt = TIMER - ytm: yps = LOC(1): yhz = yps / yt: ypc = yps / LOF(1) * 100
LOCATE 13, 13: PRINT "Playing at"; INT(yhz); "HZ  File %"; INT(ypc); " played.  Time:"; INT(yt)
6 FOR l = 1 TO (buf * 512)
GOSUB GetByte
IF sp > 0 THEN FOR t = 0 TO sp: NEXT t
IF bit = 16 THEN byte = byte + 128: IF byte > 255 THEN byte = byte - 255
CALL writedsp(&H12, bp%): CALL writedsp(byte, bp%)
IF k > 0 THEN
        IF lp = 0 THEN lp = 1: GOTO 7 ELSE lp = 0
        k = k + 1: PRESET (k, k(k)), 1: PRESET (k, byte + 220), 11: k(k) = byte + 220: IF k > 445 THEN k = 135
END IF
7 NEXT l
IF INKEY$ = "" THEN GOTO 5
10 CLOSE 1: GOTO 300

GetByte:
IF a = 0 AND EOF(1) <> -1 THEN a = 1: r$ = INPUT$(buf * 1024, 1): DEF SEG = VARSEG(r$): zad = SADD(r$) ELSE IF a = 0 AND EOF(1) = -1 THEN GOTO 10
zy = zy + sp2: byte = PEEK(zad + zy - 1)
IF zy >= LEN(r$) THEN a = 0: zy = 0
110 RETURN

300 CALL writedsp(&HD3, bp%)   'Turn speaker off
SCREEN 0: WIDTH 80: CLS : COLOR 7, 0: PRINT "Thanks for using UNISOUND v1.0 TRONiX '94": END

DEFSNG A-X, Z
FUNCTION samplebyte% (bp%)
DEFINT A-Z
CALL writedsp(&H20, bp%) 'Command to sample one byte
samplebyte% = INP(datread%)
END FUNCTION

DEFSNG A-Z
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
DEFINT A-Z
OUT (bp% + 12), byte%
FOR mn = 1 TO 18: ml = INP(bp% + 12): NEXT mn
END SUB


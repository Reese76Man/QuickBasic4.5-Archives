DEFINT A-Z
DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DECLARE SUB sbreset (bp%)
SCREEN 12: ' SBlaster Port usually &h220 ... bp%
CLS : PRINT : COLOR 1
DIM k(500) AS INTEGER: k = 135: max = 28000: spd1 = 25: spd2 = 25
DIM m(28000) AS INTEGER
bp% = &H220
PRINT "                    SoundSampler Plus v1.0 By: DICEMAN": COLOR 9
PRINT "         For use only with Sound Blaster or compatable sound cards": COLOR 11
PRINT "                This is a test copy Copyright TRONiX '1995": PRINT : COLOR 12
CALL sbreset(bp%) 'Reset the Soundblaster card
LINE (130, 215)-(450, 478), 5, B: PAINT (140, 220), 1, 5
FOR t = 1 TO 500: k(t) = (128 + 220): NEXT t
PRINT SPC(3); "<R>ecord  <P>layback  <T>est input <S>et Playback Speed Sa<V>e sample"
PRINT SPC(3); "      S<E>t Record Speed  <A>mplify sound <L>oad sample <Q>uit"
2 GOSUB 100
LOCATE 1, 1: PRINT "STATUS   PlaySpeed:"; spd2; "  RecordSpeed:"; spd1
3 q$ = UCASE$(INKEY$)
IF q$ = "L" THEN GOTO 50
IF q$ = "V" THEN GOTO 60
IF q$ = "S" THEN GOTO 20
IF q$ = "E" THEN GOTO 30
IF q$ = "Q" THEN GOTO 300
IF q$ = "T" THEN GOTO 10
IF q$ = "R" THEN GOTO 4
IF q$ = "P" THEN GOTO 6
IF q$ = "A" THEN GOTO 40
GOTO 3
4 GOSUB 100: LOCATE 1, 1: PRINT "RECORDING SAMPLE"
FOR t = 1 TO max: m(t) = samplebyte%(bp%): byte = m(t): FOR y = 0 TO spd1: NEXT y
k = k + 1: PRESET (k, k(k)), 1: PRESET (k, byte + 220), 11: k(k) = byte + 220: IF k > 445 THEN k = 135
NEXT t: GOTO 2
6 GOSUB 100: LOCATE 1, 1: PRINT "PLAYING SAMPLE": mr = 1: mr = spd2 / 10
CALL writedsp(&HD1, bp%)
FOR t = 1 TO max: byte = m(t): FOR y = 0 TO spd2 + mr: NEXT y
CALL writedsp(&H12, bp%): CALL writedsp(byte, bp%)
k = k + 1: PRESET (k, k(k)), 1: PRESET (k, byte + 220), 11: k(k) = byte + 220: IF k > 445 THEN k = 135
NEXT t: CALL writedsp(&HD3, bp%)  'Turn speaker off
GOTO 2
10 GOSUB 100: LOCATE 1, 1: PRINT "TESTING INPUT"
11 q$ = INKEY$
FOR t = 1 TO 1024: byte = samplebyte%(bp%)
k = k + 1: PRESET (k, k(k)), 1: PRESET (k, byte + 220), 11: k(k) = byte + 220: IF k > 445 THEN k = 135
NEXT t
IF q$ <> "" THEN GOTO 2 ELSE GOTO 11

20 GOSUB 100
   LOCATE 1, 1: PRINT "Old Speed:"; spd2; : INPUT "  New Speed:", spd2
   IF spd2 < 0 OR spd2 > 1500 THEN GOTO 20
   GOTO 2
30 GOSUB 100
   LOCATE 1, 1: PRINT "Old Speed:"; spd1; : INPUT "  New Speed:", spd1
   IF spd1 < 0 OR spd1 > 1500 THEN GOTO 30
   GOTO 2
40 GOSUB 100
   LOCATE 1, 1: PRINT "AMPLIFYING RECORDED SAMPLE": y = 1
   FOR t = 1 TO max: byte = m(t)
   y = y + 1: IF y = 1024 THEN LOCATE 1, 30: PRINT "ON BYTE:"; t: y = 1
   IF byte < 127 THEN lk = 1: byte = 255 - byte
   IF byte > 127 THEN l = (byte - 128) * 2: byte = 128 + l
   IF lk = 1 THEN lk = 0: byte = 255 - byte
41 IF byte < 0 THEN byte = 0 ELSE IF byte > 255 THEN byte = 255
   m(t) = byte: NEXT t: GOTO 2
50 GOSUB 100: LOCATE 1, 1: INPUT "Enter TVF to load:", q$: t = 0
   IF q$ = "" THEN GOTO 2
   OPEN q$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL q$: GOTO 2
52 d$ = INPUT$(1024, 1): FOR y = 1 TO LEN(d$): t = t + 1: m(t) = ASC(MID$(d$, y, 1))
   NEXT y: IF EOF(1) <> 0 THEN GOTO 55 ELSE GOTO 52
55 CLOSE 1: GOTO 2
60 GOSUB 100: LOCATE 1, 1: INPUT "Enter TVF to save:", q$
   IF q$ = "" THEN GOTO 2 ELSE OPEN q$ FOR BINARY AS 1: y = 0
   FOR t = 1 TO max: y = y + 1: d$ = d$ + CHR$(m(t))
   IF y = 1024 THEN y = 0: PUT #1, , d$: d$ = ""
   NEXT t: IF y > 0 THEN PUT #1, , d$: d$ = ""
   CLOSE 1: GOTO 2
100 LOCATE 1, 1: PRINT "                                                                    ": RETURN
300 CALL writedsp(&HD3, bp%)               'Turn speaker off
SCREEN 0: WIDTH 80: CLS : COLOR 7, 0: PRINT "Thanks for using SoundSampler v1.0 TRONiX '95": END

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
FOR t% = 1 TO 8
        A% = INP(bp% + 12)'Delay loop, give SB time to reset
NEXT t%
END SUB


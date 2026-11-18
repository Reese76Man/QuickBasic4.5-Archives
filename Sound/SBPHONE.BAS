DEFINT A-Z
DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DECLARE SUB sbreset (bp%)
SCREEN 12: ' SBlaster Port usually &h220 ... bp%
CLS : PRINT : COLOR 1
DIM k(500) AS INTEGER: k = 135: tm = 30
DIM i$(12)
IF bp$ <> "" THEN bp% = VAL("&h" + bp$) ELSE bp% = &H220
PRINT "                    SoundBlaster Phone v1.0 By: DICEMAN": COLOR 9
PRINT "         For use only with Sound Blaster or compatable sound cards": COLOR 11
PRINT "               This is a test copy Copyright TRONiX '1995": PRINT : COLOR 12
PRINT SPC(28); " <1> | <2> | <3> "
PRINT SPC(28); " <4> | <5> | <6> "
PRINT SPC(28); " <7> | <8> | <9> "
PRINT SPC(28); " <*> | <0> | <#> "
PRINT SPC(28); " <R>edial/<Q>uit "
OPEN "all.dat" FOR BINARY AS 1
FOR t = 1 TO 12: i$(t) = INPUT$(2000, 1): NEXT t: CLOSE 1
CALL sbreset(bp%) 'Reset the Soundblaster card
CALL writedsp(&HD1, bp%)  'Turn speaker on
LINE (130, 215)-(450, 478), 5, B: PAINT (140, 220), 1, 5
FOR t = 1 TO 500: k(t) = (128 + 220): NEXT t
5 q$ = UCASE$(INKEY$): IF q$ = "" THEN GOTO 5
IF VAL(q$) > 0 THEN l = VAL(q$): GOTO 10
IF q$ = "0" THEN l = 10: GOTO 10
IF q$ = "*" THEN l = 11: GOTO 10
IF q$ = "#" THEN l = 12: GOTO 10
IF q$ = "=" THEN tm = tm + 1
IF q$ = "-" THEN tm = tm - 1
'IF q$ = "R" THEN GOTO 15
IF q$ <> "Q" THEN GOTO 5 ELSE GOTO 300
10 FOR t = 33 TO 500: byte = ASC(MID$(i$(l), t, 1))
CALL writedsp(&H12, bp%): CALL writedsp(byte, bp%)
FOR p = 1 TO tm: NEXT p
'k = k + 1: PRESET (k, k(k)), 1: PRESET (k, byte + 220), 11: k(k) = byte + 220: IF k > 445 THEN k = 135
NEXT t: IF INKEY$ <> "" THEN GOTO 10 ELSE GOTO 5
300 CALL writedsp(&HD3, bp%)   'Turn speaker off
SCREEN 0: WIDTH 80: CLS : COLOR 7, 0: PRINT "Thanks for using SBPHONE v1.0 TRONiX '95": END

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


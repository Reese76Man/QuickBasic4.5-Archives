DEFINT A-Y
DEFLNG W
DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DECLARE SUB sbreset (bp%)
IF INSTR(COMMAND$, "?") > 0 THEN GOTO 50
IF INSTR(COMMAND$, "/T") > 0 OR COMMAND$ = "" THEN bp% = &H220 ELSE bp% = VAL("&H" + COMMAND$)
IF bp% = 0 THEN bp% = &H220
DIM k(500) AS INTEGER: k = 135: FOR t = 1 TO 500: k(t) = (220 + 128): NEXT t
IF INSTR(COMMAND$, "/T") > 0 THEN GOTO 500
CALL sbreset(bp%) 'Reset the Soundblaster card
2 SCREEN 12: WIDTH 80, 60: CLS : PRINT
OUT bp% + 4, &HC: t = INP(bp% + 5)
COLOR 4: PRINT SPC(23); "TRONiX Developer's WAVEFORM v1.0": PRINT : COLOR 12
PRINT SPC(20); " Written by DICEMAN aka Corey Badeaux": PRINT : COLOR 6
PRINT "Use SBP-MIX.EXE on SB-PRO to change the ADC input to CD-PLAYER, LINE IN, or MIC."
PRINT "Your sound card may have to be Sound Blaster compatable to work. If you do have"
PRINT "one and still get no response, use the '?' modifier for help. - DICEMAN"
COLOR 4: PRINT SPC(16); "Currently recieving input from the "; : COLOR 12
p$ = "UNKNOWN."
IF t = 25 OR t = 17 THEN p$ = "MICROPHONE."
IF t = 31 OR t = 23 THEN p$ = "LINE IN."
IF t = 27 OR t = 19 THEN p$ = "CD PLAYER."
PRINT p$
LINE (130, 215)-(450, 478), 5, B: PAINT (140, 220), 1, 5: COLOR 2: PRINT
PRINT SPC(21); "Now Showing...Here are some options:": COLOR 10
PRINT SPC(22); "Press 'D' for DISTORTION wave mode": COLOR 3
PRINT SPC(22); "Press 'F' for FILLED wave mode": COLOR 11
PRINT SPC(22); "Press 'S' for SHORT wave mode": COLOR 9
PRINT SPC(22); "Press 'X' for XTRA-DISTORTION wave mode": COLOR 1
PRINT SPC(22); "Press 'W' for WIDE wave mode": COLOR 5
PRINT SPC(22); "Press 'B' for BOX wave mode": COLOR 4
PRINT SPC(22); "Press 'H' for HORIZONTAL wave mode": COLOR 12
PRINT SPC(22); "Press 'T' for TEXT wave mode": COLOR 6
PRINT SPC(22); "Press 'Q' to Quit to DOS"
5  FOR t = 1 TO 2048
back: bbyte = byte
byte = samplebyte(bp%)
IF byte = bbyte THEN GOTO back:
IF kk = 0 THEN GOTO 7 ELSE IF kk = 2 THEN GOTO 8 ELSE IF kk = 3 THEN GOTO 91 ELSE IF kk = 4 THEN GOTO 101 ELSE IF kk = 5 THEN GOTO 108 ELSE IF kk = 6 THEN GOTO 118
l = l + 1: IF l < 450 THEN GOTO 10 ELSE l = 0
IF k = 135 THEN k = 136: p$ = "S": GOTO 11
k = k + 1: LINE (k, 220)-(k, 475), 1: GOTO 10

8 k = k + 2: LINE (k, k(k))-(k + 2, k(k + 2)), 1
9 IF k > 137 THEN LINE (k, byte + 220)-(k - 2, k(k - 2)), 11
GOTO 12

91 k = k + 1: LINE (k, k(k))-(k + 1, k(k) + 1), 1 AND byte, BF
92 LINE (k, byte + 220)-(k + 1, byte + 221), 11, BF
GOTO 12

101 k = k + 1: gt = 252 - (k(k) - 220): LINE (k, k(k))-(k, gt + 220), 1
102 gt = 252 - byte: LINE (k, 220 + byte)-(k, 220 + gt), 11
GOTO 12

108 k = k + 1: ll = k(k) - 220
    LINE (290 - (ll - 126), k(k))-(290 + (ll - 126), k(k)), 1
    LINE (164 + ll, 346 - (ll - 126))-(164 + ll, 346 + (ll - 126)), 1
109 LINE (290 - (byte - 126), 220 + byte)-(290 + (byte - 126), byte + 220), 11
    LINE (164 + byte, 346 - (byte - 126))-(164 + byte, 346 + (byte - 126)), 11
GOTO 12

118 k = k + 4: IF k < 445 THEN LINE (k, 126 + 220)-(k + 4, k(k + 4)), 1, B
119 IF k > 139 AND k < 445 THEN LINE (k, 126 + 220)-(k - 4, byte + 220), 11, B
GOTO 12

7 k = k + 1: PRESET (k, k(k)), 1
10 PRESET (k, byte + 220), 11

12 k(k) = byte + 220
IF kk <> 1 THEN
        IF byte > 127 THEN
                wol = wol + (byte - 128)
        ELSE
                wol = wol + ((255 - byte) - 128)
        END IF
END IF
qwe = qwe + 1
IF qwe = 250 THEN
        wol = wol / 75: IF wol > 260 THEN wol = 260
        LINE (500, 475 - 270)-(510, 475 - wol), 0, BF
        LINE (500, 475)-(510, 475 - wol), 6, BF: wol = 0
        qwe = 0
END IF

IF k > 445 THEN
        k = 135: ll = 126: zm = zm + 1
        IF ztm < TIMER THEN
                ztm = TIMER + 1:
                LOCATE 25, 33: PRINT USING "FPS:###"; zm
                LOCATE 25, 61: PRINT "VOLUME"
                zm = 0
        END IF
END IF
13 NEXT t: p$ = UCASE$(INKEY$)
11 IF p$ <> "T" AND p$ <> "H" AND p$ <> "B" AND p$ <> "Q" AND p$ <> "S" AND p$ <> "D" AND p$ <> "F" AND p$ <> "X" AND p$ <> "W" THEN GOTO 5
IF p$ = "S" THEN kk = 1: k = 136 ELSE IF p$ = "D" THEN kk = 0
IF p$ = "F" THEN kk = 2: k = 137
IF p$ = "X" THEN kk = 3: k = 136
IF p$ = "W" THEN kk = 4: k = 136
IF p$ = "B" THEN kk = 5: k = 137: ll = 126
IF p$ = "H" THEN kk = 6: k = 139
IF p$ = "T" THEN GOTO 500
FOR t = 0 TO 256: LINE (132, t + 220)-(449, t + 220), 1: NEXT t: zm = 0: ztm = TIMER + 1
IF p$ = "Q" THEN GOTO 15
GOTO 5
15 CALL writedsp(&HD3, bp%)  'Turn speaker off
SCREEN 0
20 WIDTH 80, 25: COLOR 7, 0
PRINT : PRINT "Thanks for using WAVEFORM v1.0  Written by DICEMAN  TRONiX Developers 1994": PRINT : END

50 CLS : PRINT : PRINT "            TRONiX Developer's WAVEFORM v1.0 Written by DICEMAN"
PRINT "                             USAGE WAVE [HEX$] /[T]"
PRINT "[HEX$] - This is where you put your card's PORT address. Default is 220 HEX."
PRINT "/[T]   - Automatically jumps to TEXTMODE for those without VGA support."
PRINT : END

500 CLS : WIDTH 80, 50: FOR t = 1 TO 80: k(t) = 24: NEXT t
COLOR 4: PRINT "อออออออออออออออออออออออTRONiX Developer's WAVEFORM v1.0อออออออออออออออออออออออออ"
LOCATE 48: PRINT "ออออออออออออออออออออออออออออWritten by: DICEMANออออออออออออออออออออออออออออออออ": COLOR 11

505 FOR t = 1 TO 80: byte = (samplebyte(bp%) * .175) + 2
LOCATE k(t), t: PRINT " "
LOCATE byte, t: PRINT "Û"
k(t) = byte: NEXT t: IF INKEY$ = "" THEN GOTO 505
IF p$ <> "T" THEN CLS : GOTO 20 ELSE GOTO 2

DEFSNG A-Y
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


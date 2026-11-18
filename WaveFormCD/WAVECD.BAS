REM $DYNAMIC
REM $INCLUDE: '.\ACDKIT.BI'
DEFINT A-Y
DEFLNG W, Z
DECLARE FUNCTION samplebyte% (bp%)
DECLARE SUB writedsp (byte%, bp%)
DECLARE SUB sbreset (bp%)
DECLARE SUB mouse (ax, bx, cx, dx)
DECLARE SUB gettext (x, y, t$, stp)
DECLARE FUNCTION TimeStr$ (mins%, secs%)
      
CONST false% = 0
CONST TRUE% = NOT false%

        DIM SHARED tracklist(5) AS trackinfo     ' music track information array
        DIM SHARED cd AS cdInfoTYPE              ' track info
        DIM SHARED cddrive AS INTEGER            ' first cdrom drive
        DIM SHARED curTrack AS INTEGER           ' current track number
        DIM cids(1 TO 170) AS STRING * 14
        DIM prg(1 TO 170) AS INTEGER
        DIM wol(15)
       
        IF INSTR(COMMAND$, "?") > 0 THEN GOTO 50
        IF COMMAND$ = "" THEN bp% = &H220 ELSE bp% = VAL("&H" + COMMAND$): IF bp% = 0 THEN bp% = &H220
        OPEN "cd.dat" FOR BINARY AS 1
        p$ = INPUT$(10, 1): tmr3 = VAL(RIGHT$(p$, 6))
        CLOSE 1
GOTO passd:
son:
        ready = 255
passd:
        FOR t = 1 TO 170: cids(t) = STRING$(14, "-"): NEXT t
        cd.track = 1: SCREEN 12: WIDTH 80, 60: CLS
        cdbms = 0: cdtb = 0: cid$ = ""
        IF IsSB = false THEN
                sb = 0
        ELSE
                sb = 1
        END IF

        IF IsMscdex = false THEN
                cdon = 0
                COLOR 4: LOCATE 26, 1: PRINT "No CD-ROM."
        ELSE
                cddrive% = GetFirstCdrom%                 ' get the first cdrom drive
                dummy% = cdMediaChanged(cddrive%)        ' clear changed flag
                cdInit cddrive%, tracklist()             ' read cd information
                cdon = 1: COLOR 4
                LOCATE 26, 3: PRINT "CD Player"
                LOCATE 28, 1: PRINT "Status:"
                LOCATE 30, 4: PRINT "CD Total"
                LOCATE 37, 3: PRINT "Track Time:"
                LOCATE 32, 3: PRINT "Current CD"
                LOCATE 35, 1: PRINT "Location:"
                LOCATE 40, 1: COLOR 3: PRINT "Title & Band"
                LOCATE 44, 1: PRINT "Current Song"
                COLOR 11: LOCATE 50, 1: PRINT "1)Title of CD"
                PRINT "2)Name of Band"
                PRINT "3)Current Song"
                PRINT "8)Full Editor"
                PRINT "A)Save Data"
                PRINT "J)Jump Tracks"
        END IF
        LOCATE 48, 1: PRINT "Other Options:": LOCATE 56, 1
        PRINT "M)Help File"
        PRINT "Y)FPS Set:"
        PRINT "R):          :"
ops$ = "DXQWSFBCTMY{[]}EG": tmr = 0
REDIM k2(640) AS INTEGER
REDIM k3(640) AS INTEGER
REDIM k4(640) AS INTEGER
REDIM k5(640) AS INTEGER
REDIM k6(640) AS INTEGER
REDIM k7(640) AS INTEGER
REDIM k8(640) AS INTEGER
REDIM k9(640) AS INTEGER
REDIM k(640) AS INTEGER
k = 135: FOR t = 1 TO 500: k(t) = (220 + 128): NEXT t
RANDOMIZE TIMER
CALL sbreset(bp%) 'Reset the Soundblaster card
2 LOCATE 2, 1: cx = 1: dx = 1: OUT bp% + 4, &HC: t = INP(bp% + 5)
COLOR 4: PRINT SPC(20); "TRONiX Developer's WAVEFORM v1.5": COLOR 12
PRINT SPC(17); " Written by DICEMAN aka Corey Badeaux": COLOR 6
COLOR 4: PRINT SPC(15); "Currently recieving input from "; : COLOR 12
p$ = "UNKNOWN/ALL."
IF t = 25 OR t = 17 THEN p$ = "MICROPHONE."
IF t = 31 OR t = 23 THEN p$ = "LINE IN."
IF t = 27 OR t = 19 THEN p$ = "CD PLAYER."
PRINT p$
LINE (130, 215)-(450, 478), 5, B: PAINT (140, 220), 1, 5: COLOR 2: PRINT
LOCATE 6, 8: PRINT "Wave Control Options:"
LOCATE 6, 48: PRINT "CD-Music Control Options": COLOR 14
LOCATE 7, 1
PRINT : PRINT SPC(2); " T - Full Screen Mode": COLOR 10
PRINT : PRINT SPC(2); " D - DISTORTION wave mode": COLOR 3
PRINT : PRINT SPC(2); " S - SHORT wave mode": COLOR 11
PRINT : PRINT SPC(2); " F - FILLED wave mode": COLOR 9
PRINT : PRINT SPC(2); " X - EXTRA-DISTORTION wave mode": COLOR 1
PRINT : PRINT SPC(2); " W - WIDE wave mode": COLOR 5
PRINT : PRINT SPC(2); " B - BOX wave mode": COLOR 4
PRINT : PRINT SPC(2); " C - CIRCLE wave mode": COLOR 12
PRINT : PRINT SPC(2); " Q - Quit to DOS"
LOCATE 58, 4
IF rp = 0 THEN PRINT "OPTION OFF"
IF rp = 1 THEN PRINT "REPEAT SNG"
IF rp = 2 THEN PRINT "REPEAT ALL"
IF rp = 3 THEN PRINT " SHUFFLE  "
IF rp = 4 THEN PRINT "PROGRAM CD"
COLOR 15: LOCATE 10 + (kk * 2), 1: PRINT ">": kb = kk * 2
CALL mouse(1, 0, 0, 0): CALL mouse(4, 0, 0, 0)
LINE (10, 55)-(20, 65), 14, BF
LINE (10, 71)-(20, 81), 10, BF
LINE (10, 87)-(20, 97), 3, BF
LINE (10, 103)-(20, 113), 11, BF
LINE (10, 119)-(20, 129), 9, BF
LINE (10, 135)-(20, 145), 1, BF
LINE (10, 151)-(20, 161), 4, BF
LINE (10, 167)-(20, 177), 4, BF
LINE (10, 183)-(20, 193), 12, BF

LINE (10, 55)-(20, 65), 7, B
LINE (10, 71)-(20, 81), 7, B
LINE (10, 87)-(20, 97), 7, B
LINE (10, 103)-(20, 113), 7, B
LINE (10, 119)-(20, 129), 7, B
LINE (10, 135)-(20, 145), 7, B
LINE (10, 151)-(20, 161), 7, B
LINE (10, 167)-(20, 177), 7, B
LINE (10, 183)-(20, 193), 7, B
LINE (0, 197)-(640, 197), 7
LINE (285, 197)-(285, 52), 7
LINE (0, 52)-(640, 52), 7
LINE (465, 197)-(465, 480), 7
LINE (113, 197)-(113, 480), 7

LINE (501, 476)-(513, 475 - 256), 4, B

x = 300: y = 62: GOSUB tri
x = 295: y = 86: GOSUB tri
x = 305: y = 86: GOSUB tri
x = 300: y = 110: GOSUB tri2
x = 310: y = 110: GOSUB tri2
COLOR 10:  LOCATE 9, 41: PRINT "P - Play Track       ) - Foreward 15 sec"
COLOR 3:  LOCATE 12, 41: PRINT "+ - Next Track       ( - Rewind 15 secs "
COLOR 11: LOCATE 15, 41: PRINT "- - Last Track       > - Raise CD Volume"
COLOR 9:  LOCATE 18, 41: PRINT "/ - Stop Play        < - Lower CD Volume"
COLOR 1:  LOCATE 21, 41: PRINT "Z - Pause Play       ] - Raise SB Volume"
COLOR 5:  LOCATE 24, 41: PRINT "O - Opn/Cls Door     [ - Lower SB Volume"
COLOR 7
LOCATE 24, 38:  PRINT "=="
LOCATE 9, 58: PRINT "::>"
LOCATE 12, 58: PRINT "<::"
LOCATE 15, 58: PRINT "*>>"
LOCATE 18, 58: PRINT "<<*"
LOCATE 21, 58: PRINT "*))"
LOCATE 24, 58: PRINT "((*"

 COLOR 2: LOCATE 26, 29: PRINT "Waveform"
 LOCATE 26, 67: PRINT "VOLUMES"
 LOCATE 27, 61: PRINT "  OUT    CD    SB"

wol = 255: FOR t = 28 TO 58 STEP 3
LOCATE t, 60: PRINT USING "###"; wol: wol = wol - 25
NEXT t: wol = 0

FOR y = 59 TO 179 STEP 24: x = 290: GOSUB box: NEXT y
FOR y = 59 TO 179 STEP 24: x = 455: GOSUB box: NEXT y
x = 295: y = 134: GOSUB ibox
x = 300: y = 134: GOSUB ibox
x = 305: y = 134: GOSUB ibox
x = 295: y = 158: GOSUB ibox
x = 305: y = 158: GOSUB ibox: rbyte = 128

IF cdon = 1 AND ready <> 255 THEN cdSetVolume cddrive%, 255, 255, 255, 255: cdv% = 255
sbGetVolume 1, sbv%, sbv%
sbSetVolume 1, sbv%, sbv%
 
LINE (554, 476)-(566, 475 - 256), 4, B
IF cdon = 1 THEN
        wol = cdv%
        LINE (555, 475 - 255)-(565, 475 - wol), 1, BF
        LINE (555, 475)-(565, 475 - wol), 6, BF
END IF

wol = sbv% * 17: ready = 0: bbyte = -1
LINE (602, 476)-(614, 475 - 256), 4, B
LINE (603, 475 - 255)-(613, 475 - wol), 1, BF
LINE (603, 475)-(613, 475 - wol), 6, BF: wol = 0

5 FOR t = 1 TO 2225
'bbyte = byte
'bbc:
byte = samplebyte(bp%)
'IF byte = bbyte THEN GOTO bbc:

IF sb = 0 THEN
        IF rbyte < 85 THEN rbyte = 85 ELSE IF rbyte > 165 THEN rbyte = 165
        byte = rbyte + INT(RND * 20) - 9.5: rbyte = byte
END IF
IF kk = 0 THEN GOTO 7 ELSE IF kk = 2 THEN GOTO 8 ELSE IF kk = 3 THEN GOTO 91 ELSE IF kk = 4 THEN GOTO 101 ELSE IF kk = 5 THEN GOTO 108 ELSE IF kk = 6 THEN GOTO 118 ELSE IF kk = 7 THEN GOTO 120 ELSE IF kk = 8 THEN GOTO 125
l = l + 1: IF l < 250 THEN GOTO 10 ELSE l = 0
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

108 k = k + 1: LL = k(k) - 220
    LINE (290 - (LL - 126), k(k))-(290 + (LL - 126), k(k)), 0
    LINE (164 + LL, 346 - (LL - 126))-(164 + LL, 346 + (LL - 126)), 0
109 LINE (290 - (byte - 126), 220 + byte)-(290 + (byte - 126), byte + 220), 13
    LINE (164 + byte, 346 - (byte - 126))-(164 + byte, 346 + (byte - 126)), 14
    GOTO 12

118 k = k + 1
    IF (k / 100) = INT(k / 100) THEN
    IF byte < 128 THEN byte = 255 - byte
    byte = byte - 128

    byte2! = byte / 3
    kk2! = (k(k) - 220) / 3
    byte! = byte / 1000
    kk! = (k(k) - 220) / 1000
    CIRCLE (287, 220 + 128), 128, 0, , , .01 + (kk! * 8)
    CIRCLE (287, 220 + 128), 128, 15, , , .01 + (byte! * 8)

    IF (k(k) - 220) < 129 AND byte < 129 THEN
        CIRCLE (287, 220 + 128), k(k) - 220, 1
        CIRCLE (287, 220 + 128), byte, 15
    END IF
       
    CIRCLE (287, 220 + 128), 128, 0, , , 20 - kk2!
    CIRCLE (287, 220 + 128), 128, 15, , , 20 - byte2!
    END IF
GOTO 12

120 k = k + 1
    LINE (136, 340)-(290, k(k)), 1
    LINE (444, 348)-(290, k(k)), 1
    LINE (136, 221)-(290, k(k)), 1
    LINE (136, 475)-(290, k(k)), 1
    LINE (444, 221)-(290, k(k)), 1
    LINE (444, 475)-(290, k(k)), 1
   
    LINE (136, 340)-(290, byte + 220), 2
    LINE (444, 348)-(290, byte + 220), 10
    LINE (136, 221)-(290, byte + 220), 12
    LINE (136, 475)-(290, byte + 220), 4
    LINE (444, 221)-(290, byte + 220), 13
    LINE (444, 475)-(290, byte + 220), 9

GOTO 12

125 k = k + 1
    LINE (136, 340)-(290, k(k)), 1, B
    LINE (444, 348)-(290, k(k)), 1, B
    LINE (136, 340)-(290, byte + 220), 2, B
    LINE (444, 348)-(290, byte + 220), 10, B
GOTO 12


7 k = k + 1: PRESET (k, k(k)), 1
10 PRESET (k, byte + 220), 11

12 k(k) = byte + 220
FOR tmr2 = 0 TO tmr: NEXT tmr2
IF kk <> 1 THEN
        'IF ABS(bytef - byte) > 5 AND byte <> 127 THEN wol = wol + ABS(bytef - byte) * 2
        'IF ABS(bytef - byte) <= 10 AND byte <> 127 THEN wol = wol + (11 - ABS(bytef - byte)) * 5
        'bytef = byte
        IF byte > 127 THEN
                wol = wol + (byte - 128)
        ELSE
                wol = wol + ((255 - byte) - 128)
        END IF
END IF
qwe = qwe + 1
IF qwe = 445 THEN
        CALL mouse(3, bx, cx, dx)
        IF cx > 197 THEN CALL mouse(4, 0, 197, dx)
        COLOR 12: LOCATE 57, 11: PRINT tmr3
IF cdon = 1 THEN
                cdGetInfo cddrive%, 0, cd, tracklist()
                COLOR 12: LOCATE 28, 8: cdin = 1
                IF (cd.status AND CDPAUSED) = CDPAUSED THEN
                        PRINT "PAUSED "
                        IF ready = 0 THEN ready = 1: cdInit cddrive%, tracklist(): cdtb = 0
                ELSE
                        IF (cd.status AND CDPLAYING) = CDPLAYING THEN
                          PRINT "PLAYING"
                          IF ready = 0 THEN ready = 1: cdInit cddrive%, tracklist(): cdtb = 0
                        ELSE
                                IF IsAudio(cddrive) = false THEN
                                        PRINT "NO CD  ": cdin = 0: ready = 0: zm5 = 0: cd.track = 1
                                ELSE
                                        PRINT "READY  "
                                        IF ready = 0 THEN ready = 1: cdInit cddrive%, tracklist(): cdtb = 0: cd.track = 1
                                END IF
                        END IF
                END IF
      IF cdbms <> cd.cdMins + cd.cdSecs THEN LOCATE 31, 1: PRINT "Time:"; TimeStr$(cd.cdMins, cd.cdSecs): cdbms = cd.cdMins + cd.cdSecs
      IF cdtb <> cd.track THEN LOCATE 33, 1: PRINT USING "Track:##"; cd.track; : PRINT USING " of ##"; UBOUND(tracklist): cdtb = cd.track
      COLOR 11: LOCATE 45, 1: PRINT LEFT$(cids(cdtb + 2), 14): COLOR 12
      LOCATE 35, 10: PRINT TimeStr$(cd.cdmin, cd.cdsec)
      LOCATE 1, 25: PRINT DATE$; " | "; TIME$
      COLOR 12: LOCATE 38, 1: PRINT TimeStr$(cd.trackmin, cd.tracksec); " of "; TimeStr$(cd.trackmins, cd.tracksecs)
       
        bcid$ = cid$: IF ready = 1 THEN cid$ = LTRIM$(STR$(UBOUND(tracklist))) + ":" + TimeStr$(cd.cdMins, cd.cdSecs) + ":" + LTRIM$(STR$(cd.cdFrames))
        IF ready = 0 THEN
            FOR ti = 1 TO 170: cids(ti) = STRING$(14, "-"): prg(ti) = 0: NEXT ti
            COLOR 11: LOCATE 41, 1: PRINT LEFT$(cids(1), 14)
            LOCATE 42, 1: PRINT LEFT$(cids(2), 14): cid$ = ""
        END IF
        IF bcid$ <> cid$ THEN
            FOR ti = 1 TO 170: cids(ti) = STRING$(14, "-"): prg(ti) = 0: NEXT ti
            OPEN "CD.PRG" FOR INPUT AS 5: pr$ = "NONE." + SPACE$(30)
lk3:        LINE INPUT #5, p$
            IF LEFT$(p$, LEN(cid$)) = cid$ THEN pr$ = RIGHT$(p$, LEN(p$) - LEN(cid$) - 3)
            IF EOF(5) = 0 THEN GOTO lk3:
            CLOSE 5
            IF VAL(pr$) > 0 THEN
                ti2 = 0: p$ = ""
                FOR ti = 1 TO LEN(pr$)
                p$ = p$ + MID$(pr$, ti, 1)
                IF MID$(pr$, ti, 1) = "," THEN ti2 = ti2 + 1: prg(ti2) = VAL(p$): p$ = ""
                NEXT ti
            END IF
           OPEN "CD.DAT" FOR INPUT AS 1: ti2 = 0: zm5 = 0
cdb:         LINE INPUT #1, tid$
             IF LEFT$(tid$, LEN(cid$)) = LEFT$(cid$, LEN(cid$)) THEN
                 t = 0: GOSUB getit:
             ELSE
                 IF EOF(1) = 0 THEN GOTO cdb:
             END IF
            COLOR 11
            LOCATE 41, 1: PRINT LEFT$(cids(1), 14)
            LOCATE 42, 1: PRINT LEFT$(cids(2), 14)
            CLOSE 1
        END IF
END IF
        IF bx = 1 THEN
                IF dx >= 290 AND dx <= 314 THEN
                        IF cx >= 59 AND cx <= 59 + 16 THEN p$ = "*P"
                        IF cx >= 82 AND cx <= 82 + 16 THEN p$ = "*+"
                        IF cx >= 106 AND cx <= 106 + 16 THEN p$ = "*-"
                        IF cx >= 131 AND cx <= 131 + 16 THEN p$ = "*/"
                        IF cx >= 154 AND cx <= 154 + 16 THEN p$ = "*Z"
                        IF cx >= 179 AND cx <= 179 + 16 THEN p$ = "*O"
                END IF
                IF dx >= 454 AND dx <= 479 THEN
                        IF cx >= 59 AND cx <= 59 + 16 THEN p$ = "*)"
                        IF cx >= 82 AND cx <= 82 + 16 THEN p$ = "*("
                        IF cx >= 106 AND cx <= 106 + 16 THEN p$ = "*."
                        IF cx >= 131 AND cx <= 131 + 16 THEN p$ = "*,"
                        IF cx >= 154 AND cx <= 154 + 16 THEN p$ = "*]"
                        IF cx >= 179 AND cx <= 179 + 16 THEN p$ = "*["
                END IF
       
                IF dx > 9 AND dx < 21 THEN
                        IF cx >= 54 AND cx <= 54 + 11 THEN p$ = "*T"
                        IF cx >= 70 AND cx <= 70 + 11 THEN p$ = "*D"
                        IF cx >= 86 AND cx <= 86 + 11 THEN p$ = "*S"
                        IF cx >= 103 AND cx <= 103 + 11 THEN p$ = "*F"
                        IF cx >= 118 AND cx <= 118 + 11 THEN p$ = "*X"
                        IF cx >= 135 AND cx <= 135 + 11 THEN p$ = "*W"
                        IF cx >= 150 AND cx <= 150 + 11 THEN p$ = "*B"
                        IF cx >= 166 AND cx <= 166 + 11 THEN p$ = "*C"
                        IF cx >= 182 AND cx <= 182 + 11 THEN p$ = "*Q"
                END IF
        END IF
        wol = wol / 110: IF sb = 0 THEN LOCATE 28, 31: PRINT "No Sound Card": LOCATE 29, 31: PRINT "  Detected.  "
        IF wol > 255 THEN wol = 255
                wolf = 0: FOR ti = (tmr3 / 11) TO 1 STEP -1
                wolf = wolf + wol(ti)
                NEXT ti: wolf = wolf / (tmr3 / 11)

                LINE (502, 475 - 255)-(512, 475 - wolf), 1, BF
                LINE (502, 475)-(512, 475 - wolf), 6, BF
                FOR ti = (tmr3 / 11) TO 2 STEP -1: wol(ti) = wol(ti - 1): NEXT ti
                wol(1) = wol
        qwe = 0
END IF
IF k > 445 THEN
        k = 135: LL = 126: zm = zm + 1
        IF ztm < TIMER THEN
                ztm = TIMER + 1
                COLOR 2: LOCATE 26, 38: PRINT USING "FPS:###"; zm
                IF zm < tmr3 - 2 AND tmr > 0 THEN tmr = tmr - 75
                IF zm > tmr3 + 2 THEN tmr = tmr + 150
                zm = 0
        END IF
END IF
13 NEXT t: IF LEFT$(p$, 1) = "*" THEN p$ = RIGHT$(p$, 1) ELSE p$ = UCASE$(INKEY$)
11 IF cdon = 1 THEN
        IF rp > 0 THEN
                ' BUG FIX 10/17/1998 LST NGHT I MD LV 2 KASIA - CMB
                'IF cd.trackmin = cd.trackmins THEN
                        IF (cd.trackmin * 60) + cd.tracksec = (cd.trackmins * 60) + cd.tracksecs - 5 THEN zm5 = TIMER + 4
                'END IF
                IF zm5 <> 0 AND zm5 <= TIMER THEN
                                zm5 = 0
                                IF rp = 1 THEN p$ = "P"
                                IF rp = 2 AND cd.track = UBOUND(tracklist) THEN cdPlay cddrive%, 1, 99, tracklist()
                                IF rp = 3 THEN
rpb:                                  rp = INT(RND * UBOUND(tracklist) + 1): IF rp = cd.track THEN GOTO rpb:
                                      cdPlay cddrive%, rp, 99, tracklist(): rp = 3
                                END IF
                                IF rp = 4 THEN
rpb2:                                   ti3 = ti3 + 1: rp = prg(ti3)
                                        IF rp = 0 THEN ti3 = 1: rp = prg(ti3)
                                        cdPlay cddrive%, rp, 99, tracklist(): rp = 4
                                END IF
                        END IF
                
        END IF
        IF (p$ = "+" OR p$ = "=") AND cdin = 1 THEN
                   cd.track = cd.track MOD UBOUND(tracklist) + 1
                   p$ = "P"
        END IF
        IF (p$ = "-" OR p$ = "_") AND cdin = 1 THEN
                   cd.track = cd.track - 1
                   IF cd.track = 0 THEN cd.track = UBOUND(tracklist)
                   p$ = "P"
        END IF
        IF p$ = "P" AND cdin = 1 THEN
                IF rp = 3 THEN p$ = "": GOTO rpb:
                IF rp = 4 THEN p$ = "": ti3 = 0: zm5 = 0: GOTO rpb2:
                cdInit cddrive%, tracklist()             ' read cd information
                cdPlay cddrive%, cd.track, 160, tracklist(): p$ = ""
        END IF
        IF (p$ = "," OR p$ = "<") THEN
            cdv% = cdv% - 10: IF cdv% < 1 THEN cdv% = 0
            cdSetVolume cddrive%, cdv%, cdv%, cdv%, cdv%
            LINE (555, 475 - 255)-(565, 475 - cdv%), 1, BF
            LINE (555, 475)-(565, 475 - cdv%), 6, BF
        END IF
        IF (p$ = "." OR p$ = ">") THEN
            cdv% = cdv% + 10: IF cdv% > 254 THEN cdv% = 255
            cdSetVolume cddrive%, cdv%, cdv%, cdv%, cdv%
            LINE (555, 475 - 255)-(565, 475 - cdv%), 1, BF
            LINE (555, 475)-(565, 475 - cdv%), 6, BF
        END IF
       
        IF (p$ = "9" OR p$ = "(") AND cdin = 1 THEN
            cdpause (cddrive%)
            cdPlayMSF cddrive%, cd.cdmin, cd.cdsec - 15, 1, cd.cdMins, cd.cdSecs, 2
        END IF
        IF (p$ = ")" OR p$ = "0") AND cdin = 1 THEN
            cdpause (cddrive%)
            cdPlayMSF cddrive%, cd.cdmin, cd.cdsec + 15, 1, cd.cdMins, cd.cdSecs, 2
        END IF
        IF p$ = "Z" AND cdin = 1 THEN IF (cd.status AND CDPAUSED) = CDPAUSED THEN cdresume cddrive% ELSE cdpause cddrive%
        IF p$ = "/" AND cdin = 1 THEN Cdstop cddrive%
        IF p$ = "O" THEN IF (cd.status AND CDOPEN) = CDOPEN THEN cdDoor cddrive%, 2 ELSE Cdstop cddrive%: cdDoor cddrive%, 1
        IF p$ = "1" THEN LOCATE 41, 1: PRINT SPACE$(14): COLOR 11: gettext 45, 1, tmp$, 14: cids(1) = tmp$: tmp$ = ""
        IF p$ = "2" THEN LOCATE 42, 1: PRINT SPACE$(14): COLOR 11: gettext 46, 1, tmp$, 14: cids(2) = tmp$: tmp$ = ""
        IF p$ = "3" THEN LOCATE 45, 1: PRINT SPACE$(14): COLOR 11: gettext 49, 1, tmp$, 14: cids(cdtb + 2) = tmp$: tmp$ = ""
        IF p$ = "J" THEN jm$ = " Jump to track: ": gettext 26, 29, jm$, 3: COLOR 2: LOCATE 26, 29: PRINT "Waveform             ": IF VAL(jm$) > 0 AND VAL(jm$) <= UBOUND(tracklist) THEN cd.track = VAL(jm$): cdPlay cddrive%, cd.track, 99, tracklist()
        IF p$ = "8" THEN GOTO 4000
        IF p$ = "R" THEN
                rp = rp + 1: IF rp = 5 THEN rp = 0
                LOCATE 58, 4: COLOR 12
                IF rp = 0 THEN PRINT "OPTION OFF"
                IF rp = 1 THEN PRINT "REPEAT SNG"
                IF rp = 2 THEN PRINT "REPEAT ALL"
                IF rp = 3 THEN PRINT " SHUFFLE  "
                IF rp = 4 THEN
                       IF prg(1) > 0 THEN PRINT "PROGRAM CD" ELSE rp = 0: PRINT "OPTION OFF"
                END IF
        END IF
        IF p$ = "A" THEN GOSUB saveit:
END IF
IF INSTR(ops$, p$) = 0 OR p$ = "" THEN GOTO 5
IF p$ = "T" THEN GOTO 500
IF p$ = "S" THEN kk = 1: k = 136
IF p$ = "D" THEN kk = 0
IF p$ = "F" THEN kk = 2: k = 137
IF p$ = "X" THEN kk = 3: k = 136
IF p$ = "W" THEN kk = 4: k = 136
IF p$ = "B" THEN kk = 5: k = 137: LL = 126
IF p$ = "C" THEN kk = 6: k = 139
IF p$ = "E" THEN kk = 7: k = 136
IF p$ = "G" THEN kk = 8: k = 136
IF p$ = "Y" THEN jm$ = "   FPS Setting: ": gettext 26, 29, jm$, 3: COLOR 2: LOCATE 26, 29: PRINT "Waveform             ": IF VAL(jm$) > 10 AND VAL(jm$) <= 100 THEN tmr3 = VAL(jm$)
IF p$ = "M" THEN SCREEN 0: WIDTH 80, 25: SHELL "tv wavecd.txt": GOTO son:
        IF (p$ = "[" OR p$ = "{") THEN
            sbv% = sbv% - 1: IF sbv% < 1 THEN sbv% = 0
            sbSetVolume 1, sbv%, sbv%
            LINE (603, 475 - 255)-(613, 475 - (sbv% * 17)), 1, BF
            LINE (603, 475)-(613, 475 - (sbv% * 17)), 6, BF
        END IF
        IF (p$ = "]" OR p$ = "}") THEN
            sbv% = sbv% + 1: IF sbv% > 14 THEN sbv% = 15
            sbSetVolume 1, sbv%, sbv%
            LINE (603, 475 - 255)-(613, 475 - (sbv% * 17)), 1, BF
            LINE (603, 475)-(613, 475 - (sbv% * 17)), 6, BF
        END IF

LINE (131, 216)-(449, 220 + 257), 1, BF
        LOCATE 10 + kb, 1: PRINT " "
        COLOR 15: LOCATE 10 + (kk * 2), 1: PRINT ">": kb = kk * 2
IF p$ = "Q" THEN GOTO 15
GOTO 5
15      CALL writedsp(&HD3, bp%)  'Turn speaker off
        CALL mouse(2, bx, cx, dx)
        SCREEN 0: WIDTH 80, 25: COLOR 7, 0: PRINT
        LOCATE 1, 1: PRINT "+"; STRING$(78, "Ä"); "+"
        FOR t = 2 TO 4: LOCATE t, 1: PRINT "³": LOCATE t, 80: PRINT "³": NEXT t
        LOCATE 2, 35: PRINT "WAVEFORM v1.5"
        LOCATE 3, 35: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄ"
        LOCATE 4, 16: PRINT "Written by Corey Badeaux   TRONiX Developers 1994-98"
        LOCATE 5, 1: PRINT "+"; STRING$(78, "Ä"); "+"
        PRINT : GOTO outahere:

50 CLS : PRINT : PRINT "            TRONiX Developer's WAVEFORM v1.5 Written by Corey Badeaux"
PRINT "                             USAGE WAVE [HEX$]"
PRINT "[HEX$] - This is where you put your card's PORT address. Default is 220 HEX."
PRINT : GOTO outahere:

tri:
LINE (x, y)-(x + 5, y + 5), 7
LINE (x + 5, y + 5)-(x, y + 10), 7
LINE (x, y + 10)-(x, y), 7
PAINT (x + 3, y + 5), 4, 7
RETURN

tri2:
LINE (x, y)-(x - 5, y + 5), 7
LINE (x - 5, y + 5)-(x, y + 10), 7
LINE (x, y + 10)-(x, y), 7
PAINT (x - 3, y + 5), 4, 7
RETURN
   
box:
LINE (x, y)-(x + 25, y + 16), 7, B
PAINT (x + 1, y + 1), 1, 7
RETURN

ibox:
LINE (x, y)-(x + 5, y + 10), 4, BF
RETURN

getit:
t = t + 1
INPUT #1, tid$: cids(t) = tid$
IF tid$ = "END" THEN cids(t) = STRING$(14, "-")
IF tid$ = "" THEN cids(t) = STRING$(14, "*")
IF tid$ <> "END" THEN GOTO getit:
cids(t + 1) = STRING$(14, "-")
RETURN

saveit:
           OPEN "cd.dat" FOR BINARY AS 1
           tid$ = "FPS:" + LTRIM$(STR$(tmr3))
           SEEK #1, 1: PUT #1, , tid$
           CLOSE 1
           OPEN "CD.DAT" FOR INPUT AS 1: tmp$ = ""
           OPEN "cd.tmp" FOR OUTPUT AS 2
cdb2:      LINE INPUT #1, tid$
           IF LEFT$(tid$, LEN(cid$)) = LEFT$(cid$, LEN(cid$)) THEN
                 PRINT #2, cid$
                 FOR t = 1 TO UBOUND(tracklist) + 2: tmp$ = tmp$ + cids(t) + ",": NEXT t
                 PRINT #2, tmp$
                 PRINT #2, "END": tmp$ = "DONE"
                 LINE INPUT #1, tid$: LINE INPUT #1, tid$
            ELSE
                  PRINT #2, tid$
            END IF
            IF EOF(1) = 0 THEN GOTO cdb2:
            IF tmp$ = "" THEN
                 PRINT #2, cid$
                 FOR t = 1 TO UBOUND(tracklist) + 2: tmp$ = tmp$ + cids(t) + ",": NEXT t
                 PRINT #2, tmp$
                 PRINT #2, "END"
            END IF
            CLOSE 1, 2: tmp$ = ""
            KILL "cd.dat"
            SHELL "ren cd.tmp cd.dat >nul"
RETURN

saveit2:
           OPEN "cd.dat" FOR BINARY AS 1
           tid$ = "FPS:" + LTRIM$(STR$(tmr3))
           SEEK #1, 1: PUT #1, , tid$
           CLOSE 1
           OPEN "CD.PRG" FOR INPUT AS 5: vt = 0
            OPEN "cd.tmp" FOR OUTPUT AS 2
lk2:        LINE INPUT #5, p$
            IF LEFT$(p$, LEN(cid$)) = cid$ THEN p$ = cid$ + "   " + pr$: vt = 1
            PRINT #2, p$
            IF EOF(5) = 0 THEN GOTO lk2:
            IF vt = 0 THEN p$ = cid$ + "  " + pr$: PRINT #2, p$
            CLOSE 5, 2: KILL "cd.prg": SHELL "ren cd.tmp cd.prg >nul"
          
           OPEN "CD.DAT" FOR INPUT AS 1: tmp$ = ""
           OPEN "cd.tmp" FOR OUTPUT AS 2
cdb2a:      LINE INPUT #1, tid$
            IF LEFT$(tid$, LEN(cid$)) = LEFT$(cid$, LEN(cid$)) THEN
                 PRINT #2, cid$
                 FOR ti = 1 TO t - 2: tmp$ = tmp$ + cids(ti) + ",": NEXT ti
                 PRINT #2, tmp$
                 PRINT #2, "END": tmp$ = "DONE"
                 LINE INPUT #1, tid$: LINE INPUT #1, tid$
            ELSE
                  PRINT #2, tid$
            END IF
            IF EOF(1) = 0 THEN GOTO cdb2a:
            IF tmp$ = "" THEN
                 PRINT #2, cid$
                 FOR t = 1 TO UBOUND(tracklist) + 2: tmp$ = tmp$ + cids(t) + ",": NEXT t
                 PRINT #2, tmp$
                 PRINT #2, "END"
            END IF
            CLOSE 1, 2: tmp$ = ""
            KILL "cd.dat"
            SHELL "ren cd.tmp cd.dat >nul"
RETURN

4000       plce = 0
bckf:      CLS : COLOR 3: LOCATE 1, 27: PRINT "CD Detection Editor"
           LOCATE 2, 27: PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
           
rep5:      OPEN "CD.DAT" FOR INPUT AS 1: cntr = 0
           FOR ti = 1 TO 162: cids(ti) = STRING$(14, "-"): NEXT ti
cdb3:      LINE INPUT #1, tid$
            IF VAL(tid$) > 0 AND LEN(tid$) < 80 THEN
                cntr = cntr + 1
                IF cntr = plce THEN cid$ = tid$: t = 0: GOSUB getit:
                 IF plce = 0 AND LEFT$(tid$, LEN(cid$)) = LEFT$(cid$, LEN(cid$)) THEN
                        plce = cntr
                        t = 0: GOSUB getit:
                END IF
                
            ELSE
                IF EOF(1) = 0 THEN LINE INPUT #1, p$
            END IF
            IF EOF(1) = 0 THEN GOTO cdb3:  ELSE CLOSE 1
            IF plce = 0 AND ready = 0 THEN plce = 1: GOTO rep5:
            IF plce = 0 THEN plce = cntr + 1: cntr = cntr + 1: t = UBOUND(tracklist) + 2
            OPEN "CD.PRG" FOR INPUT AS 5: pr$ = "NONE." + SPACE$(30)
lk:         LINE INPUT #5, p$
            IF LEFT$(p$, LEN(cid$)) = cid$ THEN pr$ = RIGHT$(p$, LEN(p$) - LEN(cid$) - 3)
            IF EOF(5) = 0 THEN GOTO lk:
            CLOSE 5
rep:        COLOR 11: LOCATE 3, 28: PRINT "On CD"; plce; "out of"; cntr
            LOCATE 5, 1: PRINT "(A) Title of CD :"; cids(1)
            LOCATE 7, 1: PRINT "(B) Album Artist:"; cids(2)
            LOCATE 9, 1: PRINT "(C) Select Track :"
            LOCATE 11, 1: PRINT "(S) Save to Disk"
            LOCATE 13, 1: PRINT SPACE$(80)
            LOCATE 13, 1: PRINT "(P)rogram Order:"; pr$
            LOCATE 9, 39: PRINT "(Q) Quit to Main"
            LOCATE 5, 39: PRINT "(+/-) Choose CD to Edit"
            LOCATE 7, 39: PRINT "(V) View all CD Titles & Artist"
            LOCATE 11, 39: PRINT "CD's I.D.:"; cid$; "     "
           
            xi = 0: yi = 1: FOR ti = 3 TO 162
            IF xi = 40 THEN xi = 0: yi = yi + 19
            xi = xi + 1: COLOR 2: LOCATE xi + 15, yi: PRINT USING "###)"; (ti - 2); : COLOR 12: PRINT cids(ti)
            NEXT ti

bck5:       p$ = UCASE$(INKEY$)
            IF p$ = "V" THEN
                OPEN "cd.dat" FOR INPUT AS 1: vt = 0
                OPEN "cd.lst" FOR BINARY AS 2: CLOSE 2: KILL "cd.lst"
                OPEN "cd.lst" FOR OUTPUT AS 2
                all$ = "CD No.  |   Title of CD    |   Artist/Band    |  WAVEFORM 1.5 CD-List"
                PRINT #2, all$
                all$ = "------------------------------------------------------------------"
                PRINT #2, all$
bckv:           LINE INPUT #1, tid$
                IF VAL(tid$) > 0 THEN
                        
                        vt = vt + 1: all$ = ""
                        INPUT #1, ttle$: ttle$ = LEFT$(ttle$ + SPACE$(15), 14)
                        INPUT #1, arts$: arts$ = LEFT$(arts$ + SPACE$(15), 14)
                        IF vt < 100 THEN all$ = "0"
                        IF vt < 10 THEN all$ = all$ + "0"
                        all$ = all$ + LTRIM$(STR$(vt)) + ")       " + ttle$ + "     " + arts$ + "     Tracks:" + LTRIM$(STR$(VAL(tid$)))
                        PRINT #2, all$
                        LINE INPUT #1, tid$
                END IF
                IF EOF(1) = 0 THEN GOTO bckv:
                CLOSE 1, 2: SCREEN 0: WIDTH 80, 25: SHELL "tv cd.lst"
                SCREEN 12: WIDTH 80, 60: GOTO bckf:
            END IF
            IF p$ = "Q" THEN GOTO son:
            IF p$ = "S" THEN GOSUB saveit2:
            IF p$ = "P" THEN
                pr$ = ""
PRG2:           LOCATE 14, 20: PRINT SPACE$(30)
                p$ = "Enter one at a time, leave blank to end:": gettext 14, 1, p$, 3
                IF VAL(p$) > 0 THEN pr$ = pr$ + p$ + ",": GOTO PRG2:
                LOCATE 14, 1: PRINT SPACE$(75)
                pr$ = pr$ + "END.": GOTO rep:
            END IF
            IF p$ = "C" THEN
                   p$ = "": gettext 9, 20, p$, 3: ti = VAL(p$)
                   IF ti > 0 AND ti < t - 3 THEN
                        ti = ti + 2
                        p$ = "NEW:": COLOR 11
                        LOCATE 14, 10: PRINT "OLD:"; cids(ti)
                        gettext 14, 40, p$, 14: cids(ti) = p$
                    END IF
                    LOCATE 14, 1: PRINT SPACE$(79): LOCATE 9, 20: PRINT "         "
                    GOTO rep:
             END IF
            IF p$ = "A" THEN
                        ti = 1
                        p$ = "NEW:": COLOR 11
                        LOCATE 14, 10: PRINT "OLD:"; cids(ti)
                        gettext 14, 40, p$, 14: cids(ti) = p$
                    LOCATE 14, 1: PRINT SPACE$(79): LOCATE 9, 20: PRINT "         "
                    GOTO rep:
             END IF
            IF p$ = "B" THEN
                        ti = 2
                        p$ = "NEW:": COLOR 11
                        LOCATE 14, 10: PRINT "OLD:"; cids(ti)
                        gettext 14, 40, p$, 14: cids(ti) = p$
                    LOCATE 14, 1: PRINT SPACE$(79): LOCATE 9, 20: PRINT "         "
                    GOTO rep:
             END IF
             IF p$ = "-" OR p$ = "_" THEN
                IF plce > 1 THEN plce = plce - 1: GOTO rep5:
             END IF
             IF p$ = "+" OR p$ = "=" THEN
                IF plce < cntr THEN plce = plce + 1: GOTO rep5:
             END IF
GOTO bck5:

500 CLS : WIDTH 80, 60
COLOR 4:   PRINT "ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍTRONiX Developer's WAVEFORM v1.5ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ"
th = 2
FOR t = 1 TO 640
k9(t) = 234
k8(t) = 234
k7(t) = 234
k6(t) = 234
k5(t) = 234
k4(t) = 234
k3(t) = 234
k2(t) = 234
k(t) = 234: NEXT t
505
IF cl = 1 THEN cl = 0
IF cl = 3 THEN cl = 1
IF cl = 11 THEN cl = 3
IF cl = 15 THEN cl = 11
IF cl = 0 THEN cl = 15
FOR t = 1 TO 639 STEP th * 2 + 2: byte = (samplebyte(bp%) * 1.75) + 12
LINE (t, k9(t))-(t + th, k9(t) + th), 0, BF
LINE (t, k5(t))-(t + th, k5(t) + th), 9, BF
LINE (t, byte)-(t + th, byte + th), cl, B
k9(t) = k8(t)
k8(t) = k7(t)
k7(t) = k6(t)
k6(t) = k5(t)
k5(t) = k4(t)
k4(t) = k3(t)
k3(t) = k2(t)
k2(t) = k(t)
k(t) = byte: NEXT t
IF INKEY$ = "" THEN GOTO 505 ELSE GOTO son:

outahere:
REDIM in%(7), ot%(7)         'Define input and output
FOR t = 0 TO 7: in%(t) = 0: NEXT t
in%(0) = VAL("&H4C00")
LOCATE , , 1, 7, 8
END
CALL INT86OLD(&H21, in%(), ot%())

REM $STATIC
DEFINT W, Z
SUB gettext (x, y, t$, stp)
LOCATE x, y: PRINT t$: y = y + LEN(t$): t$ = ""
getback: g$ = UCASE$(INKEY$): LOCATE x, LEN(t$) + y, 1: IF g$ = "" THEN GOTO getback:
IF ((ASC(g$) >= 32 AND ASC(g$) <= 92) OR g$ = " ") AND LEN(t$) < stp THEN t$ = t$ + g$
IF LEN(t$) > 0 AND g$ = CHR$(8) THEN t$ = LEFT$(t$, LEN(t$) - 1)
IF g$ = CHR$(13) THEN GOTO gow:
LOCATE x, y: PRINT t$; STRING$(stp - LEN(t$), " ")
GOTO getback:
gow: LOCATE , , 0
END SUB

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

DEFINT A-Z
FUNCTION TimeStr$ (mins%, secs%)

        sec = secs%

        IF sec% = 254 THEN
                sec% = 0
        END IF

        text$ = RIGHT$("00" + LTRIM$(STR$(mins%)), 2) + ":" + RIGHT$("00" + LTRIM$(STR$(sec%)), 2)

        TimeStr$ = text$

END FUNCTION

DEFSNG A-Z
SUB writedsp (byte%, bp%)
OUT bp% + 12, byte%
END SUB


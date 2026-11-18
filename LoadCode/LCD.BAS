DEFINT A-Y
DEFSNG Z
COLOR 9, 0: c$ = CHR$(34): CLS : ON ERROR GOTO 290
cr$ = CHR$(13) + CHR$(10): L = 0: mm = 15
line$ = COMMAND$: PRINT
beg$ = c$ + "TRONiX Developers Loadcode v3.2" + c$ + cr$
2 COLOR 12: PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�": COLOR 9
PRINT "   LOADCODE v3.2 - TRONiX Developers '94": COLOR 11
PRINT " Make transferes through E-mail & Posting!"
PRINT "LOADCODE is a Tronix Production by DICEMAN!": COLOR 4
PRINT "               UNREGISTERED": COLOR 12
PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�": COLOR 9
IF line$ = "" THEN PRINT "          Use 'LOAD /?' for help.": GOTO 400
GOSUB 500: IF fl = 2 THEN g$ = "ENCODE" ELSE g$ = "DECODE"
IF sc = 0 THEN s$ = "OFF" ELSE s$ = "ON"
IF fl = 3 THEN s$ = "DETECTING"
PRINT "FILE:"; F$; "   Option:"; g$; "   Lines(if any):"; VAL(nb$); "   Spacesaver:"; s$
IF fl = 3 THEN GOTO 100
IF fl = 2 THEN GOTO 5
GOTO 400
5 a$ = "": lne = VAL(nb$)
6 IF F$ = "" THEN CLS : COLOR 7, 0: PRINT "Thanks for using LOADCODE v3.2": GOTO 400
OPEN F$ FOR BINARY AS 1: nb$ = "1": nb = 1: pl = 0
IF LOF(1) = 0 THEN CLOSE 1: KILL F$: PRINT "File does not exist!": GOTO 400
7 OPEN nb$ + F$ FOR BINARY AS 2
IF nb > 1 THEN GOTO 8
p = 0: fl$ = c$ + F$ + c$ + cr$
IF sc = 1 THEN fl$ = "*" + F$ + c$ + cr$
PUT #2, , beg$
PUT #2, , fl$
GOTO 10
8 tit$ = "LOADCODE FILE:" + F$ + " PART:" + nb$ + cr$: PUT #2, , tit$: L = 0
10 PUT #2, , c$: IF sc = 0 THEN mm = 0
11 GOSUB 900: IF EOF(1) = -1 AND plt = 1 THEN snd$ = snd$ + cr$: PUT #2, , snd$: snd$ = LTRIM$(STR$(LOF(1))) + cr$: PUT #2, , snd$: CLOSE 1: CLOSE 2: LOCATE 11, 1: PRINT "Percent done:"; 100: GOTO 300
IF a$ <> "" THEN ch = ASC(a$) ELSE ch = 0
IF ch = 32 THEN GOTO 12
IF sc = 1 AND ch >= 0 AND ch <= mm THEN ch = ch + 129: GOTO 12

IF ch >= 0 AND ch < 34 THEN now$ = CHR$(33) + CHR$(ch + 65): GOTO 13
IF ch >= 127 AND ch < 129 + mm + 1 THEN now$ = CHR$(33) + CHR$(ch - 27): GOTO 13
IF ch = 255 THEN now$ = CHR$(33) + CHR$(254): GOTO 13
12 now$ = CHR$(ch)
13 snd$ = snd$ + now$: now$ = ""
IF LEN(snd$) < 75 THEN GOTO 11
IF LEN(snd$) > 75 THEN now$ = RIGHT$(snd$, 1): snd$ = LEFT$(snd$, 75)
15 snd$ = snd$ + cr$: PUT #2, , snd$: snd$ = now$: L = L + 1
zc = INT(LOC(1) / LOF(1) * 100)
LOCATE 10, 1: PRINT "Encoding Line:"; L: PRINT "Percent done:"; zc
IF lne <> 0 AND L = lne THEN CLOSE 2: nb = nb + 1: nb$ = LTRIM$(STR$(nb)): GOTO 7
GOTO 10

50 IF EOF(1) = -1 THEN GOTO 300
PRINT "Sorry, This is not a Loadcode v3.0 file!": CLOSE 1: CLOSE 2: GOTO 400

100 REM hi there
a$ = "": w$ = "": IF F$ = "" THEN CLS : PRINT "Thanks for using LOADCODE v3.2": GOTO 400
OPEN F$ FOR BINARY AS 1
IF LOF(1) = 0 THEN CLOSE 1: KILL F$: PRINT "File does not exist!": GOTO 400
102 a$ = INPUT$(1, 1): IF a$ <> c$ AND EOF(1) <> -1 THEN GOTO 102
IF EOF(1) = -1 THEN GOTO 50
a$ = c$ + INPUT$(LEN(beg$) - 3, 1): IF LEFT$(a$, 20) <> LEFT$(beg$, 20) THEN GOTO 102
PRINT "Loading "; F$: pl = 0
103 a$ = INPUT$(1, 1): IF a$ <> c$ AND a$ <> "*" THEN GOTO 103 ELSE w$ = a$
IF w$ = "*" THEN sc = 1 ELSE sc = 0: mm = 0
IF sc = 1 THEN LOCATE 8: s$ = "ON       ": PRINT "FILE:"; F$; "   Option:"; g$; "   Lines(if any):"; VAL(nb$); "   Spacesaver:"; s$
IF sc = 0 THEN LOCATE 8: s$ = "OFF      ": PRINT "FILE:"; F$; "   Option:"; g$; "   Lines(if any):"; VAL(nb$); "   Spacesaver:"; s$
105 a$ = INPUT$(1, 1): w$ = w$ + a$: IF a$ <> c$ THEN GOTO 105
w$ = LEFT$(w$, LEN(w$) - 1): w$ = RIGHT$(w$, LEN(w$) - 1)
OPEN w$ FOR BINARY AS 2
LOCATE 10: PRINT "Writing "; w$: ON ERROR GOTO 800
108 GOSUB 900: IF EOF(1) = -1 AND plt = 1 THEN LOCATE 11, 1: PRINT "Percent:"; 100: GOTO 300
IF a$ <> c$ THEN GOTO 108
IF lp = 1 THEN lp = 0: GOTO 112
zc = INT(LOC(1) / LOF(1) * 100): LOCATE 11, 1: PRINT "Percent:"; zc
110 GOSUB 900: IF EOF(1) = -1 AND plt = 1 THEN LOCATE 11, 1: PRINT "Percent:"; 100: GOTO 300
IF a$ <> CHR$(33) AND a$ <> CHR$(13) THEN
IF a$ >= CHR$(129) AND a$ <= CHR$(129 + mm) THEN
        IF sc = 1 THEN a$ = CHR$(ASC(a$) - 129)
END IF
        PUT #2, , a$: GOTO 110
END IF
IF a$ = CHR$(13) THEN GOTO 108
112 GOSUB 900: ch = ASC(a$): IF EOF(1) = -1 AND plt = 1 THEN LOCATE 11, 1: PRINT "Percent:"; 100: GOTO 300
IF ch = 13 THEN lp = 1: GOTO 108
IF ch < 99 THEN ch = ch - 65: GOTO 114
IF ch > 99 AND ch < 102 + mm + 1 THEN ch = ch + 27: GOTO 114
IF ch = 254 THEN ch = 255: GOTO 114
114 a$ = CHR$(ch): PUT #2, , a$
115 GOTO 110

290 IF EOF(1) <> -1 THEN PRINT "Error occured during file opening. Check file."
CLOSE 1: CLOSE 2: GOTO 400
300 PRINT "End " + g$ + ".": CLOSE 1: CLOSE 2
400 COLOR 7, 0: END

500 FOR t = 1 TO LEN(line$): q$ = MID$(line$, t, 1)
IF q$ <> "/" AND fl = 0 THEN GOTO 510
IF q$ = "/" THEN fl = 1
IF fl = 1 AND q$ = "?" THEN fl = 0: GOTO 600
IF fl = 1 AND q$ = "E" THEN fl = 2
IF fl = 1 AND q$ = "D" THEN fl = 3
IF fl = 1 AND q$ = "S" THEN fl = 1: sc = 1
IF fl = 1 AND q$ = "L" THEN dl = fl: fl = 4
IF fl = 4 AND q$ = ":" THEN fl = 5
IF fl = 5 AND q$ >= "0" AND q$ <= "9" THEN nb$ = nb$ + q$: fl = 6: GOTO 510
IF fl = 6 AND q$ >= "0" AND q$ <= "9" THEN nb$ = nb$ + q$: fl = 7: GOTO 510
IF fl = 7 AND q$ >= "0" AND q$ <= "9" THEN nb$ = nb$ + q$: q$ = CHR$(32)
IF fl > 4 AND fl < 8 AND q$ = CHR$(32) THEN fl = dl
IF fl = 2 OR fl = 3 THEN IF q$ = CHR$(32) THEN F$ = MID$(line$, t + 1, 16): RETURN
510 NEXT t: PRINT "Sorry, That is an invalid OPTION.": GOTO 400

600 PRINT "Usage:"
PRINT "        LOAD /[? - Help] /[S] /[L:#] /[D] /[E] [FILENAME]"
PRINT "Commands:"
PRINT "        /?       = The help screen you are on."
PRINT "        /L:#     = lines per file (Default is Continuous)"
PRINT "        /S       = Spacesaver mode (NEW for v3.2)"
PRINT "        /E       = Encode file"
PRINT "        /D       = Decode file"
PRINT "        FILENAME = File to Encode or Decode"
GOTO 400

800 PRINT "Loadcode file data corrupt. Attempting to continue.": GOTO 112

900 IF EOF(1) = -1 THEN GOTO 910
IF pl = 0 THEN cc$ = INPUT$(2048, 1)
910 pl = pl + 1: a$ = MID$(cc$, pl, 1)
IF pl = LEN(cc$) AND EOF(1) <> -1 THEN pl = 0
IF pl > LEN(cc$) THEN plt = 1 ELSE plt = 0
RETURN
 


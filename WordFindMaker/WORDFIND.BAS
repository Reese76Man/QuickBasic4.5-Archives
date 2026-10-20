DEFINT A-Z
DIM wd(100) AS STRING
DIM wu(100) AS INTEGER
DIM o$(50)
SCREEN 0: WIDTH 80, 50: CLS
dx = 20: dy = 20

start: RANDOMIZE TIMER
wrds$ = "word.bnk": IF wrds$ = "" THEN END
FOR t = 1 TO 100: wu(t) = 0: NEXT t
        LOCATE 39, 1: PRINT "STATUS: X="; dx; "  Y="; dy
        LOCATE 2, 40: PRINT "Word Bank"
        LOCATE 3, 40: PRINT "컴컴컴컴�"
        OPEN wrds$ FOR INPUT AS 1: t = 0
        bck: t = t + 1: LINE INPUT #1, a$
        wd(t) = UCASE$(a$): LOCATE t + 3, 40: PRINT wd(t)
        IF EOF(1) = 0 THEN GOTO bck:  ELSE CLOSE 1
        cnt = t: dt& = TIMER + 10

        LOCATE 1, 1: PRINT "+"; STRING$(dy, "-"); "+"
        FOR t = 1 TO dx: PRINT "|"; SPACE$(dy); "|": NEXT t
                PRINT "+"; STRING$(dy, "-"); "+"

                main:
                x = INT(RND * dx) + 2: y = INT(RND * dy) + 2
                t = INT(RND * cnt) + 1: i = INT(RND * 8) + 1
                wrd$ = "": IF TIMER > dt& THEN GOTO gne:

                IF wu(t) = 1 THEN
                        FOR u = 1 TO cnt: IF wu(u) = 0 THEN GOTO main:
                        NEXT u: GOTO gone:
                END IF

                IF i = 2 OR i = 4 OR i = 6 OR i = 8 THEN
                        FOR u = LEN(wd(t)) TO 1 STEP -1
                                wrd$ = wrd$ + MID$(wd(t), u, 1)
                        NEXT u
                ELSE
                        wrd$ = wd(t)
                END IF

                IF i = 1 OR i = 2 THEN
                        IF (y + LEN(wrd$)) > dy + 1 THEN GOTO main:
                        FOR u = 1 TO LEN(wrd$)
                                IF SCREEN(x, y + u - 1) <> 32 AND SCREEN(x, y + u - 1) <> ASC(MID$(wrd$, u, 1)) THEN GOTO main:
                        NEXT u
                        LOCATE x, y: PRINT wrd$
                END IF

                IF i = 3 OR i = 4 THEN
                        IF (x + LEN(wrd$)) > dx + 1 THEN GOTO main:
                        FOR u = 1 TO LEN(wrd$)
                                IF SCREEN(x + u - 1, y) <> 32 AND SCREEN(x + u - 1, y) <> ASC(MID$(wrd$, u, 1)) THEN GOTO main:
                        NEXT u
                        FOR u = 1 TO LEN(wrd$)
                                LOCATE x + u - 1, y: PRINT MID$(wrd$, u, 1): NEXT u
                        END IF

                        IF i = 5 OR i = 6 THEN
                                IF (x + LEN(wrd$)) > dx + 1 THEN GOTO main:
                                IF (y + LEN(wrd$)) > dy + 1 THEN GOTO main:
                                FOR u = 1 TO LEN(wrd$)
                                        IF SCREEN(x + u - 1, y + u - 1) <> 32 AND SCREEN(x + u - 1, y + u - 1) <> ASC(MID$(wrd$, u, 1)) THEN GOTO main:
                                NEXT u
                                FOR u = 1 TO LEN(wrd$)
                                        LOCATE x + u - 1, y + u - 1: PRINT MID$(wrd$, u, 1): NEXT u
                                END IF

                                IF i = 7 OR i = 8 THEN
                                        IF (x + LEN(wrd$)) > dx + 1 THEN GOTO main:
                                        IF (y + LEN(wrd$)) > dy + 1 THEN GOTO main:
                                        u2 = LEN(wrd$) + 1: FOR u = 1 TO LEN(wrd$): u2 = u2 - 1
                                        IF SCREEN(x + u - 1, y + u2 - 1) <> 32 AND SCREEN(x + u - 1, y + u2 - 1) <> ASC(MID$(wrd$, u, 1)) THEN GOTO main:
                                NEXT u
                                u2 = LEN(wrd$) + 1: FOR u = 1 TO LEN(wrd$): u2 = u2 - 1
                                LOCATE x + u - 1, y + u2 - 1: PRINT MID$(wrd$, u, 1): NEXT u
                        END IF

                        dt& = TIMER + 10
                        wu(t) = 1: GOTO main:

                        gne:
                        LOCATE 39, 1: PRINT "STATUS: Sorry, I could not fit ALL of the words in."

                        gone:
                        LOCATE 40, 1: PRINT "MENU BAR"
                        LOCATE 42, 1: PRINT "[SPACE BAR] - Re-pick random setup."
                        PRINT "        [CURSOR] - Change X/Y"
                        PRINT "        [F] - Fill in random characters."
                        PRINT "        [S] - Save Word-Find Puzzle"
                        PRINT "        [Q] - Quit to DOS"
                        gone2: t$ = UCASE$(INKEY$)
                        IF LEN(t$) > 1 THEN
                                t$ = RIGHT$(t$, 1)
                                IF t$ = "M" THEN dy = dy + 1: IF dy > 35 THEN dy = 35
                                IF t$ = "P" THEN dx = dx + 1: IF dx > 35 THEN dx = 35
                                IF t$ = "K" THEN dy = dy - 1: IF dy < 5 THEN dy = 5
                                IF t$ = "H" THEN dx = dx - 1: IF dx < 5 THEN dx = 5
                                t$ = CHR$(32)
                        END IF
                        IF t$ = CHR$(32) THEN CLS : GOTO start:
                        IF t$ = "F" THEN
                                FOR t = 2 TO dx + 1: FOR u = 2 TO dy + 1
                                        IF SCREEN(t, u) = 32 THEN LOCATE t, u: PRINT CHR$(INT(RND * 26) + 65)
                                NEXT u, t
                        END IF
                        IF t$ = "Q" THEN WIDTH 80, 25: CLS : END
                        IF t$ = "S" THEN GOTO sve:
                        GOTO gone2:

                        sve:    o$ = ""
                        FOR t = 1 TO dx + 2: FOR u = 1 TO dy + 2
                                o$(t) = o$(t) + CHR$(SCREEN(t, u)): NEXT u, t: CLS

                                FOR u = 48 TO (48 - t) STEP -1
                                        LOCATE u, 1: PRINT SPACE$(10 - LEN(o$(t)) / 2); o$(t): t = t - 1: NEXT u

                                        LOCATE 5, 29: PRINT "Word Bank"
                                        LOCATE 6, 1: PRINT "컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴"
                                        LOCATE 7, 1: FOR t = 1 TO cnt: PRINT wd(t), : NEXT t

                                        tf$ = LTRIM$(LEFT$(STR$(TIMER), LEN(STR$(TIMER)) - 3)) + ".txt"
                                        OPEN tf$ FOR OUTPUT AS 1

                                        FOR t = 1 TO 49: t$ = "": FOR u = 1 TO 80
                                                t$ = t$ + CHR$(SCREEN(t, u))
                                        NEXT u: PRINT #1, t$: NEXT t
                                        CLOSE 1: LOCATE 48, 1: PRINT "Puzzle saved as "; tf$: LOCATE 49, 1: PRINT "Press any key to continue.": tf$ = INKEY$: GOTO gone2:                                                                                
                                        REM RUN



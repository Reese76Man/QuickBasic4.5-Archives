DEFINT A-Z
DEFDBL M
ON ERROR GOTO 900
IF COMMAND$ = "" THEN cm = 9: CLS : GOTO 2
FOR t = 1 TO LEN(COMMAND$)
cd$ = MID$(COMMAND$, t, 1)
IF cd$ = "?" THEN cm = 9: CLS : GOTO 2
IF cd$ = "/" THEN cm = 5: GOTO 1
IF cd$ = CHR$(32) THEN cm = cm + 1
IF cd$ <> CHR$(32) AND cm = 5 THEN n$ = n$ + cd$
IF cd$ <> CHR$(32) AND cm = 0 THEN n$ = n$ + cd$
IF cd$ <> CHR$(32) AND cm = 1 THEN s$ = s$ + cd$
IF cd$ <> CHR$(32) AND cm = 2 THEN pw$ = pw$ + cd$
1 NEXT t: cd$ = pw$: CLS
IF cm = 5 THEN IF LEFT$(n$, 1) = "?" THEN cm = 9: GOTO 2
IF cm = 5 THEN IF LEFT$(n$, 1) = "M" THEN cm = 0: GOTO 2
IF cm > 1 AND cm < 5 THEN IF n$ = "" OR s$ = "" THEN cm = 9: GOTO 2
2 cc1 = 3: cc2 = 11: cc3 = 9: cc4 = 1
LOCATE 4, 1: COLOR cc1
PRINT "ษออออออออออออออออออออออออออออออออป"
PRINT "บ"; : COLOR cc2: PRINT "      QUICKPROTECT v2."; CHR$(0 + 48); "         "; : COLOR cc1: PRINT "บ"
PRINT "บ"; : COLOR cc3: PRINT "  FOR THE ULTIMATE PROTECTION!  "; : COLOR cc1: PRINT "บ"
PRINT "บ"; : COLOR cc4: PRINT " A "; CHR$(84); CHR$(82); CHR$(79); "NI"; CHR$(88); " PRODUCTION BY "; CHR$(68); CHR$(73); "CEM"; CHR$(65); CHR$(78); " "; : COLOR cc1: PRINT "บ"
PRINT "ศออออออออออออออออออออออออออออออออผ": PRINT
IF cm = 9 OR cm = 0 THEN PRINT "USAGE: QUICK /? /M [Infile] [Outfile] [Password]"
IF cm = 9 THEN PRINT "       /? = You are in HELP mode now."
IF cm = 9 THEN PRINT "       /M = Menu driven mode."
IF cm = 9 THEN PRINT "Password must be at least 5 characters long": GOTO 100
IF cm > 0 THEN GOTO 6
PRINT : INPUT "Enter Filename To Encrypt:", n$: IF n$ = "" THEN GOTO 100
INPUT "Enter New Encrypted Filename:", s$: IF s$ = "" THEN GOTO 100
5 INPUT "ENTER PASSWORD(At least 5 char.):", cd$: cd$ = UCASE$(cd$)
6 IF LEN(cd$) < 5 THEN GOTO 5
FOR t = 1 TO LEN(cd$): h = t
r$ = MID$(cd$, t, 1)
RANDOMIZE ASC(r$) * 100: o = INT(RND * 255) + 1
IF t > 9 THEN h = INT(RND * 9) + 1
7 IF h = 1 THEN m2 = m2 + (ASC(r$) * 200)
IF h = 2 THEN m2 = m2 + ASC(r$) * o
IF h = 3 THEN m2 = m2 / ASC(r$)
IF h = 4 THEN m2 = m2 - ASC(r$) * o ^ 2
IF h = 5 THEN m2 = m2 + ASC(r$): g3 = ASC(r$) / o
IF h = 6 THEN m2 = m2 * ASC(r$) * .25
IF h = 7 THEN m2 = m2 * ASC(r$) + ASC(r$) + 100
IF h = 8 THEN m2 = m2 - ASC(r$) * 3
IF h = 9 THEN m2 = m2 / ASC(r$) * 3
8 NEXT t: m2 = m2 + (LEN(cd$) * 2)
m2 = m2 * 100.2: m1 = m2 * 100.2 * .75
9 IF m1 > 10000000 OR m1 < -10000000 THEN m1 = m1 * .75
IF m2 > 10000000 OR m2 < -10000000 THEN m2 = m2 * .75
IF m1 < -32768 THEN m1 = m1 + 60000: GOTO 9
IF m1 > 32767 THEN m1 = m1 - 60000: GOTO 9
IF m2 < -32768 THEN m2 = m2 + 60000: GOTO 9
IF m2 > 32767 THEN m2 = m2 - 60000: GOTO 9
OPEN n$ FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL n$: GOTO 900
16 OPEN s$ FOR BINARY AS 2
IF LOF(2) <> 0 THEN CLOSE 2: KILL s$: GOTO 16
mac = TIMER
20 IF m1 > 32000 THEN m1 = m1 - 10000
IF m2 > 32000 THEN m2 = m2 - 10000
IF aa = 0 THEN aa = 1: RANDOMIZE m2: GOTO 21
IF aa = 1 THEN aa = 0: RANDOMIZE m1
21 a$ = INPUT$(1024, 1)
FOR t = 1 TO LEN(a$)
IF MID$(a$, t, 1) = "" THEN MID$(a$, t) = CHR$(0)
cn = ((RND * 500) + 1) - ASC(MID$(a$, t, 1))
IF cn < 0 THEN cn = cn + 256
IF cn > 255 THEN cn = cn - 256
25 b$ = b$ + CHR$(cn)
NEXT t
PUT #2, , b$: b$ = ""
nr = INT(RND * 100) + 1: m1 = m1 + nr: m2 = m2 + nr
pr = INT((LOF(2) / LOF(1)) * 100)
sec = INT(TIMER - mac)
LOCATE 1, 1: PRINT "Percentage done:"; pr; "%"; "  Time:"; sec
LOCATE 2, 1: PRINT "Total Bytes:"; LOF(1); "   Current Bytes:"; LOF(2); "  Bytes to go:"; LOF(1) - LOF(2)
IF EOF(1) = -1 THEN CLOSE 1: PRINT "DONE!": GOTO 100
GOTO 20

100 COLOR 7, 0: PRINT : PRINT "For info, Just E-mail DICEMAN on Any Tronix Support BBS.                "
PRINT "Registered copy has:                                                    "
PRINT "* Faster Coding Process                                                 "
PRINT "* More Command Line Features                                            "
PRINT "* Other Useful Utilitys In Package                                      "
PRINT "  Quickprotect 'The Ultimate Protection'   By: Diceman  From: TRONiX '94"
PRINT "                                                                        "
PRINT "                                                                        "
PRINT "                                                                        "
PRINT "                                                                        "
PRINT "                                                                        "
PRINT "                                                                        "
LOCATE 22, 1: PRINT
END

900 cm = 9: LOCATE 1, 1: PRINT "AN ERROR HAS OCCURRED!": GOTO 2


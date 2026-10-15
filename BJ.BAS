REM BLACKJACK v1.0 From COREY BADEAUX
5 DIM CARD(52)
10 CLS
15 COLOR 10
23 RANDOMIZE TIMER
25 PRINT : COLOR 12: REM \/TITLE SCREEN\/
29 PRINT "         ∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞"
30 PRINT "         ±±±±Blackjack v1.0±±±±"
31 PRINT "         ≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤≤": COLOR 13
40 PRINT "          Tronix Developers'95": RESTORE
   PRINT "Programmed by: Diceman aka Corey Badeaux"
45 PRINT : COLOR 9
50 PRINT "Choose:": PRINT "1.Play Blackjack!": PRINT "2.Tronix Update": PRINT "3.Exit"
60 PRINT "(1-3):"
65 q$ = INKEY$
70 IF q$ = "3" THEN COLOR 7, 0: CLS : PRINT "Thanks for playing, Tronix Developers '95, Diceman.": PRINT : END
72 IF q$ = "2" THEN GOTO 5000
75 IF q$ = "1" THEN GOTO 200
76 READ q$: IF q$ = "~" THEN RESTORE ELSE PLAY q$
80 GOTO 65: REM \/MUSIC DATA\/
90 DATA t255 o2,g,g,g,a,a#,a#,a#,>,c,<,f,f,f,a,g,g,g,,n0
92 DATA g,g,g,a,a#,a#,a#,>,c,<,f,f,f,a,g,g,g,,n0
94 DATA >,d,<,a#,>,d,d#,f,f,d#,d,c,<,a#,>,c,d,c,c,d,c,<,a#,g,a#,>,c,d,d,c,<,a#,a,g,a,a#,a,a
96 DATA a#,a,g,d#,g,a,a#,a#,a,g,f,d,f,a,a#,a#,a#,a#,g,d#,<,a#,>,g,a,f,d,a,a#,a#,a#,a#,a#,n0,n0,n0,n0,n0,n0,n0,n0
99 DATA ~
100 REM Random card picker - doesn't allow same card twice!!
110 C = INT(RND * 52) + 1: FOR t = 1 TO 52
IF C = CARD(t) THEN GOTO 110
NEXT t
115 IF O = 0 THEN P = P + 1: CARD(P) = C
120 IF C > 0 AND C < 14 THEN t$ = CHR$(3)
130 IF C > 13 AND C < 27 THEN t$ = CHR$(4)
140 IF C > 26 AND C < 40 THEN t$ = CHR$(5)
150 IF C > 39 AND C < 53 THEN t$ = CHR$(6)
151 D = C
155 IF D > 13 THEN D = D - 13: GOTO 155
157 IF D = 1 THEN N$ = "A": V = 1
158 IF D = 13 THEN N$ = "K": V = 10
159 IF D = 12 THEN N$ = "Q": V = 10
160 IF D = 11 THEN N$ = "J": V = 10
161 IF D > 1 AND D < 11 THEN N$ = RIGHT$(STR$(D), LEN(STR$(D)) - 1): V = D
199 RETURN
200 CLS : INPUT "Welcome to the Blackjack table, sorry I didn't catch your name:", NA$: IF LEN(NA$) = 0 OR LEN(NA$) > 10 THEN GOTO 200
205 GOSUB 3000
210 PRINT "Hi there,"; NA$; ", now let's sit down and play!"
230 PRINT "Since you are new, the house decided to give you some complimentary"
240 PRINT "chips totaling $1000!! I'm Cardshark Jack and I'll be your dealer"
241 PRINT "for this evening. The rules are simple and as follows:"
242 BANK = 1000: PRINT
245 PRINT "OBJECT: To get as close to 21 as you can without exeeding 21"
246 PRINT "HOW: Press 'H' to receive a card and 'S' to stop receiving"
247 PRINT "COMPETETION: I ,Cardshark Jack(A.K.A The Computer) ,will attempt the same goal."
249 PRINT "SUMMARY: Who ever not exeeding 21 is closest to 21 wins"
250 IF BANK <= 0 THEN GOTO 1000
255 LOCATE 23, 1: PRINT "OK,"; NA$; ", You have $"; BANK; " how much to wager(0-END):"; : INPUT BET
260 BET = INT(BET): IF BANK - BET >= 0 AND BET > 0 THEN BANK = BANK - BET: PRINT "                                                                         ": GOTO 400
265 IF BET <= 0 THEN GOTO 1000
270 IF BANK - BET < 1 THEN LOCATE 22, 1: PRINT "SORRY!! Can't do that!": GOTO 250
400 CLS : O = 1: PRINT "SHUFFLING THE DECK...": SP$ = " ": REM SHUFFLING DECK!
405 X = INT(RND * 15) + 1: Y = INT(RND * 70) + 1: SOUND 39 + (X * Y), .3
410 GOSUB 100: GOSUB 900: O = O + 1: IF O < 40 THEN GOTO 405
500 CLS : O = 0: REM \/ COMPUTER WILL PICK HIS FIRST 2 THEN THE REST LATER \/
501 COLOR 4: PRINT "COMPUTER PICKS HIS:                 Your bet:"; BET: COLOR 9
504 GOSUB 100: DL = DL + V: X = 3: Y = 1: N$ = "≤±": t$ = "±∞": SP$ = "": MS = C: GOSUB 900: SP$ = " "
505 GOSUB 100: DL = DL + V: X = 3: Y = Y + 8: GOSUB 900: IF Y < 10 THEN GOTO 600
509 IF DL < 17 THEN GOTO 505
510 GOTO 800
599 END: REM \/ NOW THE HUMAN WILL PICK AFTER HIS FIRST 2 \/
600 COLOR 1: LOCATE 9, 1: PRINT "HUMAN WILL PICK:                    Your BANK:"; BANK: X = 11: Y2 = Y: Y = 1: COLOR 9
601 IF N$ = "A" AND Y > 1 THEN t = 1: GOTO 2000
602 GOSUB 100: PL = PL + V: GOSUB 900: IF (PL - V) = 0 THEN Y = Y + 8: GOTO 601
603 IF PL = 21 AND Y < 10 THEN LOCATE 20, 1: PRINT "WOW,"; NA$; ", YOU GOT BLACKJACK!!": GOTO 800
604 IF PL = 21 THEN LOCATE 20, 1: PRINT "COOL,"; NA$; ", YOU WIN 21!!!!!!": GOTO 800
605 IF PL > 21 THEN LOCATE 20, 1: PRINT "SORRY,"; NA$; ", YOU BUSTED!": GOTO 800
606 IF N$ = "A" THEN t = 0: N$ = "": GOTO 2000
607 LOCATE 20, 1: PRINT "(H)it or (S)tand:"
608 CH$ = INKEY$
609 IF CH$ = "h" OR CH$ = "H" THEN Y = Y + 8: GOTO 602
610 IF CH$ = "s" OR CH$ = "S" THEN Y = Y2: X = 3: GOTO 509
611 GOTO 607
800 LOCATE 1, 1: X = 3: Y = 1: C = MS: GOSUB 120: GOSUB 900
805 LOCATE 2, 1: PRINT "The winner is:";
810 IF PL = 21 THEN PRINT NA$; "!!": W = 0
820 IF DL = 21 THEN PRINT "COMPUTER!!!": W = 1
830 IF PL > DL AND PL < 21 OR DL > 21 THEN PRINT NA$; " with"; PL: W = 0
840 IF DL > PL AND DL < 21 OR PL > 21 THEN PRINT "COMPUTER with"; DL: W = 1
850 IF DL = PL THEN PRINT "NOBODY!! It's tied with"; PL: W = 2
855 IF W = 0 THEN BANK = BANK + (BET * 2)
890 FOR t = 1 TO 52: CARD(t) = 0: NEXT t
891 P = 0: D = 0: PL = 0: DL = 0
899 GOTO 250
900 COLOR 12
901 LOCATE X, Y: PRINT "…ÕÕÕÕª"
902 LOCATE X + 1, Y: PRINT "∫    ∫": LOCATE X + 1, Y + 1: PRINT N$; SP$; t$
903 LOCATE X + 2, Y: PRINT "∫    ∫": LOCATE X + 2, Y + 1: PRINT t$; SP$; t$
904 LOCATE X + 3, Y: PRINT "∫    ∫": LOCATE X + 3, Y + 1: PRINT t$; SP$; N$
905 LOCATE X + 4, Y: PRINT "»ÕÕÕÕº": COLOR 9
910 LOCATE X + 5, 1: RETURN
1000 COLOR 28: LOCATE 1, 1: PRINT "Game over.... YOU win $"; BANK; "                                   ": NA$ = ""
1005 PRINT "-=<*Press any key*>=-                              "
1008 IF INKEY$ = "" THEN GOTO 1008 ELSE RUN
2000 REM POSSIBLE ACE VALUE PROMPT:
2001 LOCATE 20, 1: INPUT "Value of ACE(1 or 11):", ACE
2004 IF ACE = 1 THEN GOTO 2010
2006 IF ACE = 11 THEN PL = PL + 10: GOTO 2010
2009 GOTO 2001
2010 LOCATE 20, 1: PRINT "                                                 "
2015 IF t = 1 THEN GOTO 602
2020 GOTO 603
3000 E$ = "": FOR t = 1 TO LEN(NA$)
3005     N$ = MID$(NA$, t, 1): Y = ASC(N$)
3006     IF Y > 96 THEN Y = Y - 32
3007     IF Y <= 0 THEN Y = Y + 32
3008     E$ = E$ + CHR$(Y)
3009 NEXT t: NA$ = E$: RETURN

5000 CLS : PRINT
PRINT "Blackjack v1.0       Programmed by: DICEMAN         TRONIX '95"
PRINT : PRINT "Hi, this year the TRONiX Developers team is going nationwide. We are"
PRINT "hoping to release our latest products and our future advertisements across"
PRINT "America. This game here is freeware, we have many useful products NOT yet"
PRINT "released but will be soon. If you want any information on our latest products"
PRINT "or have any comments E-mail DICEMAN or CJ at:"
PRINT
PRINT " The Flame Broiler BBS (WWIV) 28.8 kbps - 504-682-7221"
PRINT "   Use our guest account NN:TRONIX PW:TRONIX PH:0000"
PRINT
PRINT "Thanks,"
PRINT "DICEMAN aka Corey Badeaux"
PRINT : GOTO 1005



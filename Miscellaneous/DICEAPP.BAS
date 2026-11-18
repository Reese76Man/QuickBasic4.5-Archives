DEFINT A-Z
SCREEN 0: WIDTH 80, 50
COLOR 12: PRINT SPC(28); "DICEnet Application v1.0"
PRINT SPC(28); "컴컴컴컴컴컴컴컴컴컴컴컴"
5 GOSUB 100: LOCATE 3, 1: PRINT "1. Personal Information"
PRINT "   컴컴컴컴컴컴컴컴컴컴": PRINT
LINE INPUT "Enter your REAL name:", rn$
LINE INPUT "Enter your ALIAS:", al$
LINE INPUT "Enter your STREET address:", st$
LINE INPUT "Enter your CITY & STATE:", cs$
LINE INPUT "Enter your ZIPCODE:", zip$
LINE INPUT "Enter the area code you are located:", ac$
LINE INPUT "Enter your HOME phone number:", ph1$
LINE INPUT "Enter your BBS phone number:", ph2$
LINE INPUT "What is your Birthdate:", bd$
LINE INPUT "Enter you School/Job:", occ$
PRINT : PRINT "Is this correct <Y/N>:"
10 g$ = UCASE$(INKEY$): IF g$ = "" THEN GOTO 10 ELSE IF g$ = "N" THEN GOTO 5
15 GOSUB 100: LOCATE 3, 1: PRINT "2. BBS Information"
PRINT "   컴컴컴컴컴컴컴�": PRINT
LINE INPUT "Enter the name of your BBS system:", bbs$
LINE INPUT "Enter your HIGHEST baud rate:", hb$
LINE INPUT "How many users/calls do you have so far:", uc$
LINE INPUT "Have you registered your WWIV:", bs$
LINE INPUT "Enter your brand of modem:", mb$
LINE INPUT "What are the BBS hours to be up:", tm$
LINE INPUT "About what date did your BBS first go up:", up$
LINE INPUT "Would you be willing to call Long Distance:", lng$
LINE INPUT "Would you be willing to connect to other NODES:", nde$
LINE INPUT "What NODE number would you like if possible:", nn$
LINE INPUT "What other networks are you in:"; on$
PRINT : PRINT "Is this correct <Y/N>:"
20 g$ = UCASE$(INKEY$): IF g$ = "" THEN GOTO 20 ELSE IF g$ = "N" THEN GOTO 15
25 GOSUB 100: LOCATE 6, 1
PRINT "Real name :"; rn$
PRINT "Street    :"; st$
PRINT "City/State:"; cs$
PRINT "Zipcode   :"; zip$: PRINT
PRINT "Home phone:("; ac$; ")"; ph1$
PRINT "D.O.B     :"; bd$
PRINT "Occupation:"; occ$: PRINT
PRINT "Other nets:"; on$
PRINT "Registered:"; bs$
PRINT "Connect LD:"; lng$
PRINT "Connect ND:"; nde$

LOCATE 6, 40: PRINT "Alias     :"; al$
LOCATE 7, 40: PRINT "BBS name  :"; bbs$
LOCATE 8, 40: PRINT "BBS hours :"; tm$
LOCATE 9, 40: PRINT "BBS users :"; uc$
LOCATE 10, 40: PRINT "Modem type:"; mb$
LOCATE 11, 40: PRINT "BBS number:("; ac$; ")"; ph1$
LOCATE 12, 40: PRINT "Baud rate :"; hb$
LOCATE 13, 40: PRINT "BBS Start :"; up$
LOCATE 14, 40: PRINT "Node reqst:"; nn$
LOCATE 25, 1: PRINT "Is this Ok <Y/N>:"
30 g$ = UCASE$(INKEY$): IF g$ = "" THEN GOTO 30 ELSE IF g$ = "N" THEN GOTO 5
PRINT : PRINT "Saving to disk as file DICENET.APP"
50 OPEN "DICENET.APP" FOR BINARY AS 1: IF LOF(1) > 0 THEN CLOSE 1: KILL "DICENET.APP": GOTO 50
FOR t = 1 TO 20: FOR y = 1 TO 75: p$ = p$ + CHR$(SCREEN(t, y)): NEXT y
p$ = p$ + CHR$(13) + CHR$(10): PUT #1, , p$: p$ = "": NEXT t: CLOSE 1
COLOR 7, 0: SCREEN 0: WIDTH 80, 25: CLS
PRINT "Just send this application to any of the following addresses:"
PRINT "Diceman      :1@1 DICEnet"
PRINT "Evil Avenger :1@3 DiceNet"
PRINT "              1@1546 WWIVNet"
PRINT "              1@5410 TerraNet"
PRINT "              1@5402 HellNet"
PRINT "              1@5410 IceNET"
PRINT "              1@8    BroodNet"
PRINT "              1@74   AireNet"
PRINT "              1@3    DiscoNet"
PRINT "DICEAPP.EXE was written by: DICEMAN"
PRINT : END
100 LOCATE 3, 1: FOR t = 1 TO 40: PRINT SPACE$(80): NEXT t: LOCATE 3, 1: RETURN
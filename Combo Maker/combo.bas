DEFLNG A-Z
CLS : COLOR 11
hdr$ = CHR$(13) + CHR$(10) + "TRONIXCOMBOMAKERWRITTENBYDICEMANTHEMOSTELITEOFTHEWHOLEGROUP<GRIN>:" + CHR$(13) + CHR$(10) + CHR$(26) + CHR$(26)
PRINT "              Combo maker v1.0 For TRONiX Developer's only!": COLOR 9
PRINT "                Make COMBO files for TRONiX Master File": COLOR 1
PRINT "        These files will be attached to the MASTER DEMO EXE file"
PRINT "              These files contain the files to be INSTALLED": COLOR 11
PRINT : PRINT "Choices:"
PRINT "1. Make COMBO.CMB file - Add multiple files into one file."
PRINT "2. Extract COMBO.CMB file - Test it to see if it is not corrupt."
PRINT "3. Create TRONIX.EXE - By adding MASTER.EXE and COMBO.CMB together."
PRINT "0. Exit to DOS"
10 g$ = INKEY$: IF g$ = "" THEN GOTO 10
IF g$ = "0" THEN COLOR 7: CLS : PRINT "TRONiX Rulez!": END
IF g$ = "3" THEN GOTO 1000
IF g$ = "2" THEN GOTO 500
IF g$ = "1" THEN GOTO 100
GOTO 10
 
100 ' Begin the combo!
DIM fl$(50)
CLS : FILES "*.*": PRINT "Enter File(s) one at a time, just enter a blank line to end."
105 fl = fl + 1: PRINT "File"; fl; : INPUT ":", fl$(fl)
IF fl$(fl) = "" OR fl = 51 THEN GOTO 110 ELSE GOTO 105
110 fl = fl - 1: IF fl = 0 THEN RUN
111 OPEN "COMBO.CMB" FOR BINARY AS 2: IF LOF(2) > 0 THEN CLOSE 2: KILL "COMBO.CMB": GOTO 111
PUT #2, , hdr$
LINE INPUT "Enter Message to be read in EXE:"; mess$
l$ = CHR$(255) + mess$ + CHR$(255): PUT #2, , l$: l$ = ""
k = 0: CLS : FOR y = 1 TO fl: k = k + 3: IF k > 21 THEN CLS : k = 3
OPEN fl$(y) FOR BINARY AS 1: IF LOF(1) = 0 THEN CLOSE 1: KILL fl$(y): GOTO 130
l$ = CHR$(255) + fl$(y) + CHR$(255): PUT #2, , l$: l$ = ""
l$ = CHR$(255) + LTRIM$(STR$(LOF(1))) + CHR$(255): PUT #2, , l$: l$ = ""
115 q$ = INPUT$(12288, 1): PUT #2, , q$
LOCATE k: PRINT "On File:"; y; "."; fl$(y): PRINT "On byte:"; LOC(1)
PRINT "Total bytes in COMBO:"; LOF(2)
IF EOF(1) <> -1 THEN GOTO 115 ELSE CLOSE 1
130 NEXT y: p$ = STR$(LOF(2)): l$ = CHR$(0) + STR$(LOF(2) + LEN(p$)): PUT #2, , l$: l$ = "": p$ = ""
CLOSE 2
PRINT : PRINT "End of COMBO."
135 IF INKEY$ = "" THEN GOTO 135 ELSE RUN

500 OPEN "combo.cmb" FOR BINARY AS 1
510 q$ = INPUT$(LEN(hdr$), 1): IF EOF(1) = -1 THEN CLOSE 1: END
IF q$ <> hdr$ THEN GOTO 510
512 GOSUB 800: GOSUB 800: PRINT "Found file:"; j$: f$ = j$
OPEN f$ FOR BINARY AS 2
GOSUB 800: GOSUB 800: lf = VAL(j$): PRINT "Length of file:"; lf
515 IF (lf - LOF(2)) >= 12288 THEN q$ = INPUT$(12288, 1): PUT #2, , q$
IF (lf - LOF(2)) < 12288 THEN q$ = INPUT$((lf - LOF(2)), 1): PUT #2, , q$
IF (lf - LOF(2)) <> 0 THEN GOTO 515
CLOSE 2: GOTO 512
CLOSE 1: END

800 j$ = ""
801 q$ = INPUT$(1, 1): IF EOF(1) = -1 THEN CLOSE 1: END
IF q$ <> CHR$(255) THEN j$ = j$ + q$: GOTO 801
RETURN
1000 OPEN "master.exe" FOR BINARY AS 1: OPEN "combo.cmb" FOR BINARY AS 2
1001 OPEN "TRONIX.EXE" FOR BINARY AS 3: IF LOF(3) > 0 THEN CLOSE 3: KILL "TRONIX.EXE": GOTO 1001
1005 t$ = INPUT$(12288, 1): PUT #3, , t$: IF EOF(1) <> -1 THEN GOTO 1005
1008 t$ = INPUT$(12288, 2): PUT #3, , t$: IF EOF(2) <> -1 THEN GOTO 1008
CLOSE 1, 2, 3: PRINT "Hit any key to exit": SLEEP: RUN


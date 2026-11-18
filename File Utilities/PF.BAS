DEFINT A-Z
SCREEN 0: CLS
LOCATE 2, 1: PRINT "Examining file:"; COMMAND$
IF COMMAND$ = "" THEN CLS : PRINT "Print Formater v1.0  Corey Badeaux": END
OPEN COMMAND$ FOR BINARY AS 1
IF LOF(1) = 0 THEN CLOSE 1: KILL COMMAND$: PRINT "File not found.": PRINT : END
5 OPEN "printrd.txt" FOR BINARY AS 2
IF LOF(2) > 0 THEN CLOSE 2: KILL "printrd.txt": GOTO 5
10 u$ = "": y$ = INPUT$(1024, 1)
FOR t2 = 1 TO LEN(y$): t = ASC(MID$(y$, t2, 1))
IF t = 196 THEN t = 45
IF t = 179 THEN t = 124
IF t > 128 THEN t = ASC("+")
u$ = u$ + CHR$(t)
NEXT t2: PUT #2, , u$
LOCATE 5, 1: PRINT "Bytes read:"; LOF(2); " out of "; LOF(1)
IF EOF(1) = 0 THEN GOTO 10
CLOSE 1, 2: PRINT "Finished."




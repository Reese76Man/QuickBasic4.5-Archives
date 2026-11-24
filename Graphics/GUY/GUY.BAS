DEFINT A-Z
CLS : SCREEN 13: x = 68: z = 50
DIM guy1(1 TO 405)  AS INTEGER
DIM guy2(1 TO 405)  AS INTEGER
DIM guy3(1 TO 405)  AS INTEGER
DIM guy4(1 TO 405)  AS INTEGER
DIM tr(1 TO 405) AS INTEGER
DIM blank(1 TO 405) AS INTEGER
DIM gy1(1 TO 405)  AS INTEGER
DIM gy2(1 TO 405)  AS INTEGER
DIM gy3(1 TO 405)  AS INTEGER
DIM gy4(1 TO 405)  AS INTEGER
DIM gy5(1 TO 405)  AS INTEGER
DIM gy6(1 TO 405)  AS INTEGER
DIM gy7(1 TO 405)  AS INTEGER
DIM gr(1 TO 405)  AS INTEGER


GET (1, 1)-(40, 20), blank: PRINT "Loading";
OPEN "guy1.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: guy1(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";
OPEN "guy2.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: guy2(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";
OPEN "guy3.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: guy3(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";
OPEN "guy4.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: guy4(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";
OPEN "tr.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: tr(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";
OPEN "gy1.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: gy1(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";
OPEN "gy2.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: gy2(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";
OPEN "gy3.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: gy3(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";
OPEN "gy4.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: gy4(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";
OPEN "gy5.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: gy5(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";
OPEN "gy6.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: gy6(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";
OPEN "gy7.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: gy7(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";
OPEN "gr.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: gr(t) = VAL("&H" + p$): NEXT t: CLOSE 1: PRINT ".";

REM DOIN' IT
CLS : LINE (1, 70)-(320, 70), 2
LINE (200, 71)-(200, 200), 6: LINE (212, 71)-(212, 200), 6
FOR t = 80 TO 200 STEP 10: LINE (200, t)-(212, t), 6: NEXT t
10 FOR t = 1 TO 4
x = x + 2
'FOR p = 1 TO 60: FOR y = 0 TO tm: NEXT y, p
Delay .0001

IF t = 1 THEN PUT (x, z), guy1, PSET
IF t = 2 THEN PUT (x, z), guy2, PSET
IF t = 3 THEN PUT (x, z), guy3, PSET
IF t = 4 THEN PUT (x, z), guy4, PSET
IF x < 160 THEN PUT (x - 29, z), tr, PSET: PUT (x - 68, z), blank, PSET ELSE PUT (159 - 29, z), tr, PSET
NEXT t: IF x < 270 THEN GOTO 10
20 FOR t = 1 TO 4
'FOR p = 1 TO 30: FOR y = 0 TO tm: NEXT y, p
Delay .001
PUT (xb, zb), blank, PSET
IF x > 64 THEN x = x - 2
GET (x, z)-(x + 19, z + 29), blank: xb = x: zb = z
IF x < 180 AND x > 160 THEN z = z - 2: PUT (x, z), gy2, PSET
IF x < 160 AND x > 135 THEN z = z - 1: PUT (x, z), gy2, PSET
IF x < 135 AND x > 110 THEN PUT (x, z), gy1, PSET
IF x < 110 AND x > 85 THEN z = z + 1: PUT (x, z), gy1, PSET
IF x < 85 AND x > 65 THEN z = z + 2: PUT (x, z), gy3, PSET
IF x < 65 THEN z = z + 3: PUT (x, z), gy5, PSET
IF z > 50 THEN PUT (66, 61), gr, PSET
IF x > 180 THEN
IF t = 1 THEN PUT (x, z), gy1, PSET
IF t = 2 THEN PUT (x, z), gy2, PSET
IF t = 3 THEN PUT (x, z), gy3, PSET
IF t = 4 THEN PUT (x, z), gy4, PSET
END IF
NEXT t: IF z < 165 THEN GOTO 20
PUT (xb, zb), blank, PSET: PUT (xb + 5, zb), blank, PSET: SLEEP 2
29 x = 191: z = 167: xb = x: zb = z: GET (x, z)-(x + 39, z + 19), blank
30 FOR t = 1 TO 2: z = z - 4
'FOR p = 1 TO 175: FOR y = 0 TO tm: NEXT y, p
Delay .0005
PUT (xb, zb), blank, PSET: GET (x, z)-(x + 39, z + 19), blank: xb = x: zb = z
IF t = 1 THEN PUT (x, z), gy6, PSET
IF t = 2 THEN PUT (x, z), gy7, PSET
NEXT t: IF z > 77 THEN GOTO 30
  
Sub DELAY (tm#)
    z# = timer
    DO
        IF timer - z# > tm# THEN EXIT DO
    LOOP
END SUB
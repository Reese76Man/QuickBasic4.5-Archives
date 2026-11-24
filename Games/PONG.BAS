DEFINT A-Z
DEFLNG S
SCREEN 13: RANDOMIZE TIMER
LINE (1, 30)-(40, 90), 1
LINE (70, 30)-(40, 90), 1
CIRCLE (155, 62), 37, 1, 1, 6
LINE (155, 69)-(190, 69), 1
LINE (230, 90)-(270, 30), 1
LINE (270, 30)-(300, 90), 1
LINE (251, 60)-(285, 60), 1
COLOR 9: LOCATE 14, 19: PRINT "PONG"
LOCATE 20, 7: PRINT "Programmed by: Corey Badeaux "
LOCATE 21, 10: PRINT "Tronix Developers 1995"
LOCATE 23, 17: PRINT "Hit a key"

DO
    _LIMIT 60
    A$ = INKEY$
LOOP UNTIL A$ <> ""
IF A$ = "~" THEN cheat = 1

q = 1: w = 1: bl = 3:steps = 1
80 CLS : LINE (10, 10)-(300, 180), 1, B
x = 100: y = INT(RND * 100) + 25: dx = 1: dy = 1
ctl = 1: lv = 1

90 LOCATE 1, 5: PRINT USING "Score: ##  Level: ##  Balls: #"; sc; INT(sc / 5) + 1; bl
IF INT(sc / 5) + 1 > lv THEN
    lv = INT(sc / 5) + 1
    steps = steps + 1
END IF

100 _LIMIT 120
    o2 = INP(&H60): A$ = ""
    IF cheat = 1 THEN
        IF q > y - 25 THEN oa = oa + steps
        IF q < y - 25 THEN oz = oz + steps
    END IF
    IF o2 = 16 THEN A$ = CHR$(27)
    IF o2 = 72 THEN oa = oa + 1
    IF oa >= ctl THEN A$ = "A": oa = 0
    IF o2 = 80 THEN oz = oz + 1
    IF oz >= ctl THEN A$ = "Z": oz = 0

    IF q <> bq OR POINT(15, 15 + bq) = 0 THEN
        LINE (15, 15 + bq)-(20, 60 + bq), 0, BF
        LINE (15, 15 + q)-(20, 60 + q), 7, BF: bq = q
    END IF
    IF A$ = CHR$(27) THEN SCREEN 0: WIDTH 80: CLS : PRINT : SYSTEM
    IF A$ = "A" THEN q = q - 5: IF q < 0 THEN q = 0
    IF A$ = "Z" THEN q = q + 5: IF q > 115 THEN q = 115

    FOR subz = 1 TO steps
        x = x + dx
        y = y + dy

        IF y > 160 THEN y = 160: dy = -1: GOSUB 200
        IF y < 9 THEN y = 9: dy = 1: GOSUB 200

        IF x < 16 AND x > 12 AND (11 + y) > (15 + bq) - 5 AND (11 + y) < (60 + bq) + 5 THEN
            dx = 1: x = 16: GOSUB 300
            LOCATE 1, 5: PRINT USING "Score: ##  Level: ##  Balls: #"; sc; INT(sc / 5) + 1; bl
            IF INT(sc / 5) + 1 > lv THEN
                lv = INT(sc / 5) + 1
                steps = steps + 1
            END IF
        END IF

        IF x > 280 THEN x = 280: dx = -1: GOSUB 200

        IF x < 5 THEN
            LOCATE 15, 15: PRINT "Lost Ball"
            _DELAY 2
            bl = bl - 1
            IF bl = 0 THEN LOCATE 15, 15: PRINT "Game Over": _DELAY 5: RUN
            GOTO 80
        END IF
    NEXT subz

    IF x <> xb OR y <> yb THEN
        PAINT (11 + xb, 11 + yb), 0, 0
        CIRCLE (11 + x, 11 + y), 7, 1: PAINT (11 + x, 11 + y), 11, 1: xb = x: yb = y
    END IF
GOTO 100

200 SOUND 3000, .5: RETURN
300 SOUND 1000, .5: sc = sc + 1: RETURN
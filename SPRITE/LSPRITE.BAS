DEFINT A-Z
CLS : SCREEN 13
DIM Image(1 TO 405)  AS INTEGER
DIM PreImage(1 TO 405)  AS INTEGER
OPEN "ltd1.spt" FOR INPUT AS 1
FOR t = 1 TO 405: INPUT #1, p$: Image(t) = VAL("&H" + p$): NEXT t: CLOSE 1
CLS : LINE (0, 130)-(320, 130), 10: PAINT (1, 1), 1, 10: y = 10: u = 110
GET (y, u)-(y + 39, u + 19), PreImage: yy = y: uu = u: x = 100: xb = x



10 LINE (xb, 129)-(xb + 20, 110), 1: LINE (xb + 20, 110)-(xb + 40, 129), 1
LINE (x + 20, 111)-(x + 16, 115), 7
LINE (x, 129)-(x + 20, 110), 8: LINE (x + 20, 110)-(x + 40, 129), 8
xb = x: x = x - 1: IF x < -40 THEN x = 320
PUT (yy, uu), PreImage, PSET
GET (y, u)-(y + 39, u + 19), PreImage
PUT (y, u), Image, XOR: yy = y: uu = u
FOR t = 1 TO 2000: NEXT t
GOTO 10


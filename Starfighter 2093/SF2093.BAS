DEFINT A-Z
DEFSNG T, Y
0 CLS : SCREEN 13: u = 320: k = 320: l = 320: h = 320: m = 320: n = 320: v = 320: d = 320: f = 320
VIEW (0, 10)-(319, 190)
W = 11: tm = 500: a$ = "TRONIX PRESENTS...": GOSUB 1
a$ = "ANOTHER DICEMAN PRODUCTION": GOSUB 1: e = 1
W = 7: a$ = "Captain Dude is...": GOSUB 1: tm = 1000
W = 11: a$ = "S T A R * F I G H T E R * 2093": GOSUB 1: tm = 500
GOTO 2
1 q = 19 - (LEN(a$) / 2)
FOR t = 16 TO 30: COLOR t: LOCATE W, q: PRINT a$: FOR y = 1 TO tm: NEXT y, t: IF tm = 50 THEN W = W + 1
FOR t = 1 TO tm * 8: NEXT t: IF e = 1 THEN e = 0: RETURN
FOR t = 30 TO 16 STEP -1: COLOR t: LOCATE W, q: PRINT a$: FOR y = 1 TO tm: NEXT y, t
COLOR 30: RETURN

2 x = 150: y = 150: q = x: W = y: c1 = 8: c2 = 3 + (RND * 2): GOSUB 20
LOCATE 7, 1: COLOR 4: PRINT "S T A R * F I G H T E R  2093"
LOCATE 9, 1: COLOR 13: PRINT "Choose:"
LOCATE 11, 1: COLOR 5: PRINT "1. Instructions"
LOCATE 12, 1: COLOR 14: PRINT "2. Credits"
LOCATE 13, 1: COLOR 9: PRINT "3. Start S T A R * F I G H T E R"
LOCATE 14, 1: COLOR 12: PRINT "4. Quit to Dos"
6 y$ = INKEY$: IF y$ = "1" THEN GOTO 40
7 IF y$ = "2" THEN GOTO 50
8 IF y$ = "3" THEN CLS : tme = 50000: GOTO 11
IF y$ = "4" THEN END
READ a$: IF a$ = "end" THEN RESTORE: GOTO 6
PLAY a$
10 GOTO 6
11 a$ = INKEY$: e = x: r = y: r$ = RIGHT$(a$, 1): tme = tme - 1
IF tme = 49900 THEN LOCATE 2, 1: PRINT "HIGH COMMAND: Your journey will be tough, I have equipped you with dual weapons and 1 warp jump-o-matic! good luck!"
IF tme = 49700 THEN LOCATE 2, 1: PRINT "                                                                                                                   "
IF a$ = "" AND r$ = "" THEN LOCATE 1, 1: PRINT tme; " miles to planet-X"; ms$: GOTO 16
12 IF r$ = "G" OR r$ = "O" OR r$ = "K" THEN x = x - 5: IF x < 10 THEN x = 10
13 IF r$ = "O" OR r$ = "Q" OR r$ = "P" THEN y = y + 5: IF y > 200 THEN y = 200
14 IF r$ = "I" OR r$ = "Q" OR r$ = "M" THEN x = x + 5: IF x > 300 THEN x = 300
15 IF r$ = "G" OR r$ = "I" OR r$ = "H" THEN y = y - 5: IF y < 50 THEN y = 50
   IF a$ = CHR$(32) AND sh = 0 THEN sh = 1: ws = W: qs = q + 5
   IF a$ = CHR$(13) AND sg = 0 THEN sg = 1: wr = W: qb = q + 5
REM :galactic stars

16 ub = u: hb = h: kb = k: lb = l: mb = m: nb = n: vb = v: fb = f: db = d
uxb = ux: hxb = hx: kxb = kx: lxb = lx: mxb = mx: nxb = nx: vxb = vx: dxb = dx: fxb = fx
u = u + ur: IF u > 200 THEN u = 0: ux = RND * 310: ur = (RND * 5) + 4
h = h + hr: IF h > 200 THEN h = 0: hx = RND * 310: hr = (RND * 5) + 4
k = k + kr: IF k > 200 THEN k = 0: kx = RND * 310: kr = (RND * 5) + 4
l = l + lr: IF l > 200 THEN l = 0: lx = RND * 310: lr = (RND * 5) + 4
m = m + mr: IF m > 200 THEN m = 0: mx = RND * 310: mr = (RND * 5) + 4
n = n + nr: IF n > 200 THEN n = 0: nx = RND * 310: nr = (RND * 5) + 4
v = v + vr: IF v > 200 THEN v = 0: vx = RND * 310: vr = (RND * 5) + 4
f = f + fr: IF f > 200 THEN f = 0: fx = RND * 310: fr = (RND * 5) + 4
d = d + dr: IF d > 200 THEN d = 0: dx = RND * 310: dr = (RND * 5) + 4
CIRCLE (uxb, ub), 1, 0: CIRCLE (hxb, hb), 1, 0: CIRCLE (kxb, kb), 1, 0
CIRCLE (lxb, lb), 1, 0: CIRCLE (mxb, mb), 1, 0: CIRCLE (nxb, nb), 1, 0
CIRCLE (vxb, vb), 1, 0: CIRCLE (fxb, fb), 1, 0: CIRCLE (dxb, db), 1, 0
CIRCLE (ux, u), 1, 30: CIRCLE (hx, h), 1, 30: CIRCLE (kx, k), 1, 30
CIRCLE (lx, l), 1, 30: CIRCLE (mx, m), 1, 30: CIRCLE (nx, n), 1, 30
CIRCLE (vx, v), 1, 30: CIRCLE (fx, f), 1, 30: CIRCLE (dx, d), 1, 30
REM :fire shots                    
IF sh = 1 THEN ws = ws - 9: CIRCLE (qs, wsb), 3, 0: CIRCLE (qs, ws), 3, 6: wsb = ws
IF sh = 1 AND ws < 20 THEN sh = 0: CIRCLE (qs, wsb), 3, 0
IF sg = 1 THEN wr = wr - 10: LINE (qb, web + wr)-(qb, web - 30 + wr), 0: LINE (qb, wb + wr)-(qb, wb + wr - 30), 9: web = wr
IF sg = 1 AND wr < 20 THEN sg = 0: LINE (qb, web + wr)-(qb, web + wr - 30), 0

18  c1 = 0: c2 = 0: q = e: W = r: GOSUB 20: q = x: W = y: c1 = 8: c2 = 3 + (RND * 2): GOSUB 20
19 GOTO 11
REM :draw of spaceship
20 FOR t = q TO q + 10
21 LINE (t, W - 11)-(t, W + 15), c1: NEXT t
22 LINE (q - 5, W - 6)-(q + 5, W - 16), c1: LINE (q + 5, W - 16)-(q + 15, W - 6), c1
23 LINE (q - 5, W - 6)-(q + 15, W - 6), c1: PAINT (q - 3, W - 7), c1: PAINT (q + 13, W - 7), c1
24 PAINT (q + 3, W - 13), c1
LINE (q, W + 3)-(q - 20, W + 12), c1: LINE (q - 20, W + 12)-(q + 30, W + 12), c1
LINE (q + 30, W + 12)-(q + 10, W + 3), c1: PAINT (q - 10, W + 10), c1
PAINT (q + 25, W + 11), c1
25 CIRCLE (q, W + 15), 5, c2: CIRCLE (q + 10, W + 15), 5, c2
26 PAINT (q, W + 16), c2: PAINT (q + 11, W + 15), c2
30 RETURN
REM :instructions
40 CLS : LOCATE 2, 6: PRINT "Hail Captain DUDE (you!) is the only hope to bring peace to planet X. ";
PRINT "You need to get to planet X with the only antidote that can save the king ";
PRINT "kneckebenezer the 23rd!!. His great great great great great great great great ";
PRINT "grandad once ruled mesapotania!!! but anyway some evil doings of the master of ";
PRINT "evil himself Duke Hoodlem of planet H will try to stop you at any cost. ";
PRINT "hopefully that x-37 super dual rocket experimental spaceship we got you ";
PRINT "for your last birthday, will help you on your journey.. well good luck,";
PRINT "HIGH COMMAND CENTRAL"
47 LOCATE 22, 30: PRINT "press any key"
48 b$ = INKEY$: IF b$ = "" THEN READ a$: IF a$ = "end" THEN RESTORE: GOTO 48
49 IF b$ = "" THEN PLAY a$: GOTO 48
CLS : GOTO 2

REM :credits
50 FOR t = 1 TO 320: LINE (r, t)-(r + 640, t), 0: NEXT t
51 CLS : LOCATE 5, 1: COLOR 14: PRINT " Game design by: DICEMAN"
52 LOCATE 7, 1: PRINT " Programming by: DICEMAN"
53 LOCATE 9, 1: PRINT " Sound by: DICEMAN"
54 LOCATE 11, 1: PRINT " Graphics by: DICEMAN"
55 LOCATE 13, 1: PRINT " This game is a TRONIX production."
56 LOCATE 22, 1: PRINT "press any key"
58 IF INKEY$ <> "" THEN CLS : GOTO 2
59 r = RND * 4: COLOR r: SOUND 37 + (r * 1000), .5: GOTO 58

REM :music on menu
100 DATA o3,l8,c,c,c,d,d#,d#,d#,f,<,a#,a#,a#,>,d,c,c,c,n0,c,c,c,d,d#,d#,d#
DATA f,o2,a#,a#,a#,o3,d,c,c,c,n0
101 DATA g,g,g,a,a#,a#,a#,>,c,<,f,f,f,a,g,g,g,n0,g,g,g,a,a#,a#,a#,>,c,<,f
DATA f,f,a,g,g,g,n0
DATA >,d,<,a#,>,d,d#,f,f,d#,d,c,<,a#,>,c,d,c,c,d,c,<,a#,g,a#,>,c,d,d,c,<
DATA a#,a,g,a,a#,a,a
DATA a#,a,g,d#,g,a,a#,a#,a,g,f,d,f,a,a#,a#,a#,a#,g,d#,<,a#,>,g,a,f,d,a
DATA a#,a#,a#,a#,a#,n0,n0,n0
199 DATA n0,n0,n0,n0,n0,end


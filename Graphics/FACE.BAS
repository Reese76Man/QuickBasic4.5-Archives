DEFLNG A-Z
SCREEN 13

x = 150: y = 70: sz = 15: tl = 12000

FOR sz = 1 TO 175
tl = tl - 100
FOR u = -tl TO tl: NEXT u
FOR u = -tl TO tl: NEXT u
FOR u = -tl TO tl: NEXT u
FOR u = -tl TO tl: NEXT u
CIRCLE (bx, by), bsz, 0
CIRCLE (bx - (bsz / 3) + 1, by - (bsz / 6)), 1 + (bsz / 10), 0
CIRCLE (bx + (bsz / 3) + 1, by - (bsz / 6)), 1 + (bsz / 10), 0
CIRCLE (bx - (bsz / 3) + 1, by - (bsz / 6)), 1 + (bsz / 25), 0
CIRCLE (bx + (bsz / 3) + 1, by - (bsz / 6)), 1 + (bsz / 25), 0
CIRCLE (bx + 1, by - (bsz / 100) + (bsz * .5)), (bsz / 7), 0
LINE (bx, by + (bsz * .85))-(bx, by + (bsz * 5)), 0
LINE (bx, by + (bsz * .85) + bsz)-(bx - (bsz * 2), by - (bsz * .85) + (bsz * 2)), 0
LINE (bx, by + (bsz * .85) + bsz)-(bx + (bsz * 2), by - (bsz * .85) + (bsz * 2)), 0
LINE (bx, by + (bsz * .85) + (bsz * 5))-(bx - (bsz * 2), by - (bsz * .85) + (bsz * 2)), 0
LINE (bx, by + (bsz * .85) + (bsz * 5))-(bx + (bsz * 2), by - (bsz * .85) + (bsz * 2)), 0


CIRCLE (x, y), sz, 1
CIRCLE (x - (sz / 3) + 1, y - (sz / 6)), (sz / 10) + 1, 1
CIRCLE (x + (sz / 3) + 1, y - (sz / 6)), (sz / 10) + 1, 1
CIRCLE (x - (sz / 3) + 1, y - (sz / 6)), (sz / 25) + 1, 7
CIRCLE (x + (sz / 3) + 1, y - (sz / 6)), (sz / 25) + 1, 7
CIRCLE (x + 1, y - (sz / 120)), (sz / 20) + 1, 7
CIRCLE (x + 1, y - (sz / 100) + (sz * .5)), (sz / 7), 12

LINE (x, y + (sz * .85))-(x, y + (sz * 5)), 1
LINE (x, y + (sz * .85) + sz)-(x - (sz * 2), y - (sz * .85) + (sz * 2)), 1
LINE (x, y + (sz * .85) + sz)-(x + (sz * 2), y - (sz * .85) + (sz * 2)), 1
LINE (x, y + (sz * .85) + (sz * 5))-(x - (sz * 2), y - (sz * .85) + (sz * 2)), 1
LINE (x, y + (sz * .85) + (sz * 5))-(x + (sz * 2), y - (sz * .85) + (sz * 2)), 1
zz# = .01: Gosub 8000
bsz = sz: bx = x: by = y: NEXT sz

8000 z# = TIMER
      DO UNTIL (TIMER - z# > zz#) OR (TIMER - z# < 0)
      LOOP
      ' zz# = .01: Gosub 8000
RETURN
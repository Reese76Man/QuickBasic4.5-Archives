DEFINT A-Z
DECLARE SUB VMINIT (filesize&)
DECLARE SUB VMEXIT ()
DECLARE SUB VMPOKE (address&, byte%)
DECLARE FUNCTION VMPEEK (address&)


' BEGIN

VMINIT (10)
DEF SEG = &HB800: CLS
FOR t = 1 TO 4000: POKE t, INT(RND * 255) + 1: NEXT t
FOR t& = 1 TO 4000
VMPOKE t&, PEEK(t&)
NEXT t&
LOCATE 1, 1: PRINT "Done saving to Virtual Memory, press any key to retrive."
SLEEP: CLS
FOR t& = 1 TO 4000
POKE t&, VMPEEK(t&)
NEXT t&
VMEXIT

SUB VMEXIT
CLOSE 1: OPEN "VMINIT.$$$" FOR BINARY AS 1: CLOSE 1: KILL "VMINIT.$$$"
END SUB

SUB VMINIT (size&)
VMBACK: OPEN "VMINIT.$$$" FOR BINARY AS 1
IF LOF(1) > 0 THEN CLOSE 1: KILL "VMINIT.$$$": GOTO VMBACK:
FOR t = 1 TO size&
vmvar$ = STRING$(1024, 0)
PUT #1, , vmvar$
NEXT t: SEEK 1, 1
END SUB

FUNCTION VMPEEK (address&)
SEEK 1, address&
VMPEEK = ASC(INPUT$(1, 1))
END FUNCTION

SUB VMPOKE (address&, byte%)
SEEK 1, address&
vmvar$ = CHR$(byte%)
PUT #1, , vmvar$
END SUB


gcServer = ''
gcPort = ''
IF !FILE('konfig.txt')
	RETURN .f.
ENDIF

CREATE CURSOR tmpKonf (konf m)
SELECT tmpKonf
APPEND BLANK

APPEND MEMO konf FROM konfig.txt
FOR i = 1 TO MEMLINES(tmpKonf.konf)
	lcString = MLINE(tmpKonf.konf,i)
*	WAIT WINDOW lcString TIMEOUT 1
	DO case
		CASE lcString = 'PGserver'
			i = i+1
			gcServer = 	ALLTRIM(MLINE(tmpKonf.konf,i))
		CASE lcString = 'PGport'
			i = i+1
			gcPort = 	ALLTRIM(MLINE(tmpKonf.konf,i))
	ENDCASE	
ENDFOR

*WAIT WINDOW gcServer TIMEOUT 3
*WAIT WINDOW gcPort TIMEOUT 3

USE IN tmpKonf



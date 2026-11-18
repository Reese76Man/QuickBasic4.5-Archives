DEFINT A-Z
REM $DYNAMIC

	REM $INCLUDE: '.\ACDKIT.BI'

	DECLARE FUNCTION TimeStr$ (mins%, secs%)
	DECLARE SUB UpdateDisplay ()
	
	CONST FALSE% = 0
	CONST TRUE% = NOT FALSE%

	DIM SHARED tracklist(5) AS trackinfo     ' music track information array
	DIM SHARED cd AS cdInfoTYPE              ' track info
	DIM SHARED cddrive AS INTEGER            ' first cdrom drive
	DIM SHARED curTrack AS INTEGER           ' current track number

	curTrack = 1

	IF IsMscdex = FALSE THEN
		CLS : PRINT "MSCDEX.EXE driver is not installed."
		SLEEP 3
		END
	END IF

	cddrive = GetFirstCdrom%                 ' get the first cdrom drive

	dummy% = cdMediaChanged(cddrive%)        ' clear changed flag

RESTART:

	CLS

	IF IsAudio(cddrive) = FALSE THEN        ' is this an audio cd?
		PRINT "The inserted cd is not an audio cd."
		PRINT "Please insert an audio cd and restart."
		SLEEP 3
		END
	END IF

	cdInit cddrive%, tracklist()             ' read cd information

	IF (cd.status AND CDPLAYING) <> CDPLAYING THEN
		cdSeek cddrive%, 1, tracklist()  ' seek to first song
	END IF

	PRINT "ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿"
	PRINT "³          AUDIO CD TOOLKIT          ³"
	PRINT "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄ´"
	PRINT "³ Audio Track(s)     ³       ³       ³"
	PRINT "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄ´"
	PRINT "³ Current Audio Time ³       ³       ³"
	PRINT "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄ´"
	PRINT "³ Total Audio Time   ³       ³       ³"
	PRINT "ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄ´"
	PRINT "³   P      Play Audio Track          ³"
	PRINT "³   S      Stop Audio Playback       ³"
	PRINT "³   SPACE  Pause/Resume Audio Track  ³"
	PRINT "³   +      Next Audio Track          ³"
	PRINT "³   -      Previous Audio Track      ³"
	PRINT "³   TAB    Open/Close CD-ROM Door    ³"
	PRINT "³   ESC    End                       ³"
	PRINT "ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ"

	DO

		LOCATE 19, 1

		IF (cd.status AND CDPAUSED) = CDPAUSED THEN
			PRINT "PAUSED "
		ELSEIF (cd.status AND CDPLAYING) = CDPLAYING THEN
			PRINT "PLAYING"
		ELSE
			PRINT "       "
		END IF

		k$ = UCASE$(INKEY$)

		SELECT CASE k$

			CASE CHR$(27)
				SYSTEM

			CASE "P"
				cdPlay cddrive%, curTrack, 99, tracklist()

			CASE "S"
				cdStop cddrive%

			CASE " "
				IF (cd.status AND CDPAUSED) = CDPAUSED THEN
					cdResume cddrive%
				ELSE
					cdPause cddrive%
				END IF

			CASE "+"
				curTrack = curTrack MOD UBOUND(tracklist) + 1
				cdPlay cddrive%, curTrack, 99, tracklist()

			CASE "-"
				curTrack = curTrack - 1
				IF curTrack = 0 THEN
					curTrack = UBOUND(tracklist)
				END IF
				cdPlay cddrive%, curTrack, 99, tracklist()

			CASE CHR$(9)
				IF (cd.status AND CDOPEN) = CDOPEN THEN
					cdDoor cddrive%, 2
				ELSE
					cdStop cddrive%
					cdDoor cddrive%, 1
				END IF

			CASE ELSE
				cdGetInfo cddrive%, 0, cd, tracklist()
				curTrack = cd.track
				UpdateDisplay
		END SELECT

	LOOP

REM $STATIC

FUNCTION TimeStr$ (mins%, secs%)

	sec = secs%

	IF sec% = 254 THEN
		sec% = 0
	END IF

	text$ = RIGHT$("00" + LTRIM$(STR$(mins%)), 2) + ":" + RIGHT$("00" + LTRIM$(STR$(sec%)), 2)

	TimeStr$ = text$

END FUNCTION

SUB UpdateDisplay

	LOCATE 4, 33: PRINT UBOUND(tracklist)
	LOCATE 8, 32: PRINT TimeStr$(cd.cdMins, cd.cdSecs)
	LOCATE 4, 25: PRINT USING "##"; cd.track
	LOCATE 6, 32: PRINT TimeStr$(cd.cdMin, cd.cdSec)
	LOCATE 6, 24: PRINT TimeStr$(cd.TrackMin, cd.TrackSec)
	LOCATE 8, 24: PRINT TimeStr$(cd.TrackMins, cd.TrackSecs)

END SUB


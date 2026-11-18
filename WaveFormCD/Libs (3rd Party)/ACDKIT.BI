DEFINT A-Z
REM $DYNAMIC

CONST CDINSTALLED% = &H1
CONST CDPLAYING% = &H2
CONST CDPAUSED% = &H4
CONST CDOPEN% = &H8
CONST CDLOCKED% = &H10

TYPE trackinfo
 cmd AS STRING * 1
 track AS STRING * 1
 tframe AS STRING * 1
 tsec AS STRING * 1
 tmin AS STRING * 1
 dummy AS STRING * 1
 control AS STRING * 1
 absframe AS LONG
END TYPE

TYPE cdInfoTYPE
 status AS INTEGER            ' status of the driver
 track AS INTEGER             ' current track number
 frame AS LONG                ' current absolute frame number
 cdMin AS INTEGER             ' cd position (minutes)
 cdSec AS INTEGER             ' cd position (seconds)
 cdFrame AS INTEGER           ' cd position (frames)
 TrackMin AS INTEGER          ' track position (mins)
 TrackSec AS INTEGER          ' track position (seconds)
 TrackFrame AS INTEGER        ' track position (frames)
 cdMins AS INTEGER            ' cd length (mins)
 cdSecs AS INTEGER            ' cd length (seconds)
 cdFrames AS INTEGER          ' cd length (frames)
 TrackMins AS INTEGER         ' track length (mins)
 TrackSecs AS INTEGER         ' track length (seconds)
 TrackFrames AS INTEGER       ' track length (frames)
END TYPE

DECLARE SUB cdGetInfo (drive%, track%, cd AS cdInfoTYPE, tracklist() AS trackinfo)
DECLARE SUB cdDoor (BYVAL drive%, BYVAL cmd%)
DECLARE SUB cdPause (BYVAL drive%)
DECLARE SUB cdPlayFrames (BYVAL drive%, BYVAL frame&, BYVAL lframe&)
DECLARE SUB cdPlayMSF (drive%, mins%, secs%, frame%, lmin%, lsec%, lframe%)
DECLARE SUB cdPlay (drive%, track%, tracks%, tracklist() AS trackinfo)
DECLARE SUB cdInit (drive%, tracklist() AS trackinfo)
DECLARE SUB cdReset (BYVAL drive%)
DECLARE SUB cdResume (BYVAL drive%)
DECLARE SUB cdSeek (drive%, track%, tracklist() AS trackinfo)
DECLARE SUB cdSeekFrame (BYVAL drive%, BYVAL frame&)
DECLARE SUB cdSeekMSF (drive%, mins%, secs%, frame%)
DECLARE SUB cdStop (BYVAL drive%)
DECLARE SUB cdGetVolume (BYVAL source%, left1%, right1%, left2%, right2%)
DECLARE SUB cdSetVolume (BYVAL source%, BYVAL left1%, BYVAL right1%, BYVAL left2%, BYVAL right2%)
DECLARE SUB sbGetVolume (BYVAL source%, leftV%, rightV%)
DECLARE SUB sbSetVolume (BYVAL source%, BYVAL leftV%, BYVAL rightV%)

DECLARE FUNCTION cdMediaChanged% (BYVAL drive%)
DECLARE FUNCTION cdStatus% (BYVAL drive%)
DECLARE FUNCTION GetFirstCdrom% ()
DECLARE FUNCTION GetMscdexVersion% ()
DECLARE FUNCTION GetNumCdroms% ()
DECLARE FUNCTION IsAudio% (BYVAL drive%)
DECLARE FUNCTION IsMscdex% ()
DECLARE FUNCTION IsSB% ()

DECLARE FUNCTION MSFtoFrame& (BYVAL mins%, BYVAL secs%, BYVAL frame%)
DECLARE SUB FrameToMSF (BYVAL frame&, mins%, secs%, frames%)


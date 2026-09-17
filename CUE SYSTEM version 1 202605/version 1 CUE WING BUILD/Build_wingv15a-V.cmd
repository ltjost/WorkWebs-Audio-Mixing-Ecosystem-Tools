ECHO OFF
color 06
set scriptver=Easter Holy Week-WING 2026 v2060526a v15-V
setlocal enabledelayedexpansion



:: display some initial script info for the record!  Weird code strips quote marks from the string so it displays nicely
set tempstring="."
set tempstringx=%tempstring:"=%
echo %tempstringx%
set tempstring=".      ***  Build WING "  %scriptver% "   ***"
set tempstringx=%tempstring:"=%
echo %tempstringx%
set tempstring="."
set tempstringx=%tempstring:"=%
echo %tempstringx%



:: **************************************************************************************
:: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
:: ******************************** SET THESE *******************************************

:: Each Device to communicate with is designated by a Device Letter.
:: Each device has a TYPE that is used to set up OSC messages in the correct format.
:: This script currently accepts the following TYPES:
:: 	WING

:: Cues for this specific device of the specified TYPE are also tied to this 
::  Device Letter.  The Device Letter is used as the first letter in the cue file name
::  for all cues for this specific Device.

:: When running the Cues you will also provide an IP and a Port tied to the same letter
:: to asscociate these items together.  Since that can vary, these values are not built into
:: the cues but are assigned at the time the cue file are used.

:: Also set Delay...this is the number of ms that wosc should wait between
:: sending commands.  The default may be 10
::  A value of 0 to 10 is recommended 

:: This is a single character designation.

set Type.V=WING
set Delay.V=0
set Prefix=V


:: File format is one of these choices

:: for  WING cues:

:: createfile
:: createfile causes the system to build a new output cue file.  Without this, all added commands will append to
:: the existing file.  
:: createfile|

:: endfile
:: endfile causes the system to add the wosc kill command to the cue output to clsoe it out.  Without this, the run program
:: never ends reading the file.  
:: endfile|


:: CUSTOMStartCue
:: CUSTOMStartCue is used to start a cue using a custom set of commands as follows:
:: 1) it calls createfile to open a new output cue file based on the name of the input cue file
:: 2) it renames the Main Stereo TRACK to "*" followed by the specified Cue name to indicate to you that this is running
:: 3) it sets the Delay value
:: CUSTOMStartCue|Cue Name|

:: CUSTOMEndCue
:: CUSTOMEndCue is used to end a cue using a custom set of commands as follows:
:: 1) it renames the Main Stereo TRACK to the specified Cue name to indicate to you that this is completed
:: 2) it writes a kill command for wosc to end with
:: CUSTOMEndCue|Cue Name|


:: TRACKMUTE
:: TRACKMUTE to Mute or Unmute a TRACK
:: TRACKMUTE|myTrackVar's name|MUTE or UNMUTE|


:: SETLATESTDCA
:: SETLATESTDCA sets the latest DCA to the specified DCA
:: SETLATESTDCA|TagVar's name or xxx for not having one|myTrackVar for the DCA|Name to set on the DCA Track

:: SETTRACKTOLATESTDCA
:: SETTRACKTOLATESTDCA sets the specified Track to have the Tag from the SETLATESTDCA value
::  it sets the tags according to the TagVar in SETLATESTDCA and 
::  if the Tag content is xxx  then it mutes the track and turns off the LED (and removes all tags)  
::  otherwise, it does set the tags according to the TagVar in SETLATESTDCA and turns on the LED and Unmutes the specified track
:: SETTRACKTOLATESTDCA|myTrackVar's name|


:: TRACKPOSTINS
:: TRACKPOSTINS to assign the post insert for a channel
:: TRACKPOSTINS|myTrackVar's name|MUTE or UNMUTE|FX or AUTO_X or AUTO_Y|

:: TRACK_GATE_ON
:: TRACK_GATE_ON to enable the Gate insert for a channel
:: TRACK_GATE_ON|myTrackVar's name|

:: TRACK_GATE_OFF
:: TRACK_GATE_OFF to disable the Gate insert for a channel
:: TRACK_GATE_OFF|myTrackVar's name|

:: TRACK_EQ_ON
:: TRACK_EQ_ON to enable the EQ insert for a channel
:: TRACK_eQ_ON|myTrackVar's name|

:: TRACK_EQ_OFF
:: TRACK_EQ_OFF to disable the EQ insert for a channel
:: TRACK_EQ_OFF|myTrackVar's name|

:: TRACK_DYN_ON
:: TRACK_DYN_ON to enable the DYN insert for a channel
:: TRACK_DYN_ON|myTrackVar's name|

:: TRACK_DYN_OFF
:: TRACK_DYN_OFF to disable the DYN insert for a channel
:: TRACK_DYN_OFF|myTrackVar's name|

:: TRACK_PREINS_ON
:: TRACK_PREINS_ON to enable the PREINS insert for a channel
:: TRACK_PREINS_ON|myTrackVar's name|

:: TRACK_PREINS_OFF
:: TRACK_PREINS_OFF to disable the PREINS insert for a channel
:: TRACK_PREINS_OFF|myTrackVar's name|

:: TRACK_POSTINS_ON
:: TRACK_POSTINS_ON to enable the POSTINS insert for a channel
:: TRACK_POSTINS_ON|myTrackVar's name|

:: TRACK_POSTINS_OFF
:: TRACK_POSTINS_OFF to disable the POSTINS insert for a channel
:: TRACK_POSTINS_OFF|myTrackVar's name|

:: TRACKNAME
:: TRACKNAME to name a TRACK
:: TRACKNAME|myTrackVar's name|name|

:: TRACKCOLOR
:: TRACKCOLOR to set a TRACKcolor, values are:
::	LIGHTBLUE, etc.
:: TRACKCOLOR|myTrackVar's name|color|

set myColor.MEDIUMBLUE=1
set myColor.BRIGHTBLUE=2
set myColor.VIOLET=3
set myColor.TURQUOISE=4
set myColor.GREEN=5
set myColor.OLIVEGREEN=6
set myColor.YELLOW=7
set myColor.BROWN=8
set myColor.RED=9
set myColor.CORAL=10
set myColor.PINK=11
set myColor.DARKVIOLET=12
set myColor.GOLD=13
set myColor.LIGHTBLUE=14
set myColor.TANGERINE=15
set myColor.LIGHTGREEN=16
set myColor.GRAY=17
set myColor.WHITE=18



:: TRACKICON
:: TRACKICON to set an icon number
:: TRACKICON|myTrackVar's name|icon number|


:: TRACKLED
:: TRACKLED to set the led on or off
:: TRACKLED|myTrackVar's name|ON or OFF|


:: TRACKPAN
:: TRACKPAN to set to -100 to 100 for pan
:: TRACKPAN|myTrackVar's name|number|


:: TRACKPROC
:: TRACKPROC to set to GEDI in the desired order for processing
:: TRACKPROC|myTrackVar's name|TEXT|


:: TRACKTAG
:: TRACKTAG to set tyhe tags for a track
:: TRACKTAG|myTrackVar's name|myTagVar's name|

:: TRACKMODE
:: TRACKMODE to set to ST or M or M/S in the desired order for processing
:: TRACKMODE|myTrackVar's name|TEXT|

:: TRACKTAGMUTE
:: TRACKTAGMUTE to set a tag on a track and mute or unmute the track
:: TRACKTAGMUTE|myTrackVar's name|myTagVar's name|MUTE or UNMUTE|


:: It is recommended that the track be muted before changing the group and/or in values
:: TRACKGROUPIN
:: TRACKGROUPIN specifies a text GROUP connection name and an integer IN number from that group
:: TRACKGROUPIN|myTrackVar's name|myCONNVar's name|


:: TRACKSEND
:: TRACKSEND to mute or unmute the TRACK's send to the specified BUS.
:: TRACKSEND|myTrackVar's Name|Send To Name|MUTE or UNMUTE|


:: SENDand_UNMUTE
:: SENDand_UNMUTE to mute or unmute SENDS and then UNMUTE the TRACK
:: SENDand_UNMUTE|myTrackVar's Name|mySend's Name|

:: SENDand_MUTE
:: SENDand_MUTE MUTE the TRACK and then mute or unmute SENDS 
:: SENDand_MUTE|myTrackVar's Name|mySend's Name|


:: USB_PLAY
:: USB_PLAY controls the playing of the USB Recorder
:: USB_PLAY|STOP or PLAY or PAUSE or NEXT or PREV or PLAYFILE


:: USB_PLAYFILE
:: USB_PLAYFILE sets the name to play when PLAYFILE is sent
:: USB_PLAYFILE|full file name|

:: USB_RECORD
:: USB_RECORD controls the recording of the USB Recorder
:: USB_RECORD|STOP or REC or PAUSE or NEXT or NEWFILE|

:: LIVE_RECORDER
:: LIVE_RECORDER controls the Live Card Recorder
:: LIVE_RECORDER|1 or 2|STOP or PLAY or PPAUSE or RECORD|

:: LOADSCENE
:: LOADSCENE to load a scene
:: LOADSCENE|Scene Tag Number|

:: NAVSCENE
:: NAVSCENE to load a scene
:: NAVSCENE|GOPREV or GONEXT or GO or PREV or NEXT|

:: AUTOMIXXON AUTOMIXXOFF AUTOMIXYON AUTOMIXYOFF
:: ... to turn the specified automix on or off
:: AUTOMIXXON or .... as listed above

:: --------------------------------------------
::  Three Related DCA handling Commands:

:: Custom_a_DCA_ONMUTED
:: Custom_a_DCA_ONMUTED is a custom code area used to set up a DCA track (or other track)
::  it sets the Track's Name to the specified text
::  it turns the Track's LED off
::  it mutes the track
::  -commented out-sets color YELLOW
:: Custom_a_DCA_ONMUTED|MyTrackVar's Name|text|

:: Custom_a_DCA_ONUNMUTED
:: Custom_a_DCA_ONUNMUTED is a custom code area used to set up a DCA track (or other track)
::  it sets the Track's Name to the specified text
::  it turns the Track's LED on
::  it unmutes the track
:: -commented out-sets color YELLOW
:: Custom_a_DCA_ONUNMUTED|MyTrackVar's Name|text|

:: Custom_a_DCA_OFF
:: Custom_a_DCA_OFF is a custom code area used to set up a DCA track (or other track)
::           but in an specific state.
::  it sets the Track's Name to "."
::  it turns the Track's LED off
::  it mutes the track
::  -commented out- sets color Dark Blue
::   since text is ignored you can just change the command from a text matching 
::   the Custom_a_DCA_ONMUTED or Custom_a_DCA_ONUNMUTED commands
:: Custom_a_DCA_OFF|MyTrackVar's Name|text{but text is ignored}|

:: --------------------------------------------
::  Two Related Channel handling Commands:

:: Custom_a_CHAN_ON
:: Custom_a_CHAN_ON is a custom code area used to set up a channel track possibly
::  with AUTO MIX and with a DCA assignment
::  it sets the Track's Post Insert to the specified text (like FX or AUTO_X or AUTO_Y)
::  it turns the Track's Post Insert On
::  it sets the Track's LED on
::  it turns the Track's Post Insert On
::  it sets the Track's DCA tags to match the specified DCA Variable content
::  it runs the tracks through the SENDand_UNMUTE sequence based on the Send String content
::  it colors the track as indicated in COLOR
::  it names the track as indicated in TEXT
::  including that it unmutes the track
:: Custom_a_CHAN_ON|MyTrackVar's Name|MyDCAVar's Name|post insert text|MySendString name|COLOR|TEXT|

:: Custom_a_CHAN_OFF
:: Custom_a_CHAN_OFF is a custom code area used to set up a channel track possibly
::  with an "off" status...meaning:
::  it sets the Track's Post Insert to FX
::  it turns the Track's Post Insert On
::  it sets the Track's LED off
::  it sets the Track's DCA tags to match the "dcapark" DCA Variable content
::  it runs the tracks through the SENDand_MUTE sequence for "spark"
::  including that it mutes the track
::  although LED is off, COLOR is set to dark blue
::  it names the track as indicated in TEXT
::  the inclusion of and non-use of parameters makes it easier to keep editing cues and toggling
::  between these 2 custom commands.
:: Custom_a_CHAN_OFF|MyTrackVar's Name|MyDCAVar's Name{ignored}|post insert text {ignored}|MySendString name{ignored}|COLOR{ignored}|TEXT|

:: comment
:: comments begin with #|
 


:: The file extension defines the set of cues for a project
:: the generated commands will be placed in the same file name with OUT prior to the specified
:: extension being again added to the end of the file name

set myFileExtension=cuex



:: Now Define the identifiers for each TRACK

:: Each name is tied to one and only one TRACK number
:: The name is preceeded by myTrackVar.  Each name designation must be unique
:: or the last definition will be used.
:: The TRACK references are the TRACK on the device they are used on.
:: It is up to you to manage names and TRACK numbers.  The same numbers
:: can exist on different devices, but the names must be unique across
:: all of the devices you will be controlling.

:: types can be:
:: ch, aux, mtx, bus,main for general use
:: or can be of the form io/in/LCL (where LCL is an example) to impact an io/in or io/in/LCL (etc.) to impact and io/out 
:: note that all types do not support all commands, see the manual of OSC commands



set  myTrackVar.cGROUP1=1
set  myTrackVar.cGROUP1.type=ch

set  myTrackVar.cGROUP2=2
set  myTrackVar.cGROUP2.type=ch

set  myTrackVar.cGROUP3=3
set  myTrackVar.cGROUP3.type=ch

set  myTrackVar.cGROUP4=4
set  myTrackVar.cGROUP4.type=ch

set  myTrackVar.cCHOIR1=5
set  myTrackVar.cCHOIR1.type=ch

set  myTrackVar.cCHOIR1=5
set  myTrackVar.cCHOIR1.type=ch

set  myTrackVar.cCHOIR2=6
set  myTrackVar.cCHOIR2.type=ch

set  myTrackVar.cCHOIR3=7
set  myTrackVar.cCHOIR3.type=ch

set  myTrackVar.cCHOIR4=8
set  myTrackVar.cCHOIR4.type=ch

set  myTrackVar.cCHOIR5=9
set  myTrackVar.cCHOIR5.type=ch

set  myTrackVar.cCHOIR6=10
set  myTrackVar.cCHOIR6.type=ch

set  myTrackVar.cCHOIR7=11
set  myTrackVar.cCHOIR7.type=ch

set  myTrackVar.cCHOIR8=12
set  myTrackVar.cCHOIR8.type=ch

set  myTrackVar.cptKRISTY=13
set  myTrackVar.cptKRISTY.type=ch

set  myTrackVar.cptDIANNE=14
set  myTrackVar.cptDIANNE.type=ch

set  myTrackVar.cptKEITH=15
set  myTrackVar.cptKEITH.type=ch

set  myTrackVar.cptJAX=16
set  myTrackVar.cptJAX.type=ch


set  myTrackVar.cptTONY=17
set  myTrackVar.cptTONY.type=ch


set  myTrackVar.cptatPIANO=18
set  myTrackVar.cptatPIANO.type=ch

set  myTrackVar.cyuteKATE=19
set  myTrackVar.cyuteKATE.type=ch

set  myTrackVar.cyuteRIONA=20
set  myTrackVar.cyuteRIONA.type=ch

set  myTrackVar.cyuteMADDIE=21
set  myTrackVar.cyuteMADDIE.type=ch

set  myTrackVar.cyuteCHLOE=22
set  myTrackVar.cyuteCHLOE.type=ch

set  myTrackVar.cskitJOCLYN=23
set  myTrackVar.cskitJOCLYN.type=ch

set  myTrackVar.cskitAMALIA=24
set  myTrackVar.cskitAMALIA.type=ch

set  myTrackVar.cskitLOTTIE=25
set  myTrackVar.cskitLOTTIE.type=ch

set  myTrackVar.cskitCARSON=26
set  myTrackVar.cskitCARSON.type=ch

set  myTrackVar.cJAXWORN=27
set  myTrackVar.cJAXWORN.type=ch

set  myTrackVar.cPK1_CH1=28
set  myTrackVar.cPK1_CH1.type=ch

set  myTrackVar.cPK2_CH2=29
set  myTrackVar.cPK2_CH2.type=ch

set  myTrackVar.cPK3_CH3=30
set  myTrackVar.cPK3_CH3.type=ch

set  myTrackVar.cPK4_CH4=31
set  myTrackVar.cPK4_CH4.type=ch

set  myTrackVar.cPK5_CH5=32
set  myTrackVar.cPK5_CH5.type=ch

set  myTrackVar.cPK6_CH6=33
set  myTrackVar.cPK6_CH6.type=ch

set  myTrackVar.cPK7_CH7=34
set  myTrackVar.cPK7_CH7.type=ch

set  myTrackVar.cPK8_CH8=35
set  myTrackVar.cPK8_CH8.type=ch

set  myTrackVar.cyuteATPIANO2=36
set  myTrackVar.cyuteATPIANO2.type=ch

set  myTrackVar.cATPIANO3=37
set  myTrackVar.cATPIANO3.type=ch

set  myTrackVar.cCHAN38=38
set  myTrackVar.cCHAN38.type=ch

set  myTrackVar.cCHAN39=39
set  myTrackVar.cCHAN39.type=ch

set  myTrackVar.cCHAN40=40
set  myTrackVar.cCHAN40.type=ch

set  myTrackVar.bVOXVRB1=2
set  myTrackVar.bVOXVRB1.type=bus

set  myTrackVar.bVOXVRB2=3
set  myTrackVar.bVOXVRB2.type=bus



:: echo Processing cue files
::  ***********************************************************************************
::  ************  CUES ARE DEFINED HERE ***********************************************
::  ***********************************************************************************




:: set the cue subscript to the starting point to 0

set /a cuecount=0

	set usersays=n
	echo ***
	set /P usersays= *** Press ENTER to build all files or a Cue File Name (with extension) and press ENTER 
	echo *	
	echo YOU ENTERED: %usersays% 
	echo .	
	echo .
	echo .
	echo .
	echo .
	echo .
	echo .
	echo .
	echo .

	if %usersays% == n goto :ProcessAllFiles
	set /a cuecount=1
	set cuefile[1]=%usersays%
	goto :ProcessOneFile


:ProcessAllFiles
:: read in the list of file names based on extension

for %%f in (!prefix!*.!myFileExtension!) do (
	set /a cuecount+=1
	set cuefile[!cuecount!]="%%f"
)
:ProcessOneFile

echo .
echo There are !cuecount! cue files to process.
echo . 

:: *************************************** EACH CUE FILE ************************
set /a mycurfilenum=1
:: Loop for each file

:LoopForEachInputFile
:: echo mycurfilenum is !mycurfilenum!
set tempvar=!cuefile[%mycurfilenum%]!
set myLatestDCA=""
:: remove quotes
set tempvarx=%tempvar:"=%
:: echo .
:: echo Now expanding cue !mycurfilenum! content of file  !tempvarx!
set /A linecount=0
set theline=

for /F "delims=" %%a in (%tempvarx%) do (
    set /A linecount+=1
    set "theline[!linecount!]=%%a"
)

:: echo     There are %linecount% lines to process.
:: display content of the file
:: for /L %%i in (1,1,%linecount%) do echo     !theline[%%i]!



:: split up the lines and pass each line in for processing

:: ************************************ EACH LINE IN EACH FILE ********************



set /a mycurlinenum=1
:LoopForEachLine

set linetempvar=!theline[%mycurlinenum%]!
:: echo Now processing cue: !mycurfilenum! content of file: !tempvarx! line: !mycurlinenum! content: !linetempvar!

set parma="|"
set parmb="|"
set parmc="|"
set parmd="|"
set parme="|"
set parmf="|"
set parmg="|"



for /F "tokens=1,2,3,4,5,6,7,8,9,10 delims=^|" %%a in ("%linetempvar%")do (
		set parma=%%a
		set parmb=%%b
		set parmc=%%c
		set parmd=%%d
		set parme=%%e
		set parmf=%%f
		set parmg=%%g
)


:: echo "Parameters are:"
:: echo           a is !parma!
:: echo           b is !parmb!
:: echo           c is !parmc!
:: echo           d is !parmd!
:: echo           e is !parme!
:: echo           f is !parmf!
:: echo           g is !parmg!

:: **************THIS MAKES THE FILE****

call :BuildCueFile %myFileExtension%, %tempvarx%, %mycurlinenum%, %parma%, %parmb%, %parmc%, %parmd%, %parme%, %parmf%, %parmg%
:: ************  WROTE THE LINES *******


::cur is !mycurlinenum! count is !linecount!
set /a mycurlinenum=%mycurlinenum%+1

if %mycurlinenum% GTR %linecount% goto :endLoopForEachLine

goto :LoopForEachLine
:endLoopForEachLine


:: *********************************** END EACH LINE IN EACH FILE *****************




set /a mycurfilenum+=1


if %mycurfilenum% GTR %cuecount% goto :endLoopForEachInputFile
goto :LoopForEachInputFile
:endLoopForEachInputFile
:: ************************************ END EACH CUE FILE ******************************'



:: ************************************************************************************
:: ********  ALL IS NOW SET UP   ***********************************
:: ************************************************************************************



exit /B 0
::*************************************************************************************
::*** THE CUE IS PROCESSED !!!!!  *****************************************************
::*************************************************************************************


:: *********************************************************
::    BuildCueFile --ROUTINE TO BUILD CUE INFO 
:: ********************************************************
:BuildCueFile

set buildtempExt=%~1
set buildtempFile=%~2
set buildtempFileLine=%~3
set buildtempCmd=%~4
set buildtempVarB=%~5
set buildtempVarC=%~6
set buildtempVarD=%~7
set buildtempVarE=%~8
set buildtempVarF=%~9
shift
set buildtempVarG=%~9


:: the extension for the file name includes OUT before the ext so add it once here

set buildtempOutExt=OUT%buildtempExt%

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!


if %buildtempCmd% EQU # goto :endbuildfile


set buildtempDeviceLetter=%buildtempFile:~0,1%

:: now pull device type and delay

set tempvartype=%%Type.!buildtempDeviceLetter!%%
call set buildtempDeviceType=!!tempvartype!!


set tempvardelay=%%Delay.!buildtempDeviceLetter!%%
call set buildtempDeviceDelay=!!tempvardelay!!

set mytempvarc=%%mySend.!buildtempVarC!%%
call set buildtempSendString=!!mytempvarc!!

	
:: pick a flavor and process accordingly

if %buildtempDeviceType% EQU WING goto :BuildWINGCueContent



goto :endbuildfile





:BuildWINGCueContent


::  ****************** Use WING syntax ******************

if %buildtempCmd% EQU SETLATESTDCA goto :buildSETLATESTDCA
if %buildtempCmd% EQU SETTRACKTOLATESTDCA goto :buildSETTRACKTOLATESTDCA

if %buildtempCmd% EQU TRACKMUTE goto :buildTRACKMUTE
if %buildtempCmd% EQU TRACKNAME goto :buildTRACKNAME
if %buildtempCmd% EQU TRACKCOLOR goto :buildTRACKCOLOR
if %buildtempCmd% EQU TRACKTAG goto :buildTRACKTAG
if %buildtempCmd% EQU TRACKTAGMUTE goto :buildTRACKTAGMUTE

if %buildtempCmd% EQU TRACKSEND goto :buildTRACKSEND
if %buildtempCmd% EQU TRACKPOSTINS goto :buildTRACKPOSTINS
if %buildtempCmd% EQU TRACKICON goto :buildTRACKICON
if %buildtempCmd% EQU TRACKLED goto :buildTRACKLED
if %buildtempCmd% EQU TRACKPAN goto :buildTRACKPAN
if %buildtempCmd% EQU TRACKPROC goto :buildTRACKPROC
if %buildtempCmd% EQU TRACKMODE goto :buildTRACKMODE
if %buildtempCmd% EQU TRACKGROUPIN goto :buildTRACKGROUPIN

if %buildtempCmd% EQU Custom_a_DCA_ONMUTED goto :buildCUSTOMADCAONMUTED
if %buildtempCmd% EQU Custom_a_DCA_ONUNMUTED goto :buildCUSTOMADCAONUNMUTED
if %buildtempCmd% EQU Custom_a_DCA_OFF goto :buildCUSTOMADCAOFF
if %buildtempCmd% EQU Custom_a_CHAN_ON goto :buildCUSTOMACHANON
if %buildtempCmd% EQU Custom_a_CHAN_OFF goto :buildCUSTOMACHANOFF

if %buildtempCmd% EQU TRACK_GATE_ON goto :buildTRACKGATEON
if %buildtempCmd% EQU TRACK_GATE_OFF goto :buildTRACKGATEOFF
if %buildtempCmd% EQU TRACK_EQ_ON goto :buildTRACKEQON
if %buildtempCmd% EQU TRACK_EQ_OFF goto :buildTRACKEQOFF
if %buildtempCmd% EQU TRACK_DYN_ON goto :buildTRACKDYNON
if %buildtempCmd% EQU TRACK_DYN_OFF goto :buildTRACKDYNOFF
if %buildtempCmd% EQU TRACK_PREINS_ON goto :buildTRACKPREINSON
if %buildtempCmd% EQU TRACK_PREINS_OFF goto :buildTRACKPREINSOFF
if %buildtempCmd% EQU TRACK_POSTINS_ON goto :buildTRACKPOSTINSON
if %buildtempCmd% EQU TRACK_POSTINS_OFF goto :buildTRACKPOSTINSOFF



if %buildtempCmd% EQU USB_RECORD goto :buildUSB_RECORD
if %buildtempCmd% EQU USB_PLAY goto :buildUSB_PLAY
if %buildtempCmd% EQU USB_PLAYFILE goto :buildUSB_PLAYFILE

if %buildtempCmd% EQU LIVE_RECORDER goto :buildLIVERECORDER

if %buildtempCmd% EQU createfile goto :buildCREATEFILE
if %buildtempCmd% EQU endfile goto :buildENDFILE

if %buildtempCmd% EQU CUSTOMStartCue goto :buildCUSTOMStartCue
if %buildtempCmd% EQU CUSTOMEndCue goto :buildCustomEndCue

if %buildtempCmd% EQU SENDand_MUTE goto :buildSENDandMUTE
if %buildtempCmd% EQU SENDand_UNMUTE goto :buildSENDandUNMUTE


if %buildtempCmd% EQU LOADSCENE goto :buildLOADSCENE
if %buildtempCmd% EQU NAVSCENE goto :buildNAVSCENE

if %buildtempCmd% EQU AUTOMIXXON goto :buildAUTOMIXXON
if %buildtempCmd% EQU AUTOMIXYON goto :buildAUTOMIXYON
if %buildtempCmd% EQU AUTOMIXXOFF goto :buildAUTOMIXXOFF
if %buildtempCmd% EQU AUTOMIXYOFF goto :buildAUTOMIXYOFF

echo ***************** UNKNOWN COMMAND RECEIVED ******************************
echo %buildtempCMD%
echo *************************************************************************
goto :endbuildfile

:: **********************************************Process the "SETLATESTDCA" command
::echo on

:buildSETLATESTDCA
:: Find the TAG Value for the name provided in VarB
set tempvarb=%%myTAGVar.!buildtempVarB!%%



call set myLatestDCA=!!tempvarb!!


if %buildtempVarB% EQU xxx (
set myLatestDCA=xxx
	goto :endbuildfile
)

if not defined tempvarb (
	color 04
	echo %buildtempVarB% is not a valid TAG name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

:: Find the TRACK Number for the name provided in VarC

set tempvarc=%%myTrackVar.!buildtempVarC!%%
call set buildtempTRACKNum=!!tempvarc!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarC% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvard=%%myTrackVar.!buildtempVarC!.type%%
call set buildtempTRACKType=!!tempvard!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarC% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/name ,s "%buildtempVarD%" >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile

:: **********************************************Process the "SETTRACKTOLATESTDCA command

:: the SETTRACKTOLATESTDCA command is easy...look up values and set it


:buildSETTRACKTOLATESTDCA
set tempvarb=%%myTrackVar.!buildtempVarB!%%

:: Find the TRACK Number for the name provided in VarB

call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)



set tempvard=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvard!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
::echo what %myLatestDCA%
if %myLatestDCA% EQU xxx (
::echo HERE
	goto :xxxbuildSETTRACKTOLATESTDCA
)

if not defined myLatestDCA (
	color 04
	echo %myLatestDCA% is not a valid TAG name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
	
        echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute ,i 0 >> %buildtempFile%.%buildtempOutExt%
        echo /%buildtempTRACKType%/%buildtempTRACKNum%/led ,i 1 >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/tags ,s %myLatestDCA% >> %buildtempFile%.%buildtempOutExt%



goto :endbuildfile

:xxxbuildSETTRACKTOLATESTDCA
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute ,i 1 >> %buildtempFile%.%buildtempOutExt%
        echo /%buildtempTRACKType%/%buildtempTRACKNum%/led ,i 0 >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/tags ,s "" >> %buildtempFile%.%buildtempOutExt%

        goto :endbuildfile




:: **********************************************Process the "TRACKMUTE" command

:: the TRACK command is easy...just mute or unmute the TRACK and you are done


:buildTRACKMUTE
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)


:: echo TRACK num is %buildtempTRACKNum%

if %buildtempVarC% EQU MUTE (
::	echo MUTE FOUND
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarC% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %myFOUNDIT% EQU 0 (
	color 04
	echo %buildtempVarC% is not a valid value!
	echo BUILDING CUE WITH THIS INFO:
	echo	Ext: 		%buildtempExt%
	echo	File:		%buildtempFile%
	echo	FileLine:	%buildtempFileLine%
	echo	Cmd:		%buildtempCmd%
	echo	VarB:		%buildtempVarB%
	echo	VarC:		%buildtempVarC%
	echo	VarD:		%buildtempVarD%
	echo	VarE:		%buildtempVarE%
	echo .
)

goto :endbuildfile




:: **********************************************Process the "TRACKNAME" command

:: the TRACKNAME command is easy...just name the TRACK and you are done


:buildTRACKNAME

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)



:: echo TRACK num is %buildtempTRACKNum%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/name ,s "%buildtempVarC%" >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile


:: **********************************************Process the "TRACKCOLOR" command

:: the TRACKNAME command is easy...just color the TRACK and you are done


:buildTRACKCOLOR

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

:: Find the Color for the name proivided in VarC

set tempvarc=%%myColor.!buildtempVarC!%%
call set buildtempColor=!!tempvarc!!

if not defined buildtempColor (
	color 04
	echo %buildtempVarC% is not a valid color name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvard=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvard!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)


echo /%buildtempTRACKType%/%buildtempTRACKNum%/col ,i %buildtempColor% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile


:: **********************************************Process the "TRACKTAG command

:: the TRACKTAG command is easy...look up values and set it


:buildTRACKTAG

:: Find the TRACK Number for the name provided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)


:: Find the TAG Value for the name provided in VarC
set tempvarc=%%myTAGVar.!buildtempVarC!%%
call set buildtempTAGNum=!!tempvarc!!

if not defined buildtempTAGNum (
	color 04
	echo %buildtempVarC% is not a valid TAG name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvard=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvard!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/tags ,s %buildtempTAGNum% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile

:: **********************************************Process the "TRACKTAGMUTE command

:: the TRACKTAGMUTE command is easy...look up values and set it


:buildTRACKTAGMUTE
set myFOUNDIT=0
:: Find the TRACK Number for the name provided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)


:: Find the TAG Value for the name provided in VarC
set tempvarc=%%myTAGVar.!buildtempVarC!%%
call set buildtempTAGNum=!!tempvarc!!

if not defined buildtempTAGNum (
	color 04
	echo %buildtempVarC% is not a valid TAG name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvard=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvard!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/tags ,s %buildtempTAGNum% >> %buildtempFile%.%buildtempOutExt%




if %buildtempVarD% EQU MUTE (
::	echo MUTE FOUND
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarD% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %myFOUNDIT% EQU 0 (
	color 04
	echo %buildtempVarD% is not a valid value!
	echo BUILDING CUE WITH THIS INFO:
	echo	Ext: 		%buildtempExt%
	echo	File:		%buildtempFile%
	echo	FileLine:	%buildtempFileLine%
	echo	Cmd:		%buildtempCmd%
	echo	VarB:		%buildtempVarB%
	echo	VarC:		%buildtempVarC%
	echo	VarD:		%buildtempVarD%
	echo	VarE:		%buildtempVarE%
	echo .
)






goto :endbuildfile



:: **********************************************Process the "TRACKICON" command


:buildTRACKICON


:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/icon ,i %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile

:: **********************************************Process the "TRACKLED" command



:buildTRACKLED
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)


if %buildtempVarC% EQU ON (
::	echo MUTE FOUND
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/led ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarC% EQU OFF (
::	echo UNMUTE FOUND
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/led ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %myFOUNDIT% EQU 0 (
	color 04
	echo %buildtempVarC% is not a valid value!
	echo BUILDING CUE WITH THIS INFO:
	echo	Ext: 		%buildtempExt%
	echo	File:		%buildtempFile%
	echo	FileLine:	%buildtempFileLine%
	echo	Cmd:		%buildtempCmd%
	echo	VarB:		%buildtempVarB%
	echo	VarC:		%buildtempVarC%
	echo	VarD:		%buildtempVarD%
	echo	VarE:		%buildtempVarE%
	echo .
)

goto :endbuildfile


:: **********************************************Process the "TRACKPAN" command


:buildTRACKPAN


:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/pan ,f %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile

:: **********************************************Process the "TRACKPROC" command


:buildTRACKPROC


:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/proc ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile

:: **********************************************Process the "TRACKMODE" command


:buildTRACKMODE


:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/mode ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile

:: **********************************************Process the "TRACKGROUPIN" command


:buildTRACKGROUPIN


:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvard=%%myCONNVar.!buildtempVarC!.type%%
call set buildtempCONNType=!!tempvard!!

if not defined buildtempCONNType (
	color 04
	echo %buildtempVarB% does not have a CONN TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvare=%%myCONNVar.!buildtempVarC!.num%%
call set buildtempCONNNum=!!tempvare!!

if not defined buildtempCONNType (
	color 04
	echo %buildtempVarB% does not have a CONN Num!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)



	echo /%buildtempTRACKType%/%buildtempTRACKNum%/in/conn/grp ,s %buildtempCONNType% >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/in/conn/in ,i %buildtempCONNNum% >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile




:: **********************************************Process the "TRACKSEND" command

:: the TRACKSEND command is easy...just mute or unmute the TRACK send and you are done


:buildTRACKSEND
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvard=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvard!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)


:: Find the Bus Number for the name proivided in VarC

set tempvarc=%%myTrackVar.!buildtempVarC!%%
call set buildtempBusNum=!!tempvarC!!

if not defined buildtempBusNum (
	color 04
	echo %buildtempVarC% is not a valid Track name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)


if %buildtempVarD% EQU MUTE (
::	echo MUTE FOUND
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/send/%buildtempBusNum%/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarD% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/send/%buildtempBusNum%/on  ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %myFOUNDIT% EQU 0 (
	color 04
	echo %buildtempVarD% is not a valid value!
	echo BUILDING CUE WITH THIS INFO:
	echo	Ext: 		%buildtempExt%
	echo	File:		%buildtempFile%
	echo	FileLine:	%buildtempFileLine%
	echo	Cmd:		%buildtempCmd%
	echo	VarB:		%buildtempVarB%
	echo	VarC:		%buildtempVarC%
	echo	VarD:		%buildtempVarD%
	echo	VarE:		%buildtempVarE%
	echo .
)

goto :endbuildfile



:: **********************************************Process the "AUTOMIXXON" command

:: just set the value


:buildAUTOMIXXON

	echo /cfg/amix/x ,i 1 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile

:: **********************************************Process the "AUTOMIXYON" command

:: just set the value


:buildAUTOMIXYON

	echo /cfg/amix/y ,i 1 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile
:: **********************************************Process the "AUTOMIXXOFF" command

:: just set the value


:buildAUTOMIXXOFF

	echo /cfg/amix/x ,i 0 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile

:: **********************************************Process the "AUTOMIXYOFF" command

:: just set the value


:buildAUTOMIXYOFF

	echo /cfg/amix/y ,i 0 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile



:: **********************************************Process the "USB_RECORD" command

:: the USB_RECORD command is easy...just set the value


:buildUSB_RECORD

	echo /rec/$action ,s %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile

:: **********************************************Process the "USB_PLAY" command

:: the USB_PLAY command is easy...just set the value


:buildUSB_PLAY

	echo /play/$action ,s %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile


:: **********************************************Process the "USB_PLAYFILE" command

:: the USB_PLAYFILE command is easy...just set the value


:buildUSB_PLAYFILE

	echo /play/$playfile ,s %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%
	echo /play/$action ,s PLAYFILE >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile


:: **********************************************Process the "LIVE_RECORDER" command

:: the LIVE_RECORDER command is easy...just  set the value


:buildLIVERECORDER


	echo /cards/wlive/%buildtempVarB%/control ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile


:: **********************************************Process the "SENDand_UNMUTE" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not TRACKge the send, increments position counter
::   * terminates the string processing



:buildSENDandUNMUTE


set mytempvarc=%%mySend.!buildtempVarC!%%
call set buildtempSendString=!!mytempvarc!!

if not defined buildtempSendString (
	color 04
	echo %buildtempSendString% is not a valid send string name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .

)

set tempvard=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvard!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set /a mySendPosition=1
set /a myCharacterInString=0






:buildsendlooperB
set derivedSendPosition=%mySendPosition%
:: now for x32 the OSC requires a 2 digit track number so add leading 0 if needed
::if %mySendPosition% LSS 10 set derivedSendPosition=0%mySendPosition%

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperB
)
if "%buildtempchar%" EQU "1" (
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperB
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperB
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildsendlooperB
)
if "%buildtempchar%" EQU "*" (
	:: unmute the TRACK
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute ,i 0 >> %buildtempFile%.%buildtempOutExt%

	goto :endbuildfile
)

goto :endbuildfile


:: **********************************************Process the "SENDand_MUTE" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not TRACKge the send, increments position counter
::   * terminates the string processing


:buildSENDandMUTE

set mytempvarc=%%mySend.!buildtempVarC!%%
call set buildtempSendString=!!mytempvarc!!

if not defined buildtempSendString (
	color 04
	echo %buildtempSendString% is not a valid send string name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvard=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvard!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set /a mySendPosition=1
set /a myCharacterInString=0

:: mute the TRACK
echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute ,i 1 >> %buildtempFile%.%buildtempOutExt%

:buildsendlooperC
set derivedSendPosition=%mySendPosition%
:: now for x32 the OSC requires a 2 digit track number so add leading 0 if needed
:: if %mySendPosition% LSS 10 set derivedSendPosition=0%mySendPosition%

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperC
)
if "%buildtempchar%" EQU "1" (
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperC
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperC
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildsendlooperC
)
if "%buildtempchar%" EQU "*" (

	goto :endbuildfile
)

goto :endbuildfile



:: **********************************************Process the "createfile" command

:: create an empty cue file so later output can just worry about appending to it
:buildCREATEFILE
	type NUL > %buildtempFile%.%buildtempOutExt%
	echo time %buildtempDeviceDelay% >> %buildtempFile%.%buildtempOutExt%

	echo Now building file %buildtempFile%.%buildtempOutExt%
	goto :endbuildfile



:: **********************************************Process the "CUSTOMStartCue" command


:buildCUSTOMStartCue

type NUL > %buildtempFile%.%buildtempOutExt%
echo Created file %buildtempFile%.%buildtempOutExt%
echo time %buildtempDeviceDelay% >> %buildtempFile%.%buildtempOutExt%
echo /mtx/8/name ,s "*%buildtempVarB%" >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile

:: **********************************************Process the "endfile" command

:: ends the wosc process of the file
:buildENDFILE
	echo kill >> %buildtempFile%.%buildtempOutExt%
	type NUL >> %buildtempFile%.%buildtempOutExt%

	echo Ended file %buildtempFile%.%buildtempOutExt%
	goto :endbuildfile


:: **********************************************Process the "CUSTOMEndCue" command


:buildCUSTOMEndCue


echo /mtx/8/name ,s "%buildtempVarB%" >> %buildtempFile%.%buildtempOutExt%
echo kill>> %buildtempFile%.%buildtempOutExt%
type NUL>> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile





:: **********************************************Process the "LOADSCENE" command

:buildLOADSCENE

echo /$ctl/lib/$actionidx ,i %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%
echo /$ctl/lib/$action ,s GOTAG >> %buildtempFile%.%buildtempOutExt%
echo /$ctl/lib/$actionidx ,i 0 >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile


:: **********************************************Process the "NAVSCENE" command

:buildNAVSCENE

echo /$ctl/lib/$actionidx ,i 0 >> %buildtempFile%.%buildtempOutExt%
echo /$ctl/lib/$action ,s %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile




:: **********************************************Process the "TRACKPOSTINS" command

:: the TRACKPOSTINS command is easy...just mute or unmute the TRACK and set the value and you are done


:buildTRACKPOSTINS
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)


:: echo TRACK num is %buildtempTRACKNum%

if %buildtempVarC% EQU MUTE (
::	echo MUTE FOUND
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/postins/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarC% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/postins/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %myFOUNDIT% EQU 0 (
	color 04
	echo %buildtempVarC% is not a valid value!
	echo BUILDING CUE WITH THIS INFO:
	echo	Ext: 		%buildtempExt%
	echo	File:		%buildtempFile%
	echo	FileLine:	%buildtempFileLine%
	echo	Cmd:		%buildtempCmd%
	echo	VarB:		%buildtempVarB%
	echo	VarC:		%buildtempVarC%
	echo	VarD:		%buildtempVarD%
	echo	VarE:		%buildtempVarE%
	echo .
)
set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/postins/mode ,s %buildtempVarD% >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile

:: **********************************************Process the "TRACK_GATE_ON" command

:: the TRACK_GATE_ON command is easy...just  unmute the GATE for the specified TRACK


:buildTRACKGATEON
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
:: echo TRACK num is %buildtempTRACKNum%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/gate/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildfile

:: **********************************************Process the "TRACK_GATE_OFF" command

:: the TRACK_GATE_OFF command is easy...just  mute the GATE for the specified TRACK


:buildTRACKGATEOFF
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
:: echo TRACK num is %buildtempTRACKNum%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/gate/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildfile

:: **********************************************Process the "TRACK_EQ_ON" command

:: the TRACK_EQ_ON command is easy...just  unmute the EQ for the specified TRACK


:buildTRACKEQON
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
:: echo TRACK num is %buildtempTRACKNum%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/eq/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildfile

:: **********************************************Process the "TRACK_EQ_OFF" command

:: the TRACK_EQ_OFF command is easy...just mute the EQ for the specified TRACK


:buildTRACKEQOFF
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
:: echo TRACK num is %buildtempTRACKNum%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/eq/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildfile

:: **********************************************Process the "TRACK_DYN_ON" command

:: the TRACK_DYN_ON command is easy...just  unmute the DYN for the specified TRACK


:buildTRACKDYNON
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
:: echo TRACK num is %buildtempTRACKNum%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/dyn/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildfile

:: **********************************************Process the "TRACK_DYN_OFF" command

:: the TRACK_DYN_OFF command is easy...just mute the DYN for the specified TRACK


:buildTRACKDYNOFF
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
:: echo TRACK num is %buildtempTRACKNum%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/dyn/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildfile

:: **********************************************Process the "TRACK_PREINS_ON" command

:: the TRACK_PREINS_ON command is easy...just  unmute the PREINS for the specified TRACK


:buildTRACKPREINSON
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
:: echo TRACK num is %buildtempTRACKNum%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/preins/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildfile

:: **********************************************Process the "TRACK_PREINS_OFF" command

:: the TRACK_PREINS_OFF command is easy...just mute the PREINS for the specified TRACK


:buildTRACKPREINSOFF
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
:: echo TRACK num is %buildtempTRACKNum%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/preins/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildfile

:: **********************************************Process the "TRACK_POSTINS_ON" command

:: the TRACK_POSTINS_OFF command is easy...just  unmute the POSTINS for the specified TRACK


:buildTRACKPOSTINSON
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
:: echo TRACK num is %buildtempTRACKNum%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/postins/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildfile

:: **********************************************Process the "TRACK_POSTINS_OFF" command

:: the TRACK_POSTINS_OFF command is easy...just mute the POSTINS for the specified TRACK


:buildTRACKPOSTINSOFF
set myFOUNDIT=0

:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
:: echo TRACK num is %buildtempTRACKNum%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/postins/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildfile

:: ---------------------- CUSTOM STUFF ---------------------------------


:: **********************************************Process the "Custom_a_DCA_ONMUTED command

:: Like TRACKNAME set to provided  - TRACKLED set ON - TRACKMUTE set MUTED
:: for a DCA Track


:buildCUSTOMADCAONMUTED

:: Find the TRACK Number for the name provided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)


set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/name ,s "%buildtempVarC%" >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/led ,i 1 >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute ,i 1 >> %buildtempFile%.%buildtempOutExt%
::      echo /%buildtempTRACKType%/%buildtempTRACKNum%/col ,i 7 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile


:: **********************************************Process the "Custom_a_DCA_ONUNMUTED command

:: Like TRACKNAME set to provided  - TRACKLED set ON - TRACKMUTE set UNMUTED
:: for a DCA Track


:buildCUSTOMADCAONUNMUTED

:: Find the TRACK Number for the name provided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)


set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/name ,s "%buildtempVarC%" >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/led ,i 1 >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute ,i 0 >> %buildtempFile%.%buildtempOutExt%
::      echo /%buildtempTRACKType%/%buildtempTRACKNum%/col ,i 7 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile

:: **********************************************Process the "Custom_a_DCA_OFF command

:: Like TRACKNAME set to "."  - TRACKLED set OFF - TRACKMUTE set MUTED
:: for a DCA Track


:buildCUSTOMADCAOFF

:: Find the TRACK Number for the name provided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)


set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .
)
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/name ,s "." >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/led ,i 0 >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute,i 1 >> %buildtempFile%.%buildtempOutExt%
::      echo /%buildtempTRACKType%/%buildtempTRACKNum%/col ,i 3 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile

:: **********************************************Process the "Custom_a_CHAN_ON command

:: Like TRACKNAME set to "."  - TRACKPOSTINS set automix value - TRACKTAG set to tag value - SEND AND UNMUTE based on a string



:buildCUSTOMACHANON

:: Find the TRACK Number for the name provided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo	VarF:		%buildtempVarF%
echo	VarG:		%buildtempVarG%
echo .
)





set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo	VarF:		%buildtempVarF%
echo	VarG:		%buildtempVarG%
echo .
)

:: Find the TAG Value for the name provided in VarC
set tempvard=%%myTAGVar.!buildtempVarC!%%
call set buildtempTAGNum=!!tempvard!!

if not defined buildtempTAGNum (
	color 04
	echo %buildtempVarC% is not a valid TAG name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo	VarF:		%buildtempVarF%
echo	VarG:		%buildtempVarG%
echo .
)




	echo /%buildtempTRACKType%/%buildtempTRACKNum%/led ,i 1 >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/postins/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/postins/mode ,s %buildtempVarD% >> %buildtempFile%.%buildtempOutExt%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/tags ,s %buildtempTAGNum% >> %buildtempFile%.%buildtempOutExt%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/name ,s "%buildtempVarG%" >> %buildtempFile%.%buildtempOutExt%




:: COLOR
:: Find the Color for the name proivided in VarF

set tempvarf=%%myColor.!buildtempVarF!%%
call set buildtempColor=!!tempvarf!!

if not defined buildtempColor (
	color 04
	echo %buildtempVarF% is not a valid color name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo	VarF:		%buildtempVarF%
echo	VarG:		%buildtempVarG%
echo .
)

echo /%buildtempTRACKType%/%buildtempTRACKNum%/col ,i %buildtempColor% >> %buildtempFile%.%buildtempOutExt%

:: END COLOR



set mytempvare=%%mySend.!buildtempVarE!%%
call set buildtempSendString=!!mytempvare!!

if not defined buildtempSendString (
	color 04
	echo %buildtempSendString% is not a valid send string name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo	VarF:		%buildtempVarF%
echo	VarG:		%buildtempVarG%
echo .

)

set /a mySendPosition=1
set /a myCharacterInString=0






:buildsendlooperB
set derivedSendPosition=%mySendPosition%
:: now for x32 the OSC requires a 2 digit track number so add leading 0 if needed
::if %mySendPosition% LSS 10 set derivedSendPosition=0%mySendPosition%

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperB
)
if "%buildtempchar%" EQU "1" (
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperB
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperB
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildsendlooperB
)
if "%buildtempchar%" EQU "*" (
	:: unmute the TRACK
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute ,i 0 >> %buildtempFile%.%buildtempOutExt%

	goto :endbuildfile
)


goto :endbuildfile
:: **********************************************Process the "Custom_a_CHAN_OFF command

:: Like TRACKNAME set to "."  - TRACKPOSTINS set automix value to FX - TRACKTAG set to tag dcapark - SEND AND MUTE based on spark



:buildCUSTOMACHANOFF


set  %buildtempVarC=dcapark
set  %buildtempVarD=FX
set  %buildtempVarE=spark

:: Find the TRACK Number for the name provided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if not defined buildtempTRACKNum (
	color 04
	echo %buildtempVarB% is not a valid TRACK name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo	VarF:		%buildtempVarF%
echo	VarG:		%buildtempVarG%
echo .
)


set tempvarc=%%myTrackVar.!buildtempVarB!.type%%
call set buildtempTRACKType=!!tempvarc!!

if not defined buildtempTRACKType (
	color 04
	echo %buildtempVarB% does not have a TYPE!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo	VarF:		%buildtempVarF%
echo	VarG:		%buildtempVarG%
echo .
)

:: Find the TAG Value for the name provided in VarC
set tempvard=%%myTAGVar.!buildtempVarC!%%
call set buildtempTAGNum=!!tempvard!!



if not defined buildtempTAGNum (
	color 04
	echo %buildtempVarC% is not a valid TAG name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo	VarF:		%buildtempVarF%
echo	VarG:		%buildtempVarG%
echo .
)

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/led ,i 0 >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/postins/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/postins/mode ,s %buildtempVarD% >> %buildtempFile%.%buildtempOutExt%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/tags ,s %buildtempTAGNum% >> %buildtempFile%.%buildtempOutExt%

	echo /%buildtempTRACKType%/%buildtempTRACKNum%/name ,s "%buildtempVarG%" >> %buildtempFile%.%buildtempOutExt%



:: COLOR
echo /%buildtempTRACKType%/%buildtempTRACKNum%/col ,i 3 >> %buildtempFile%.%buildtempOutExt%
:: END COLOR



set mytempvare=%%mySend.!buildtempVarE!%%
call set buildtempSendString=!!mytempvare!!

if not defined buildtempSendString (
	color 04
	echo %buildtempSendString% is not a valid send string name!
echo BUILDING CUE WITH THIS INFO:
echo	Ext: 		%buildtempExt%
echo	File:		%buildtempFile%
echo	FileLine:	%buildtempFileLine%
echo	Cmd:		%buildtempCmd%
echo	VarB:		%buildtempVarB%
echo	VarC:		%buildtempVarC%
echo	VarD:		%buildtempVarD%
echo	VarE:		%buildtempVarE%
echo .

)


set /a mySendPosition=1
set /a myCharacterInString=0

:: mute the TRACK
echo /%buildtempTRACKType%/%buildtempTRACKNum%/mute ,i 1 >> %buildtempFile%.%buildtempOutExt%

:buildsendlooperC
set derivedSendPosition=%mySendPosition%
:: now for x32 the OSC requires a 2 digit track number so add leading 0 if needed
:: if %mySendPosition% LSS 10 set derivedSendPosition=0%mySendPosition%

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperC
)
if "%buildtempchar%" EQU "1" (
	echo /%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperC
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperC
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildsendlooperC
)
if "%buildtempchar%" EQU "*" (

	goto :endbuildfile
)



goto :endbuildfile





:: ----------------------END CUSTOM STUFF  ------------------------------


:endbuildfile

:: echo ending
exit /B
:: ************************************************************
:: ************************************************************

:ENDOFSCRIPT







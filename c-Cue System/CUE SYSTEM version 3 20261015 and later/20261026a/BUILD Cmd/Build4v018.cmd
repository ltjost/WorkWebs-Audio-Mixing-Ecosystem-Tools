ECHO OFF
color 06
set scriptver=Build4v018 now with WING, X32 and REAPER 
setlocal enabledelayedexpansion



:: display some initial script info for the record!  Weird code strips quote marks from the string so it displays nicely
set tempstring="."
set tempstringx=%tempstring:"=%
echo %tempstringx%
set tempstring=".      *** " BUILD  %scriptver% "   ***"
set tempstringx=%tempstring:"=%
echo %tempstringx%
set tempstring="."
set tempstringx=%tempstring:"=%
echo %tempstringx%

:: LED on/off is presently not generated with settracktolatestdca

:: **************************************************************************************
:: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
:: ******************************** SET THESE *******************************************




:: This is a single character designation.

call Build_Device_Types.cmd

call Build_File_Extension.cmd

:: ********************************SPECIAL NOTE PASSTHROUGH ****************************************************************

:: If the line read in from the cue file starts with PASSTHROUGH then everything after the | is placed directly into the output file.  At RUN time this allows you
:: to run any custom command you want.  Be sure to start the PASSTHROUGH content with a device identifier so that you can define an
:: IP and PORT for it in the RUN script and have what you specify passed to that dvice when the cue is run.  Format of the OSC command needs to align with what SENDOSC uses.
::example: 
:: PASSTHROUGH|WING3^^/someosc/moreosc i 1
:: in the cue file is processed by build to add this in the output cue:
::  WING3^/someosc/moreosc i 1
:: in RUN, WING3 will define an IP and Port and the subsequent OSC will be sent to that IP and Port.
:: NOTE the use of ^^ instead of ^ to separate the device from the OSC

:: ********************************SPECIAL NOTE VARIABLEFROMFILE ****************************************************************
:: This command works for WING, X32 or REAPER
:: VARIABLEFROMFILE
:: VARIABLEFROMFILE takes a line from a text file that was read in earlier and places the content of that line into the cue file
:: The variablename is the name of the cue entry from the imported file content
:: VARIABLEFROMFILE|variablename|





:: **************************************** WING COMMAND INFO **********************************************
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
:: 2) it renames  AUX8 (talkback) the specified Cue name to indicate to you that this is running
:: 3) it sets the Delay value
:: CUSTOMStartCue|Cue Name|

:: CUSTOMEndCue
:: CUSTOMEndCue is used to end a cue using a custom set of commands as follows:
:: 1) it renames AUX8 to the specified Cue name to indicate to you that this is completed
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

:: SETLATESTMUTEtoMUTE 
:: sets the SETTOLATESTMUTEVALUE to MUTE

:: SETLATESTMUTEtoUNMUTE
:: sets the SETTOLATESTMUTEVALUE to UNMUTE

:: SETTRACKTOLATESTMUTE
:: sets the specified track to the latest specified SETLATESTMUTE designation
:: SETTRACKTOLATESTMUTE|myTrackVar's name|



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

call Build_Wing_Colors.cmd




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
 

:: ****************************** REAPER COMMAND INFO ************************************************************************


:: createfile
:: createfile causes the system to build a new output cue file.  Without this, all added commands will append to
:: the existing file.  
:: createfile|


:: CUSTOMStartCue
:: CUSTOMStartCue is used to start a cue using a custom set of commands as follows:
:: 1) it calls createfile to open a new output cue file based on the name of the input cue file
:: 2) it renames the requested track to "*" followed by the specified Cue name to indicate to you that this is running
:: 3) it sets the Delay value
:: CUSTOMStartCue|myChan's Name|Cue Name|

:: CUSTOMEndCue
:: CUSTOMEndCue is used to end a cue using a custom set of commands as follows:
:: 1) it renames the requested track to the specified Cue name to indicate to you that this is completed
:: 2) it sets up a REAPER action call to 40157 to create a marker on the transport timeline
:: 3) It names that marker by the Cue Name specified
:: CUSTOMEndCue|myChan's Name|Cue Name|

:: SENDand_UNMUTE_NAME
:: SENDand_UNMUTE_NAME to update SENDS and then UNMUTE the channel and set the channel's display name
:: SENDand_UNMUTE_NAME|myChan's Name|mySend's Name|Channel Display Name|Send Level|

:: SENDand_MUTE_NAME
:: SENDand_MUTE_NAME MUTE the channel and then update SENDS and set the channel's display name
:: SENDand_MUTE_NAME|myChan's Name|mySend's Name|Channel Display Name|Send Level|

:: SENDand_UNMUTE
:: SENDand_UNMUTE to update SENDS and then UNMUTE the channel
:: SENDand_UNMUTE|myChan's Name|mySend's Name|Send Level|

:: SENDand_MUTE
:: SENDand_MUTE MUTE the channel and then update SENDS 
:: SENDand_MUTE|myChan's Name|mySend's Name|Send Level|

:: SENDand_ezMUTE_NAME
:: SENDand_ezMUTE_NAME MUTE the channel and DO NOT update SENDS and DO NOTset the channel's display name
:: This makes editing cues to MUTE or ezUNMUTE easier without messing with the rest of the command
:: SENDand_ezMUTE_NAME|myChan's Name|mySend's Name|Channel Display Name|Send Level|

:: SENDand_ezMUTE
:: SENDand_ezMUTE MUTE the channel and DO NOT update SENDS 
:: This makes editing cues to MUTE or ezUNMUTE easier without messing with the rest of the command
:: SENDand_ezMUTE|myChan's Name|mySend's Name|Send Level|

:: PLUGIN_ADJ
:: PLUGIN_ADJ updates plugin settings based on a pattern string and custom code 
:: PLUGIN_ADJ|myChan's Name|myPlugin's Name|optional Variable Value|optional Variable Value|
:: run the string for plugins below like this
::   - is ignored and does not even increment the position number
::   x does not change the plugin, increments position counter
::   * terminates the string processing
::   {anything else} processes specific custom code based on the character specified


:: UNMUTE
:: UNMUTE to UNMUTE the channel and set the channel's display name
:: UNMUTE|myChan's Name|Channel Display Name|

:: MUTE
:: MUTE to MUTE the channel and set the channel's display name
:: MUTE|myChan's Name|Channel Display Name|

:: SELECT
:: SELECT to SELECT the channel and set the channel's display name
:: SELECT|myChan's Name|Channel Display Name|

:: UNSELECT
:: UNSELECT to UNSELECT the channel and set the channel's display name
:: UNSELECT|myChan's Name|Channel Display Name|

:: ARMON
:: ARMON to ARM the channel and set the channel's display name
:: ARMON|myChan's Name|Channel Display Name|

:: ARMOFF
:: ARMOFF to UN-ARM the channel and set the channel's display name
:: ARMOFF|myChan's Name|Channel Display Name|


:: AUTOMIXON
:: AUTOMIXON|myChan's Name|

:: AUTOMIXOFF
:: AUTOMIXON|myChan's Name|

:: MARKERName
:: MARKERName|||ID|Name| to update the name of the specified marker

:: LASTMARKERName
:: LASTMARKERName||Name| to update the name of the last marker

:: GOTOMarker
:: GOTMarker||number| to  go to the nth marker (not Marker number N but positionally Nth)


:: RECORD
:: RECORD to toggle start of transport

:: PLAY
:: PLAY to toggle play of transport

:: STOP
:: STOP to toggle stop of transport

:: PAUSE
:: PAUSE to toggle pause of transport



:: FXBYPASS
:: FXBYPASS|my Chan's Name|fx number|

:: FXACTIVE
:: FXACTIVE|my Chan's Name|fx number|

:: FXOPENUI
:: FXOPENUI|my Chan's Name|fx number|

:: FXCLOSEUI
:: FXCLOSEUI|my Chan's Name|fx number|


:: TRACKNAME
:: TRACKNAME|my Chan's Name|new display name|

:: TRACKVOLUME
:: TRACKVOLUME|my Chan's Name|volume value|

:: ACTIONi
:: ACTIONi takes an action number as an argument and sends it
:: ACTIONi||action number|

:: ACTIONs
:: ACTIONs takes an action string as an argument and sends it
:: ACTIONs||action string|

:: TRACKPAN
:: TRACKPAN will pan the specified track according to the provided value.
:: TRACKPAN values are 0-1 with 0 being full left, 1 being full right, 0.5 being centered
:: TRACKPAN|my Chan's Name|pan value|



:: comment
:: comments begin with #|
 


:: **************************** X32 COMMAND INFO *********************************************************
:: createfile
:: createfile causes the system to build a new output cue file.  Without this, all added commands will append to
:: the existing file.  
:: createfile|


:: CUSTOMStartCue
:: CUSTOMStartCue is used to start a cue using a custom set of commands as follows:
:: 1) it calls createfile to open a new output cue file based on the name of the input cue file
:: 2) it renames the Main Stereo Channel to "*" followed by the specified Cue name to indicate to you that this is running
:: 3) it sets the Delay value
:: CUSTOMStartCue|Cue Name|

:: CUSTOMEndCue
:: CUSTOMEndCue is used to end a cue using a custom set of commands as follows:
:: 1) it renames the Main Stereo Channel to the specified Cue name to indicate to you that this is completed
:: CUSTOMEndCue|Cue Name|


:: CHAN
:: CHAN to Mute or Unmute a channel
:: CHAN|MyChan's name|MUTE or UNMUTE|

:: CHANNAME
:: CHANNAME to name a channel
:: CHANNAME|MyChan's name|name|

:: CHANCOLOR
:: CHANCOLOR to set a channel color, values are OFF, RD, GN,YE,BL,MG,CY,WH,OFFi,RDi,GNi,UEi,BLi,MGi,CYi
:: CHANCOLOR|MyChan's name|color|

:: CHANSEND
:: CHANSEND to mute or unmute the Channel's send to the specified BUS.
:: CHANSEND|MyChan's Name|Bus Name|MUTE or UNMUTE|

:: CHANDCA
:: CHANDCA to define which DCA a Channel is defined to
:: CHANDCA|MyChan's name|myDCAassign name

:: DCA
:: DCA to Mute or Unmute a DCA
:: DCA|MyDCA's name|MUTE or UNMUTE|

:: DCANAME
:: DCANAMEto name a channel
:: DCANAME|MyDCA's name|name|

:: DCACOLOR
:: DCACOLORto set a DCA's color, values are OFF, RD, GN,YE,BL,MG,CY,WH,OFFi,RDi,GNi,UEi,BLi,MGi,CYi
:: DCACOLOR|MyDCA's name|color|


:: BUS
:: BUS to Mute or Unmute a bus
:: BUS|MyBus's's name|MUTE or UNMUTE|

:: BUSNAME
:: BUSNAME to name a Bus
:: BUSNAME|MyBus's name|name|

:: BUSCOLOR
:: BUSCOLOR to set a BUS's color, values are OFF, RD, GN,YE,BL,MG,CY,WH,OFFi,RDi,GNi,UEi,BLi,MGi,CYi
:: BUSCOLOR|MyBus's name|color|

:: MAINST
:: MAINST to Mute or Unmute the MAIN Stereo channel
:: MAINST|MUTE or UNMUTE|

:: MAINSTNAME
:: MAINSTNAME to name Main Stereo
:: MAINSTNAME|name|

:: MAINSTCOLOR
:: MAINSTCOLOR to set MAINL Stereo's color, values are OFF, RD, GN,YE,BL,MG,CY,WH,OFFi,RDi,GNi,UEi,BLi,MGi,CYi
:: MAINSTCOLOR|color|

:: MAINM
:: MAINM to Mute or Unmute the MAIN Mono channel
:: MAINM|MUTE or UNMUTE|testdca2

:: MAINMNAME
:: MAINMNAME to name MAIN Mono
:: MAINMNAME|name|

:: MAINMCOLOR
:: MAINMCOLOR to set MAIN Mono's color, values are OFF, RD, GN,YE,BL,MG,CY,WH,OFFi,RDi,GNi,UEi,BLi,MGi,CYi
:: MAINMCOLOR|color|

:: SENDand_UNMUTE
:: SENDand_UNMUTE to mute or unmute SENDS and then UNMUTE the channel
:: SENDand_UNMUTE|myChan's Name|mySend's Name|

:: SENDand_MUTE
:: SENDand_MUTE MUTE the channel and then mute or unmute SENDS 
:: SENDand_MUTE|myChan's Name|mySend's Name|



:: ROUTE_OUT
:: ROUTE_OUT sets a user route for user outputs 01 to 48
:: ROUTE_OUT|myRoute In's Name |source-name|
:: where source name is:
:: OFF (0)
:: LOCAL01-LOCAL32 (1-32)
:: AES50A01-48 (33-80)
:: AES50B01-48 (81-128)
:: CARD01-32 (129-160)
:: AUXIN01-06 (161-166)
:: TBINT (167)
:: TBEXT(168)  
:: OUT01-16 (169-184)
:: P1601-16 (185-200)
:: AUX01-06 (201-206)
:: MONL (207)
:: MONR (208)

:: ROUTE_IN
:: ROUTE_IN sets a user route for user in 01 to 32
:: ROUTE_IN|myRoute Out's name|source-name|
:: where source name is:
:: OFF (0)
:: LOCAL01-LOCAL32 (1-32)
:: AES50A01-48 (33-80)
:: AES50B01-48 (81-128)
:: CARD01-32 (129-160)
:: AUXIN01-06 (161-166)
:: TBINT (167)
:: TBEXT(168)


:: USB_RECORDER
:: USB_RECORDER controls the USB Recorder
:: USB_RECORDER|STOP or PLAY or PAUSEPLAY or RECORD or PAUSERECORD

:: LIVE_RECORDER
:: LIVE_RECORDER controls the Live Card Recorder
:: LIVE_RECORDER|STOP or PLAY or PAUSEPLAY or RECORD

:: SAVESCENE
:: SAVESCENE to save a scene
:: SAVESCENE|Scene Number|Scene Name|Scene Note|


:: SAVESNIPPET
:: SAVESNIPPET to save a snippet
:: SAVESNIPPET|Snippet Number|Snippet Name|


:: LOADSCENE
:: LOADSCENE to load a scene
:: LOADSCENE|Scene Number|


:: LOADSNIPPET
:: LOADSNIPPET to load a snippet
:: LOADSNIPPET|Snippet Number|

:: comment
:: comments begin with #|
 

:: ******************************************************************************************************************



:: *************************************************************MULTIPLE USER VARS**************************
:: MULTIPLE VARIABLES USER SET

call Build_Variable_From_File.cmd

:: *************************************************************WING USER VARS**************************
:: WING VARIABLES USER SET

call Build_Wing_Track_Values.cmd

call Build_Wing_DCA_Tag_Values.cmd

call Build_Wing_Connection_Values.cmd


:: ********************************************************* REAPER USER VARS *************************************************

call Build_REAPER_Channel_Values.cmd

call Build_REAPER_Send_Strings.cmd

:: ********************************************************* X32 USER VARS *************************************************

call Build_X32_Channel_Values.cmd

call Build_X32_Bus_Values.cmd

call Build_X32_Send_Strings.cmd

call Build_X32_DCA_Ids.cmd

call Build_X32_Route_Values.cmd

call Build_X32_Color_Values.cmd

:: Set values for Recording or Playing with the Live Card

set myCard.STOP=0
set myCard.PLAY=2
set myCard.PAUSEPLAY=1
set myCard.RECORD=3

:: Set Values for Recording or Playing with the USB Drive

set myTape.STOP=0
set myTape.PLAY=2
set myTape.PAUSEPLAY=1
set myTape.RECORD=4
set myTape.PAUSERECORD=3




:: ******************************************************************** END USER VARS SETTING ************************************


:: AND NOW EVERYTHING IS SET FOR CUE DEVELOPMENT IN CUE FILES





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
set myLatestMUTE=UNMUTE
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

set parmDevID="|"
set parma="|"
set parmb="|"
set parmc="|"
set parmd="|"
set parme="|"
set parmf="|"
set parmg="|"



for /F "tokens=1,2,3,4,5,6,7,8,9,10,11 delims=^|" %%a in ("%linetempvar%")do (
		set parmDevID=%%a
		set parma=%%b
		set parmb=%%c
		set parmc=%%d
		set parmd=%%e
		set parme=%%f
		set parmf=%%g
		set parmg=%%h
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

call :BuildCueFile %myFileExtension%, %tempvarx%, %mycurlinenum%, %parmDevID%, %parma%, %parmb%, %parmc%, %parmd%, %parme%, %parmf%, %parmg%
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
set buildtempDevID=%~4
set buildtempCmd=%~5
set buildtempVarB=%~6
set buildtempVarC=%~7
set buildtempVarD=%~8
set buildtempVarE=%~9
shift
set buildtempVarF=%~9
shift
set buildtempVarG=%~9


:: the extension for the file name includes OUT before the ext so add it once here

set buildtempOutExt=OUT%buildtempExt%

:: pick a flavor and process accordingly ******************************************  FLAVOR CHOICES ********

:: now pull device type and delay

set tempvartype=%%Type.!buildtempDevID!%%
call set buildtempDeviceType=!!tempvartype!!

if %buildtempDeviceType% EQU WING goto :BuildWINGCueContent
if %buildtempDeviceType% EQU REAPER goto :BuildREAPERCueContent
if %buildtempDeviceType% EQU X32 goto :BuildX32CueContent
if %buildtempDeviceType% EQU PASSTHROUGH goto :BuildPASSTHROUGHCueContent


goto :endALLbuildfile

:: ****************************************************EACH FLAVOR SPECIFIC LOGIC BELOW ************************

:BuildPASSTHROUGHCueContent

for /F "tokens=1* delims=|" %%w in ("!linetempvar!") do (
	echo %%x>> %buildtempFile%.%buildtempOutExt%
)


goto :endALLbuildfile

::  ****************** Use WING syntax ********WINGCODESTARTSHERE**********
:BuildWINGCueContent
:: Find the TRACK Number for the name proivided in VarB

set tempvarb=%%myTrackVar.!buildtempVarB!%%
call set buildtempTRACKNum=!!tempvarb!!

if %buildtempCmd% EQU # goto :endbuildWingfile



:: end set buildtempDeviceLetter=%buildtempFile:~0,1%

!

set tempvardelay=%%Delay.!buildtempDeviceLetter!%%
call set buildtempDeviceDelay=!!tempvardelay!!

set mytempvarc=%%mySend.!buildtempVarC!%%
call set buildtempSendString=!!mytempvarc!!
	


if %buildtempCmd% EQU VARIABLEFROMFILE goto :buildWingVARIABLEFROMFILE
if %buildtempCmd% EQU SETLATESTDCA goto :buildWingSETLATESTDCA
if %buildtempCmd% EQU SETTRACKTOLATESTDCA goto :buildWingSETTRACKTOLATESTDCA

if %buildtempCmd% EQU SETLATESTMUTEtoMUTE goto :buildWingSETLATESTMUTEtoMUTE
if %buildtempCmd% EQU SETLATESTMUTEtoUNMUTE goto :buildWingSETLATESTMUTEtoUNMUTE
if %buildtempCmd% EQU SETTRACKTOLATESTMUTE goto :buildWingSETTRACKTOLATESTMUTE

if %buildtempCmd% EQU TRACKMUTE goto :buildWingTRACKMUTE
if %buildtempCmd% EQU TRACKNAME goto :buildWingTRACKNAME
if %buildtempCmd% EQU TRACKCOLOR goto :buildWingTRACKCOLOR
if %buildtempCmd% EQU TRACKTAG goto :buildWingTRACKTAG
if %buildtempCmd% EQU TRACKTAGMUTE goto :buildWingTRACKTAGMUTE

if %buildtempCmd% EQU TRACKSEND goto :buildWingTRACKSEND
if %buildtempCmd% EQU TRACKPOSTINS goto :buildWingTRACKPOSTINS
if %buildtempCmd% EQU TRACKICON goto :buildWingTRACKICON
if %buildtempCmd% EQU TRACKLED goto :buildWingTRACKLED
if %buildtempCmd% EQU TRACKPAN goto :buildWingTRACKPAN
if %buildtempCmd% EQU TRACKPROC goto :buildWingTRACKPROC
if %buildtempCmd% EQU TRACKMODE goto :buildWingTRACKMODE
if %buildtempCmd% EQU TRACKGROUPIN goto :buildWingTRACKGROUPIN

if %buildtempCmd% EQU Custom_a_DCA_ONMUTED goto :buildWingCUSTOMADCAONMUTED
if %buildtempCmd% EQU Custom_a_DCA_ONUNMUTED goto :buildWingCUSTOMADCAONUNMUTED
if %buildtempCmd% EQU Custom_a_DCA_OFF goto :buildWingCUSTOMADCAOFF
if %buildtempCmd% EQU Custom_a_CHAN_ON goto :buildWingCUSTOMACHANON
if %buildtempCmd% EQU Custom_a_CHAN_OFF goto :buildWingCUSTOMACHANOFF

if %buildtempCmd% EQU TRACK_GATE_ON goto :buildWingTRACKGATEON
if %buildtempCmd% EQU TRACK_GATE_OFF goto :buildWingTRACKGATEOFF
if %buildtempCmd% EQU TRACK_EQ_ON goto :buildWingTRACKEQON
if %buildtempCmd% EQU TRACK_EQ_OFF goto :buildWingTRACKEQOFF
if %buildtempCmd% EQU TRACK_DYN_ON goto :buildWingTRACKDYNON
if %buildtempCmd% EQU TRACK_DYN_OFF goto :buildWingTRACKDYNOFF
if %buildtempCmd% EQU TRACK_PREINS_ON goto :buildWingTRACKPREINSON
if %buildtempCmd% EQU TRACK_PREINS_OFF goto :buildWingTRACKPREINSOFF
if %buildtempCmd% EQU TRACK_POSTINS_ON goto :buildWingTRACKPOSTINSON
if %buildtempCmd% EQU TRACK_POSTINS_OFF goto :buildWingTRACKPOSTINSOFF



if %buildtempCmd% EQU USB_RECORD goto :buildWingUSB_RECORD
if %buildtempCmd% EQU USB_PLAY goto :buildWingUSB_PLAY
if %buildtempCmd% EQU USB_PLAYFILE goto :buildWingUSB_PLAYFILE

if %buildtempCmd% EQU LIVE_RECORDER goto :buildWingLIVERECORDER

if %buildtempCmd% EQU createfile goto :buildWingCREATEFILE
if %buildtempCmd% EQU endfile goto :buildWingENDFILE

if %buildtempCmd% EQU CUSTOMStartCue goto :buildWingCUSTOMStartCue
if %buildtempCmd% EQU CUSTOMEndCue goto :buildWingCustomEndCue

if %buildtempCmd% EQU SENDand_MUTE goto :buildWingSENDandMUTE
if %buildtempCmd% EQU SENDand_UNMUTE goto :buildWingSENDandUNMUTE


if %buildtempCmd% EQU LOADSCENE goto :buildWingLOADSCENE
if %buildtempCmd% EQU NAVSCENE goto :buildWingNAVSCENE

if %buildtempCmd% EQU AUTOMIXXON goto :buildWingAUTOMIXXON
if %buildtempCmd% EQU AUTOMIXYON goto :buildWingAUTOMIXYON
if %buildtempCmd% EQU AUTOMIXXOFF goto :buildWingAUTOMIXXOFF
if %buildtempCmd% EQU AUTOMIXYOFF goto :buildWingAUTOMIXYOFF

echo ***************** UNKNOWN COMMAND RECEIVED ******************************
echo %buildtempCMD%
echo *************************************************************************
goto :endbuildWingfile

:: **********************************************Process the "SETLATESTMUTEtoMUTE" command


:buildWingSETLATESTMUTEtoMUTE


set myLatestMUTE=MUTE

goto :endbuildWingfile

:: **********************************************Process the "SETLATESTMUTEtoUNMUTE" command


:buildWingSETLATESTMUTEtoUNMUTE


set myLatestMUTE=UNMUTE

goto :endbuildWingfile

:: **********************************************Process the "SETTRACKTOLATESTMUTE command

:: the SETTRACKTOLATESTMUTE command is easy...look up values and set it


:buildWingSETTRACKTOLATESTMUTE
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

:: find track on and off colors

call set tempcoloron=%%myTrackVar.!buildtempVarB!.color.on%%
call set tempcoloroff=%%myTrackVar.!buildtempVarB!.color.off%%


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
::echo what %myLatestMUTE%
if %myLatestMUTE% EQU MUTE (
::echo HERE
	goto :xxxbuildWingSETTRACKTOLATESTMUTE
)

if not defined myLatestMUTE (
	color 04
	echo %myLatestMUTE% is not valid!
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
	
        echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 0 >> %buildtempFile%.%buildtempOutExt%
 ::       echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/led i 1 >> %buildtempFile%.%buildtempOutExt%

	if defined tempcoloron (
        echo %buildtempDevID%^^^^/%buildtempTRACKType%/%buildtempTRACKNum%/col i !%tempcoloron%! >> %buildtempFile%.%buildtempOutExt%
	)


goto :endbuildWingfile

:xxxbuildWingSETTRACKTOLATESTMUTE
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 1 >> %buildtempFile%.%buildtempOutExt%
 ::       echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/led i 0 >> %buildtempFile%.%buildtempOutExt%
	
	if defined tempcoloroff (
        echo %buildtempDevID%^^^^/%buildtempTRACKType%/%buildtempTRACKNum%/col i !%tempcoloroff%! >> %buildtempFile%.%buildtempOutExt%
	)

        goto :endbuildWingfile










:: **********************************************Process the "SETLATESTDCA" command


:buildWingSETLATESTDCA


:: Find the TAG Value for the name provided in VarB
set tempvarb=%%myTAGVar.!buildtempVarB!%%


call set myLatestDCA=!!tempvarb!!


if %buildtempVarB% EQU xxx (
set myLatestDCA=xxx
	goto :endbuildWingfile
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
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/name s "%buildtempVarD%">> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile

:: **********************************************Process the "SETTRACKTOLATESTDCA command

:: the SETTRACKTOLATESTDCA command is easy...look up values and set it


:buildWingSETTRACKTOLATESTDCA
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

:: find track on and off colors

call set tempcoloron=%%myTrackVar.!buildtempVarB!.color.on%%
call set tempcoloroff=%%myTrackVar.!buildtempVarB!.color.off%%


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
	goto :xxxbuildWingSETTRACKTOLATESTDCA
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
	
        echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 0 >> %buildtempFile%.%buildtempOutExt%
 ::       echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/led i 1 >> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/tags s %myLatestDCA%>> %buildtempFile%.%buildtempOutExt%

	if defined tempcoloron (
        echo %buildtempDevID%^^^^/%buildtempTRACKType%/%buildtempTRACKNum%/col i !%tempcoloron%! >> %buildtempFile%.%buildtempOutExt%
	)


goto :endbuildWingfile

:xxxbuildWingSETTRACKTOLATESTDCA
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 1 >> %buildtempFile%.%buildtempOutExt%
 ::       echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/led i 0 >> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/tags s "">> %buildtempFile%.%buildtempOutExt%
	
	if defined tempcoloroff (
        echo %buildtempDevID%^^^^/%buildtempTRACKType%/%buildtempTRACKNum%/col i !%tempcoloroff%! >> %buildtempFile%.%buildtempOutExt%
	)

        goto :endbuildWingfile




:: **********************************************Process the "TRACKMUTE" command

:: the TRACK command is easy...just mute or unmute the TRACK and you are done


:buildWingTRACKMUTE
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
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarC% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 0 >> %buildtempFile%.%buildtempOutExt%
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

goto :endbuildWingfile


:: **********************************************Process the "VARIABLEFROMFILE" command

:: the VARIABLEFROMFILE command is easy...just dump the string


:buildWingVARIABLEFROMFILE


set tempvarb=%buildtempVarB%

:: echo var %w1_cue001a%
:: echo vb !%tempvarb%!

:: echo 
	echo %buildtempDevID%^^^^!%tempvarb%!>> %buildtempFile%.%buildtempOutExt%

goto :endbuildWingfile

:: **********************************************Process the "TRACKNAME" command

:: the TRACKNAME command is easy...just name the TRACK and you are done


:buildWingTRACKNAME

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
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/name s "%buildtempVarC%">> %buildtempFile%.%buildtempOutExt%

goto :endbuildWingfile


:: **********************************************Process the "TRACKCOLOR" command

:: the TRACKNAME command is easy...just color the TRACK and you are done


:buildWingTRACKCOLOR

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

set tempvarc=%%myWingColor.!buildtempVarC!%%
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


echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/col i %buildtempColor%>> %buildtempFile%.%buildtempOutExt%

goto :endbuildWingfile


:: **********************************************Process the "TRACKTAG command

:: the TRACKTAG command is easy...look up values and set it


:buildWingTRACKTAG

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
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/tags s %buildtempTAGNum%>> %buildtempFile%.%buildtempOutExt%

goto :endbuildWingfile

:: **********************************************Process the "TRACKTAGMUTE command

:: the TRACKTAGMUTE command is easy...look up values and set it


:buildWingTRACKTAGMUTE
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
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/tags s %buildtempTAGNum%>> %buildtempFile%.%buildtempOutExt%




if %buildtempVarD% EQU MUTE (
::	echo MUTE FOUND
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarD% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 0 >> %buildtempFile%.%buildtempOutExt%
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






goto :endbuildWingfile



:: **********************************************Process the "TRACKICON" command


:buildWingTRACKICON


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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/icon i %buildtempVarC%>> %buildtempFile%.%buildtempOutExt%

goto :endbuildWingfile

:: **********************************************Process the "TRACKLED" command



:buildWingTRACKLED
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


:: find track on and off colors

call set tempcoloron=%%myTrackVar.!buildtempVarB!.color.on%%
call set tempcoloroff=%%myTrackVar.!buildtempVarB!.color.off%%

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
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/led i 1 >> %buildtempFile%.%buildtempOutExt%
	if defined tempcoloron (
        echo %buildtempDevID%^^^^/%buildtempTRACKType%/%buildtempTRACKNum%/col i !%tempcoloron%!>> %buildtempFile%.%buildtempOutExt%
	)
	set myFOUNDIT=1
)
if %buildtempVarC% EQU OFF (
::	echo UNMUTE FOUND
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/led i 0 >> %buildtempFile%.%buildtempOutExt%
	if defined tempcoloroff (
        echo %buildtempDevID%^^^^/%buildtempTRACKType%/%buildtempTRACKNum%/col i !%tempcoloroff%!>> %buildtempFile%.%buildtempOutExt%
	)
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

goto :endbuildWingfile


:: **********************************************Process the "TRACKPAN" command


:buildWingTRACKPAN


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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/pan f %buildtempVarC%>> %buildtempFile%.%buildtempOutExt%

goto :endbuildWingfile

:: **********************************************Process the "TRACKPROC" command


:buildWingTRACKPROC


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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/proc s %buildtempVarC%>> %buildtempFile%.%buildtempOutExt%

goto :endbuildWingfile

:: **********************************************Process the "TRACKMODE" command


:buildWingTRACKMODE


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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mode s %buildtempVarC%>> %buildtempFile%.%buildtempOutExt%

goto :endbuildWingfile

:: **********************************************Process the "TRACKGROUPIN" command


:buildWingTRACKGROUPIN


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



	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/in/conn/grp s %buildtempCONNType%>> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/in/conn/in i %buildtempCONNNum%>> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile




:: **********************************************Process the "TRACKSEND" command

:: the TRACKSEND command is easy...just mute or unmute the TRACK send and you are done


:buildWingTRACKSEND
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
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/send/%buildtempBusNum%/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarD% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/send/%buildtempBusNum%/on i 1 >> %buildtempFile%.%buildtempOutExt%
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

goto :endbuildWingfile



:: **********************************************Process the "AUTOMIXXON" command

:: just set the value


:buildWingAUTOMIXXON

	echo %buildtempDevID%^^^/cfg/amix/x i 1 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile

:: **********************************************Process the "AUTOMIXYON" command

:: just set the value


:buildWingAUTOMIXYON

	echo %buildtempDevID%^^^/cfg/amix/y i 1 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile
:: **********************************************Process the "AUTOMIXXOFF" command

:: just set the value


:buildWingAUTOMIXXOFF

	echo %buildtempDevID%^^^/cfg/amix/x i 0 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile

:: **********************************************Process the "AUTOMIXYOFF" command

:: just set the value


:buildWingAUTOMIXYOFF

	echo %buildtempDevID%^^^/cfg/amix/y i 0 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile



:: **********************************************Process the "USB_RECORD" command

:: the USB_RECORD command is easy...just set the value


:buildWingUSB_RECORD

	echo %buildtempDevID%^^^/rec/$action s %buildtempVarB%>> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile

:: **********************************************Process the "USB_PLAY" command

:: the USB_PLAY command is easy...just set the value


:buildWingUSB_PLAY

	echo %buildtempDevID%^^^/play/$action s %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile


:: **********************************************Process the "USB_PLAYFILE" command

:: the USB_PLAYFILE command is easy...just set the value


:buildWingUSB_PLAYFILE

	echo %buildtempDevID%^^^/play/$playfile s %buildtempVarB%>> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/play/$action s PLAYFILE>> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile


:: **********************************************Process the "LIVE_RECORDER" command

:: the LIVE_RECORDER command is easy...just  set the value


:buildWingLIVERECORDER


	echo %buildtempDevID%^^^/cards/wlive/%buildtempVarB%/control s %buildtempVarC%>> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile


:: **********************************************Process the "SENDand_UNMUTE" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not TRACKge the send, increments position counter
::   * terminates the string processing



:buildWingSENDandUNMUTE


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






:buildWingsendlooperB
set derivedSendPosition=%mySendPosition%
:: now for x32 the OSC requires a 2 digit track number so add leading 0 if needed
::if %mySendPosition% LSS 10 set derivedSendPosition=0%mySendPosition%

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildWingsendlooperB
)
if "%buildtempchar%" EQU "1" (
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on i 1 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildWingsendlooperB
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildWingsendlooperB
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildWingsendlooperB
)
if "%buildtempchar%" EQU "*" (
	:: unmute the TRACK
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 0 >> %buildtempFile%.%buildtempOutExt%

	goto :endbuildWingfile
)

goto :endbuildWingfile


:: **********************************************Process the "SENDand_MUTE" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not TRACKge the send, increments position counter
::   * terminates the string processing


:buildWingSENDandMUTE

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
echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 1 >> %buildtempFile%.%buildtempOutExt%

:buildWingsendlooperC
set derivedSendPosition=%mySendPosition%
:: now for x32 the OSC requires a 2 digit track number so add leading 0 if needed
:: if %mySendPosition% LSS 10 set derivedSendPosition=0%mySendPosition%

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildWingsendlooperC
)
if "%buildtempchar%" EQU "1" (
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on i 1 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildWingsendlooperC
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildWingsendlooperC
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildWingsendlooperC
)
if "%buildtempchar%" EQU "*" (

	goto :endbuildWingfile
)

goto :endbuildWingfile



:: **********************************************Process the "createfile" command

:: create an empty cue file so later output can just worry about appending to it
:buildWingCREATEFILE
	type NUL > %buildtempFile%.%buildtempOutExt%
::	echo time %buildtempDevID%^^^%buildtempDeviceDelay%>> %buildtempFile%.%buildtempOutExt%

	echo Now building file %buildtempFile%.%buildtempOutExt%
	goto :endbuildWingfile



:: **********************************************Process the "CUSTOMStartCue" command


:buildWingCUSTOMStartCue

type NUL > %buildtempFile%.%buildtempOutExt%
echo Created file %buildtempFile%.%buildtempOutExt%
::echo %buildtempDevID%^^^time %buildtempDeviceDelay%>> %buildtempFile%.%buildtempOutExt%
echo %buildtempDevID%^^^/aux/8/name s "%buildtempVarB%">> %buildtempFile%.%buildtempOutExt%
goto :endbuildWingfile

:: **********************************************Process the "endfile" command

:: ends the wosc process of the file
:buildWingENDFILE
::	echo kill >> %buildtempDevID%^^^%buildtempFile%.%buildtempOutExt%
	type NUL >> %buildtempFile%.%buildtempOutExt%

	echo Ended file %buildtempFile%.%buildtempOutExt%
	goto :endbuildWingfile


:: **********************************************Process the "CUSTOMEndCue" command


:buildWingCUSTOMEndCue


echo %buildtempDevID%^^^/aux/8/name s "%buildtempVarB%" >> %buildtempFile%.%buildtempOutExt%
:: echo %buildtempDevID%^^^kill>> %buildtempFile%.%buildtempOutExt%
:: type %buildtempDevID%^^^NUL>> %buildtempFile%.%buildtempOutExt%
goto :endbuildWingfile





:: **********************************************Process the "LOADSCENE" command

:buildWingLOADSCENE

echo %buildtempDevID%^^^/$ctl/lib/$actionidx i %buildtempVarB%>> %buildtempFile%.%buildtempOutExt%
echo %buildtempDevID%^^^/$ctl/lib/$action s GOTAG>> %buildtempFile%.%buildtempOutExt%
echo %buildtempDevID%^^^/$ctl/lib/$actionidx i 0>> %buildtempFile%.%buildtempOutExt%
goto :endbuildWingfile


:: **********************************************Process the "NAVSCENE" command

:buildWingNAVSCENE

echo %buildtempDevID%^^^/$ctl/lib/$actionidx i 0>> %buildtempFile%.%buildtempOutExt%
echo %buildtempDevID%^^^/$ctl/lib/$action s %buildtempVarB%>> %buildtempFile%.%buildtempOutExt%
goto :endbuildWingfile




:: **********************************************Process the "TRACKPOSTINS" command

:: the TRACKPOSTINS command is easy...just mute or unmute the TRACK and set the value and you are done


:buildWingTRACKPOSTINS
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
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/postins/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarC% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/postins/on i 1 >> %buildtempFile%.%buildtempOutExt%
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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/postins/mode s %buildtempVarD%>> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile

:: **********************************************Process the "TRACK_GATE_ON" command

:: the TRACK_GATE_ON command is easy...just  unmute the GATE for the specified TRACK


:buildWingTRACKGATEON
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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/gate/on i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildWingfile

:: **********************************************Process the "TRACK_GATE_OFF" command

:: the TRACK_GATE_OFF command is easy...just  mute the GATE for the specified TRACK


:buildWingTRACKGATEOFF
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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/gate/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildWingfile

:: **********************************************Process the "TRACK_EQ_ON" command

:: the TRACK_EQ_ON command is easy...just  unmute the EQ for the specified TRACK


:buildWingTRACKEQON
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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/eq/on i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildWingfile

:: **********************************************Process the "TRACK_EQ_OFF" command

:: the TRACK_EQ_OFF command is easy...just mute the EQ for the specified TRACK


:buildWingTRACKEQOFF
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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/eq/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildWingfile

:: **********************************************Process the "TRACK_DYN_ON" command

:: the TRACK_DYN_ON command is easy...just  unmute the DYN for the specified TRACK


:buildWingTRACKDYNON
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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/dyn/on i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildWingfile

:: **********************************************Process the "TRACK_DYN_OFF" command

:: the TRACK_DYN_OFF command is easy...just mute the DYN for the specified TRACK


:buildWingTRACKDYNOFF
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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/dyn/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildWingfile

:: **********************************************Process the "TRACK_PREINS_ON" command

:: the TRACK_PREINS_ON command is easy...just  unmute the PREINS for the specified TRACK


:buildWingTRACKPREINSON
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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/preins/on i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildWingfile

:: **********************************************Process the "TRACK_PREINS_OFF" command

:: the TRACK_PREINS_OFF command is easy...just mute the PREINS for the specified TRACK


:buildWingTRACKPREINSOFF
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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/preins/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildWingfile

:: **********************************************Process the "TRACK_POSTINS_ON" command

:: the TRACK_POSTINS_OFF command is easy...just  unmute the POSTINS for the specified TRACK


:buildWingTRACKPOSTINSON
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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/postins/on i 1 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildWingfile

:: **********************************************Process the "TRACK_POSTINS_OFF" command

:: the TRACK_POSTINS_OFF command is easy...just mute the POSTINS for the specified TRACK


:buildWingTRACKPOSTINSOFF
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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/postins/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1

goto :endbuildWingfile

:: ---------------------- CUSTOM STUFF ---------------------------------


:: **********************************************Process the "Custom_a_DCA_ONMUTED command

:: Like TRACKNAME set to provided  - TRACKLED set ON - TRACKMUTE set MUTED
:: for a DCA Track


:buildWingCUSTOMADCAONMUTED

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
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/name s "%buildtempVarC%">> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/led i 1 >> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 1 >> %buildtempFile%.%buildtempOutExt%
::      echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/col i 7 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile


:: **********************************************Process the "Custom_a_DCA_ONUNMUTED command

:: Like TRACKNAME set to provided  - TRACKLED set ON - TRACKMUTE set UNMUTED
:: for a DCA Track


:buildWingCUSTOMADCAONUNMUTED

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
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/name s "%buildtempVarC%">> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/led i 1 >> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 0 >> %buildtempFile%.%buildtempOutExt%
::      echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/col i 7 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile

:: **********************************************Process the "Custom_a_DCA_OFF command

:: Like TRACKNAME set to "."  - TRACKLED set OFF - TRACKMUTE set MUTED
:: for a DCA Track


:buildWingCUSTOMADCAOFF

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
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/name s ".">> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/led i 0 >> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mutei 1 >> %buildtempFile%.%buildtempOutExt%
::      echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/col i 3 >> %buildtempFile%.%buildtempOutExt%


goto :endbuildWingfile

:: **********************************************Process the "Custom_a_CHAN_ON command

:: Like TRACKNAME set to "."  - TRACKPOSTINS set automix value - TRACKTAG set to tag value - SEND AND UNMUTE based on a string



:buildWingCUSTOMACHANON

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




	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/led i 1 >> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/postins/on i 1 >> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/postins/mode s %buildtempVarD%>> %buildtempFile%.%buildtempOutExt%

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/tags s %buildtempTAGNum%>> %buildtempFile%.%buildtempOutExt%

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/name s "%buildtempVarG%">> %buildtempFile%.%buildtempOutExt%




:: COLOR
:: Find the Color for the name proivided in VarF

set tempvarf=%%myWingColor.!buildtempVarF!%%
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

echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/col i %buildtempColor%>> %buildtempFile%.%buildtempOutExt%

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






:buildWingsendlooperB
set derivedSendPosition=%mySendPosition%
:: now for x32 the OSC requires a 2 digit track number so add leading 0 if needed
::if %mySendPosition% LSS 10 set derivedSendPosition=0%mySendPosition%

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildWingsendlooperB
)
if "%buildtempchar%" EQU "1" (
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on i 1 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildWingsendlooperB
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildWingsendlooperB
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildWingsendlooperB
)
if "%buildtempchar%" EQU "*" (
	:: unmute the TRACK
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 0 >> %buildtempFile%.%buildtempOutExt%

	goto :endbuildWingfile
)


goto :endbuildWingfile
:: **********************************************Process the "Custom_a_CHAN_OFF command

:: Like TRACKNAME set to "."  - TRACKPOSTINS set automix value to FX - TRACKTAG set to tag dcapark - SEND AND MUTE based on spark



:buildWingCUSTOMACHANOFF


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

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/led i 0 >> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/postins/on i 1 >> %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/postins/mode s %buildtempVarD%>> %buildtempFile%.%buildtempOutExt%

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/tags s %buildtempTAGNum%>> %buildtempFile%.%buildtempOutExt%

	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/name s "%buildtempVarG%">> %buildtempFile%.%buildtempOutExt%



:: COLOR
echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/col i 3 >> %buildtempFile%.%buildtempOutExt%
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
echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/mute i 1 >> %buildtempFile%.%buildtempOutExt%

:buildWingsendlooperC
set derivedSendPosition=%mySendPosition%
:: now for x32 the OSC requires a 2 digit track number so add leading 0 if needed
:: if %mySendPosition% LSS 10 set derivedSendPosition=0%mySendPosition%

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildWingsendlooperC
)
if "%buildtempchar%" EQU "1" (
	echo %buildtempDevID%^^^/%buildtempTRACKType%/%buildtempTRACKNum%/send/%derivedSendPosition%/on i 1 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildWingsendlooperC
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildWingsendlooperC
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildWingsendlooperC
)
if "%buildtempchar%" EQU "*" (

	goto :endbuildWingfile
)



goto :endbuildWingfile





:: ----------------------END CUSTOM STUFF  ------------------------------


:endbuildWingfile
goto :endALLbuildfile

:: ********************************** END WING *********************************************************************************
:: ********************************** START REAPER *********************************************************************************

:BuildREAPERCueContent

:: Find the Channel Number for the name proivided in VarB

set tempvarb=%%myChan.!buildtempVarB!%%
call set buildtempChanNum=!!tempvarb!!


if %buildtempCmd% EQU # goto :endbuildREAPERfile

if %buildtempCmd% EQU createfile goto :REAPERSKIPChanNameTest
if %buildtempCmd% EQU MARKERName goto :REAPERSKIPChanNameTest
if %buildtempCmd% EQU LASTMARKERName goto :REAPERSKIPChanNameTest
if %buildtempCmd% EQU GOTMarker goto :REAPERSKIPChanNameTest
if %buildtempCmd% EQU RECORD goto :REAPERSKIPChanNameTest
if %buildtempCmd% EQU PLAY goto :REAPERSKIPChanNameTest
if %buildtempCmd% EQU STOP goto :REAPERSKIPChanNameTest
if %buildtempCmd% EQU PAUSE goto :REAPERSKIPChanNameTest
if %buildtempCmd% EQU ACTIONi goto :REAPERSKIPChanNameTest
if %buildtempCmd% EQU ACTIONs goto :REAPERSKIPChanNameTest
if %buildtempCmd% EQU PASSTHRU goto :REAPERSKIPChanNameTest
if %buildtempCmd% EQU VARIABLEFROMFILE goto :REAPERSKIPChanNameTest



if not defined buildtempChanNum (
	color 04
	echo %buildtempVarB% is not a valid channel name!
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
echo DERIVED:
echo	ChanNum:	%buildtempChanNum%
echo	OutExt: 	%buildtempOutExt%
echo	DeviceLetter:	%buildtempDeviceLetter%
echo	DeviceType:	%buildtempDeviceType%
echo	DeviceDelay:	%buildtempDeviceDelay%
)


:: if the command does not have a channel name to test, it is not an error

:REAPERSKIPChanNameTest



:: set buildtempDeviceLetter=%buildtempFile:~0,1%

:: now pull device type and delay

set tempvartype=%%Type.!buildtempDeviceLetter!%%
call set buildtempDeviceType=!!tempvartype!!


set tempvardelay=%%Delay.!buildtempDeviceLetter!%%
call set buildtempDeviceDelay=!!tempvardelay!!

set mytempvarc=%%mySend.!buildtempVarC!%%
call set buildtempSendString=!!mytempvarc!!


goto :SKIPBUGA
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
echo DERIVED:
echo	ChanNum:	%buildtempChanNum%
echo	OutExt: 	%buildtempOutExt%
echo	DeviceLetter:	%buildtempDeviceLetter%
echo	DeviceType:	%buildtempDeviceType%
echo	DeviceDelay:	%buildtempDeviceDelay%

:SKIPBUGA






::  ****************** Use REAPER syntax ******************


if %buildtempCmd% EQU SENDand_UNMUTE_NAME goto :buildREAPERWorkSENDandUNMUTENAMEThisA
if %buildtempCmd% EQU VARIABLEFROMFILE goto :buildREAPERVARIABLEFROMFILE
if %buildtempCmd% EQU SENDand_MUTE_NAME goto :buildREAPERWorkSENDandMUTENAMEThisA
if %buildtempCmd% EQU SENDand_UNMUTE goto :buildREAPERWorkSENDandUNMUTEThisA
if %buildtempCmd% EQU SENDand_MUTE goto :buildREAPERWorkSENDandMUTEThisA
if %buildtempCmd% EQU MARKERName goto :buildREAPERMARKERNAME
if %buildtempCmd% EQU MUTE goto :buildREAPERMuteME
if %buildtempCmd% EQU UNMUTE goto :buildREAPERUNMuteME
if %buildtempCmd% EQU SELECT goto :buildREAPERSelectME
if %buildtempCmd% EQU UNSELECT goto :buildREAPERUnSelectME
if %buildtempCmd% EQU SENDand_ezMUTE goto :buildREAPERezMuteME
if %buildtempCmd% EQU SENDand_ezMUTE_NAME goto :buildREAPERezMuteME
if %buildtempCmd% EQU AUTOMIXON goto :buildREAPERAUTOMIXONme
if %buildtempCmd% EQU AUTOMIXOFF goto :buildREAPERAUTOMIXOFFme
if %buildtempCmd% EQU ARMON goto :buildREAPERARMONme
if %buildtempCmd% EQU ARMOFF goto :buildREAPERARMOFFme
if %buildtempCmd% EQU FXBYPASS goto :buildREAPERFXBYPASSME
if %buildtempCmd% EQU FXACTIVE goto :buildREAPERFXACTIVEME
if %buildtempCmd% EQU TRACKNAME goto :buildREAPERTRACKNAME
if %buildtempCmd% EQU TRACKVOLUME goto :buildREAPERTRACKVOLUME
if %buildtempCmd% EQU TRACKPAN goto :buildREAPERTRACKPAN
if %buildtempCmd% EQU ACTIONi goto :buildREAPERACTIONi
if %buildtempCmd% EQU ACTIONs goto :buildREAPERACTIONs
if %buildtempCmd% EQU LASTMARKERName goto :buildREAPERLASTMARKERName
if %buildtempCmd% EQU CUSTOMStartCue goto :buildREAPERCUSTOMStartCue
if %buildtempCmd% EQU CUSTOMEndCue goto :buildREAPERCUSTOMEndCue
if %buildtempCmd% EQU createfile goto :buildREAPERCREATEFILE
if %buildtempCmd% EQU GOTOMarker goto :buildREAPERGOTOMarker
if %buildtempCmd% EQU RECORD goto :buildREAPERRECORD
if %buildtempCmd% EQU PLAY goto :buildREAPERPLAY
if %buildtempCmd% EQU STOP goto :buildREAPERSTOP
if %buildtempCmd% EQU PAUSE goto :buildREAPERPAUSE
if %buildtempCmd% EQU PLUGIN_ADJ goto :buildREAPERWorkPLUGIN_ADJThis
if %buildtempCmd% EQU FXOPENUI goto :buildREAPERFXOPENUI
if %buildtempCmd% EQU FXCLOSEUI goto :buildREAPERFXCLOSEUI





echo ***************** UNKNOWN COMMAND RECEIVED ******************************
echo %buildtempCMD%
echo *************************************************************************
goto :endbuildREAPERfile

:: **********************************************Process the "VARIABLEFROMFILE" command

:: the VARIABLEFROMFILE command is easy...just dump the string


:buildREAPERVARIABLEFROMFILE


set tempvarb=%buildtempVarB%

:: echo var %w1_cue001a%
:: echo vb !%tempvarb%!

:: echo 
	echo %buildtempDevID%^^^^!%tempvarb%!>> %buildtempFile%.%buildtempOutExt%

goto :endbuildREAPERfile

:: **********************************************Process the "MUTE" command

:: the MUTE command is easy...just mute the channel and you are done...maybe new name too


:buildREAPERMuteME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/mute ,i 1 to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/mute i 1 >> %buildtempFile%.%buildtempOutExt%
	if defined buildtempVarC (
::		echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarB% to %buildtempFile%.%buildtempOutExt%
		echo %buildtempDevID%^^^/track/%buildtempChanNum%/name s %buildtempVarC%>> %buildtempFile%.%buildtempOutExt%
	)
goto :endbuildREAPERfile

:: **********************************************Process the "SENDand_ezMUTE"  or "SENDand_ezNUTE_NAME" command

:: ...just mute the channel and you are done


:buildREAPERezMuteME
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/mute i 1 >> %buildtempFile%.%buildtempOutExt%
	goto :endbuildREAPERfile



:: **********************************************Process the "AUTOMIXON" command CUSTOM CODE

:: the AUTOMIXON command is easy...
:: clear fx 3 param 7 at (CHAN)


:buildREAPERAUTOMIXONme
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/fx/2/fxparam/7/value f 0 >> %buildtempFile%.%buildtempOutExt%

goto :endbuildREAPERfile

:: **********************************************Process the "AUTOMIXOFF" command CUSTOM CODE

:: the AUTOMIXOFF command is easy...
:: set fx 3 param 7 at (CHAN)


:buildREAPERAUTOMIXOFFme
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/fx/2/fxparam/7/value f 1 >> %buildtempFile%.%buildtempOutExt%

goto :endbuildREAPERfile


:: **********************************************Process the "ARMON" command


:buildREAPERARMONme
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/recarm i 1 >> %buildtempFile%.%buildtempOutExt%

goto :endbuildREAPERfile

:: **********************************************Process the "ARMOFF" command




:buildREAPERARMOFFme
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/recarm i 0 >> %buildtempFile%.%buildtempOutExt%

goto :endbuildREAPERfile




:: **********************************************Process the "UNMUTE" command

:: the UNMUTE command is easy...just unmute the channel and you are done...maybe new name too


:buildREAPERUNMuteME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/mute ,i 0 to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/mute i 0 >> %buildtempFile%.%buildtempOutExt%
	if defined buildtempVarC (
::		echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarC% to %buildtempFile%.%buildtempOutExt%
		echo %buildtempDevID%^^^/track/%buildtempChanNum%/name s %buildtempVarC%>> %buildtempFile%.%buildtempOutExt%
	)
goto :endbuildREAPERfile

:: **********************************************Process the "SELECT" command

:: the SELECT command is easy...just mute the channel and you are done...maybe new name too


:buildREAPERSelectME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/select ,i 1 to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/select i 1 >> %buildtempFile%.%buildtempOutExt%
	if defined buildtempVarC (
::		echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarB% to %buildtempFile%.%buildtempOutExt%
		echo %buildtempDevID%^^^/track/%buildtempChanNum%/name s %buildtempVarC%>> %buildtempFile%.%buildtempOutExt%
	)
goto :endbuildREAPERfile


:: **********************************************Process the "UNSELECT" command

:: the UNSELECT command is easy...just unmute the channel and you are done...maybe new name too


:buildREAPERUNSelectME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/select ,i 0 to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/select i 0 >> %buildtempFile%.%buildtempOutExt%
	if defined buildtempVarC (
::		echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarC% to %buildtempFile%.%buildtempOutExt%
		echo %buildtempDevID%^^^/track/%buildtempChanNum%/name s %buildtempVarC%>> %buildtempFile%.%buildtempOutExt%
	)
goto :endbuildREAPERfile







:: **********************************************Process the "SENDand_UNMUTE_NAME" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not change the send, increments position counter
::   * terminates the string processing



:buildREAPERWorkSENDandUNMUTENAMEThisA

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
echo DERIVED:
echo	ChanNum:	%buildtempChanNum%
echo	OutExt: 	%buildtempOutExt%
echo	DeviceLetter:	%buildtempDeviceLetter%
echo	DeviceType:	%buildtempDeviceType%
echo	DeviceDelay:	%buildtempDeviceDelay%
)

set /a mySendPosition=1
set /a myCharacterInString=0


:buildREAPERsendlooper

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f 0  to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/send/%mySendPosition%/volume f 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooper
)
if "%buildtempchar%" EQU "1" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f %buildtempVarE%  to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/send/%mySendPosition%/volume f %buildtempVarE%>> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooper
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooper
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooper
)
if "%buildtempchar%" EQU "*" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/mute ,i 0 to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/mute i 0 >> %buildtempFile%.%buildtempOutExt%
	if defined buildtempVarD (
::		echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarE% to %buildtempFile%.%buildtempOutExt%
		echo %buildtempDevID%^^^/track/%buildtempChanNum%/name s %buildtempVarD%>> %buildtempFile%.%buildtempOutExt%
	)
	goto :endbuildREAPERfile
)
goto :endbuildREAPERfile


:: **********************************************Process the "SENDand_MUTE_NAME" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not change the send, increments position counter
::   * terminates the string processing


:buildREAPERWorkSENDandMUTENAMEThisA

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
echo DERIVED:
echo	ChanNum:	%buildtempChanNum%
echo	OutExt: 	%buildtempOutExt%
echo	DeviceLetter:	%buildtempDeviceLetter%
echo	DeviceType:	%buildtempDeviceType%
echo	DeviceDelay:	%buildtempDeviceDelay%
)

set /a mySendPosition=1
set /a myCharacterInString=0

:: echo Writing Reaper OSC line /track/%buildtempChanNum%/mute ,i 1 to %buildtempFile%.%buildtempOutExt%
echo %buildtempDevID%^^^/track/%buildtempChanNum%/mute i 1 >> %buildtempFile%.%buildtempOutExt%

:buildREAPERsendlooperA

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f 0  to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/send/%mySendPosition%/volume f 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooperA
)
if "%buildtempchar%" EQU "1" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f %buildtempVarE%  to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/send/%mySendPosition%/volume f %buildtempVarE%>> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooperA
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooperA
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooperA
)
if "%buildtempchar%" EQU "*" (
	if defined buildtempVarD (
::		echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarD% to %buildtempFile%.%buildtempOutExt%
		echo %buildtempDevID%^^^/track/%buildtempChanNum%/name s %buildtempVarD%>> %buildtempFile%.%buildtempOutExt%
	)
	goto :endbuildREAPERfile
)

goto :endbuildREAPERfile



:: **********************************************Process the "SENDand_UNMUTE" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not change the send, increments position counter
::   * terminates the string processing



:buildREAPERWorkSENDandUNMUTEThisA

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
echo DERIVED:
echo	ChanNum:	%buildtempChanNum%
echo	OutExt: 	%buildtempOutExt%
echo	DeviceLetter:	%buildtempDeviceLetter%
echo	DeviceType:	%buildtempDeviceType%
echo	DeviceDelay:	%buildtempDeviceDelay%
)

set /a mySendPosition=1
set /a myCharacterInString=0


:buildREAPERsendlooperB

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f 0  to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/send/%mySendPosition%/volume f 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooperB
)
if "%buildtempchar%" EQU "1" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f %buildtempVarD%  to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/send/%mySendPosition%/volume f %buildtempVarD%>> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooperB
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooperB
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooperB
)
if "%buildtempchar%" EQU "*" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/mute ,i 0 to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/mute i 0 >> %buildtempFile%.%buildtempOutExt%

	goto :endbuildREAPERfile
)
goto :endbuildREAPERfile


:: **********************************************Process the "SENDand_MUTE" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not change the send, increments position counter
::   * terminates the string processing


:buildREAPERWorkSENDandMUTEThisA

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
echo DERIVED:
echo	ChanNum:	%buildtempChanNum%
echo	OutExt: 	%buildtempOutExt%
echo	DeviceLetter:	%buildtempDeviceLetter%
echo	DeviceType:	%buildtempDeviceType%
echo	DeviceDelay:	%buildtempDeviceDelay%
)

set /a mySendPosition=1
set /a myCharacterInString=0

:: echo Writing Reaper OSC line /track/%buildtempChanNum%/mute ,i 1 to %buildtempFile%.%buildtempOutExt%
echo %buildtempDevID%^^^/track/%buildtempChanNum%/mute i 1 >> %buildtempFile%.%buildtempOutExt%

:buildREAPERsendlooperC

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f 0  to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/send/%mySendPosition%/volume f 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooperC
)
if "%buildtempchar%" EQU "1" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f %buildtempVarD%  to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/send/%mySendPosition%/volume f %buildtempVarD%>> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooperC
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooperC
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildREAPERsendlooperC
)
if "%buildtempchar%" EQU "*" (

	goto :endbuildREAPERfile
)

goto :endbuildREAPERfile




:: **********************************************Process the "PLUGIN_ADJ" command CUSTOM CODE

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   x does not change the send, increments position counter
::   * terminates the string processing
::   {anything else} processes specific custom code based on the character specified


:buildREAPERWorkPLUGIN_ADJThis

set mytempvarc=%%myPlugin.!buildtempVarC!%%
call set buildtempPluginString=!!mytempvarc!!

if not defined buildtempPluginString (
	color 04
	echo %buildtempPluginString% is not a valid Plugin Adjust string name!
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
echo DERIVED:
echo	ChanNum:	%buildtempChanNum%
echo	OutExt: 	%buildtempOutExt%
echo	DeviceLetter:	%buildtempDeviceLetter%
echo	DeviceType:	%buildtempDeviceType%
echo	DeviceDelay:	%buildtempDeviceDelay%
)
:: buildtempVarD and E variables an be used in your custom code as values as you desire

set /a myPluginPosition=1
set /a myCharacterInString=0

:buildREAPERpluginlooper

call set "buildtempchar=%%buildtempPluginString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "a" (
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/fx/%myPluginPosition%/fxparam/1/value f 1 >> %buildtempFile%.%buildtempOutExt%
	set /a myPluginPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERpluginlooper
)
if "%buildtempchar%" EQU "x" (
	set /a myPluginPosition+=1
	set /a myCharacterInString+=1
	goto :buildREAPERpluginlooper
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildREAPERpluginlooper
)
if "%buildtempchar%" EQU "*" (

	goto :endbuildREAPERfile
)

goto :endbuildREAPERfile




:: **********************************************Process the "MARKERNAME" command

:: the MARKERName command is easy...just place the name

:buildREAPERMARKERNAME

::	echo Writing Reaper OSC line /marker/%buildtempVarB%/name ,s %buildtempVarC%  to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/marker/%buildtempVarB%/name s "%buildtempVarC%">> %buildtempFile%.%buildtempOutExt%

goto :endbuildREAPERfile

:: **********************************************Process the "LASTMARKERNAME" command

:: the LASTMARKERName command is easy...just place the name

:buildREAPERLASTMARKERNAME

::	echo Writing Reaper OSC line /lastmarker/name ,s %buildtempVarB%  to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/lastmarker/name s "%buildtempVarB%">> %buildtempFile%.%buildtempOutExt%

goto :endbuildREAPERfile

:: **********************************************Process the "FXBYPASS" command

:buildREAPERFXBYPASSME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/fx/%buildtempVarC% ,i 0 to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/fx/%buildtempVarC% i 0 >> %buildtempFile%.%buildtempOutExt%

:: **********************************************Process the "FXACTIVE" command
goto :endbuildREAPERfile

:buildREAPERFXACTIVEME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/fx/%buildtempVarC% ,i 1 to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/fx/%buildtempVarC% i 1 >> %buildtempFile%.%buildtempOutExt%
goto :endbuildREAPERfile

:: **********************************************Process the "TRACKNAME" command

:buildREAPERTRACKNAME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarC% to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/name s %buildtempVarC%>> %buildtempFile%.%buildtempOutExt%
goto :endbuildREAPERfile

:: **********************************************Process the "TRACKVOLUME" command
:buildREAPERTRACKVOLUME
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/volume f %buildtempVarC%>> %buildtempFile%.%buildtempOutExt%

goto :endbuildREAPERfile

:: **********************************************Process the "TRACKPAN" command
:buildREAPERTRACKPAN
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/pan f %buildtempVarC%>> %buildtempFile%.%buildtempOutExt%

goto :endbuildREAPERfile
:: **********************************************Process the "ACTIONi" command

:buildREAPERACTIONi
::	echo Writing Reaper OSC line /action ,i %buildtempVarB% to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/action i %buildtempVarB%>> %buildtempFile%.%buildtempOutExt%
goto :endbuildREAPERfile
:: **********************************************Process the "ACTIONs" command

:buildREAPERACTIONs
::	echo Writing Reaper OSC line /action/str ,s %buildtempVarB% to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/action/str s %buildtempVarB%>> %buildtempFile%.%buildtempOutExt%
goto :endbuildREAPERfile

:: **********************************************Process the "FXOPENUI" command

:buildREAPERFXOPENUI
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/fx/%buildtempVarC%/openui ,i 1 to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/fx/%buildtempVarC%/openui i 1 >> %buildtempFile%.%buildtempOutExt%

:: **********************************************Process the "FXCLOSEUI" command
goto :endbuildREAPERfile

:buildREAPERFXCLOSEUI
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/fx/%buildtempVarC%/openui ,i 0 to %buildtempFile%.%buildtempOutExt%
	echo %buildtempDevID%^^^/track/%buildtempChanNum%/fx/%buildtempVarC%/openui i 0 >> %buildtempFile%.%buildtempOutExt%
goto :endbuildREAPERfile





:: **********************************************Process the "createfile" command

:: create an empty cue file so later output can just worry about appending to it
:buildREAPERCREATEFILE
	type NUL > %buildtempFile%.%buildtempOutExt%
	:: echo delay %buildtempDeviceDelay%>> %buildtempFile%.%buildtempOutExt%

	echo Now building file %buildtempFile%.%buildtempOutExt%
	goto :endbuildREAPERfile



:: **********************************************Process the "CUSTOMStartCue" command


:buildREAPERCUSTOMStartCue

type NUL > %buildtempFile%.%buildtempOutExt%
echo Created file %buildtempFile%.%buildtempOutExt%
:: echo delay %buildtempDeviceDelay%>> %buildtempFile%.%buildtempOutExt%
echo %buildtempDevID%^^^/track/%buildtempChanNum%/name s "*%buildtempVarC%">> %buildtempFile%.%buildtempOutExt%
goto :endbuildREAPERfile

:: **********************************************Process the "CUSTOMEndCue" command


:buildREAPERCUSTOMEndCue


echo %buildtempDevID%^^^/track/%buildtempChanNum%/name s "%buildtempVarC%">> %buildtempFile%.%buildtempOutExt%
echo %buildtempDevID%^^^/action i 40157>> %buildtempFile%.%buildtempOutExt%
echo %buildtempDevID%^^^/lastmarker/name s "%buildtempVarC%">> %buildtempFile%.%buildtempOutExt%
goto :endbuildREAPERfile




:: **********************************************Process the "GOTOMarker" command

:: the GOTOMarker command is easy...just one argument 


:buildREAPERGOTOMarker
	echo %buildtempDevID%^^^/marker i %buildtempVarB%>> %buildtempFile%.%buildtempOutExt%	
goto :endbuildREAPERfile



:: **********************************************Process the "STOP" command

:: the STOP command is easy...just toggle


:buildREAPERSTOP
	echo %buildtempDevID%^^^/stop i 1 >> %buildtempFile%.%buildtempOutExt%	
goto :endbuildREAPERfile


:: **********************************************Process the "PLAY" command

:: the PLAY command is easy...just toggle


:buildREAPERPLAY
	echo %buildtempDevID%^^^/play i 1 >> %buildtempFile%.%buildtempOutExt%	
goto :endbuildREAPERfile

:: **********************************************Process the "RECORD" command

:: the RECORD command is easy...just toggle


:buildREAPERRECORD
	echo %buildtempDevID%^^^/record i 1 >> %buildtempFile%.%buildtempOutExt%	
goto :endbuildREAPERfile

:: **********************************************Process the "PAUSE" command

:: the PAUSE command is easy...just toggle


:buildREAPERPAUSE
	echo %buildtempDevID%^^^/pause i 1 >> %buildtempFile%.%buildtempOutExt%	
goto :endbuildREAPERfile


:endbuildREAPERfile
goto :endALLbuildfile
:: ********************************** END REAPER *********************************************************************************

:: ********************************** START X32 *********************************************************************************

:BuildX32CueContent

:: Find the Channel Number for the name proivided in VarB

set tempvarb=%%myChan.!buildtempVarB!%%
call set buildtempChanNum=!!tempvarb!!


if %buildtempCmd% EQU # goto :endbuildX32file





:: set buildtempDeviceLetter=%buildtempFile:~0,1%

:: now pull device type and delay

:: set tempvartype=%%Type.!buildtempDeviceLetter!%%
call set buildtempDeviceType=!!tempvartype!!


set tempvardelay=%%Delay.!buildtempDeviceLetter!%%
call set buildtempDeviceDelay=!!tempvardelay!!

set mytempvarc=%%mySend.!buildtempVarC!%%
call set buildtempSendString=!!mytempvarc!!



::  ****************** Use X32 syntax ******************


if %buildtempCmd% EQU CHAN goto :buildX32CHAN
if %buildtempCmd% EQU CHANNAME goto :buildX32CHANNAME
if %buildtempCmd% EQU CHANCOLOR goto :buildX32CHANCOLOR
if %buildtempCmd% EQU CHANDCA goto :buildX32CHANDCA
if %buildtempCmd% EQU CHANSEND goto :buildX32CHANSEND

if %buildtempCmd% EQU DCA goto :buildX32DCA
if %buildtempCmd% EQU DCANAME goto :buildX32DCANAME
if %buildtempCmd% EQU DCACOLOR goto :buildX32DCACOLOR

if %buildtempCmd% EQU VARIABLEFROMFILE goto :buildX32VARIABLEFROMFILE
if %buildtempCmd% EQU BUS goto :buildX32BUS
if %buildtempCmd% EQU BUSNAME goto :buildX32BUSNAME
if %buildtempCmd% EQU BUSCOLOR goto :buildX32BUSCOLOR

if %buildtempCmd% EQU MAINST goto :buildX32MAINST
if %buildtempCmd% EQU MAINSTNAME goto :buildX32MAINSTNAME
if %buildtempCmd% EQU MAINSTCOLOR goto :buildX32MAINSTCOLOR

if %buildtempCmd% EQU MAINM goto :buildX32MAINM
if %buildtempCmd% EQU MAINMNAME goto :buildX32MAINMNAME
if %buildtempCmd% EQU MAINMCOLOR goto :buildX32MAINMCOLOR

if %buildtempCmd% EQU USB_RECORDER goto :buildX32USBRECORDER
if %buildtempCmd% EQU LIVE_RECORDER goto :buildX32LIVERECORDER

if %buildtempCmd% EQU ROUTE_OUT goto :buildX32ROUTE_OUT
if %buildtempCmd% EQU ROUTE_IN goto :buildX32ROUTE_IN

if %buildtempCmd% EQU createfile goto :buildX32CREATEFILE

if %buildtempCmd% EQU CUSTOMStartCue goto :buildX32CUSTOMStartCue

if %buildtempCmd% EQU CUSTOMEndCue goto :buildX32CustomEndCue

if %buildtempCmd% EQU SENDand_MUTE goto :buildX32SENDandMUTE
if %buildtempCmd% EQU SENDand_UNMUTE goto :buildX32SENDandUNMUTE


if %buildtempCmd% EQU SAVESCENE goto :buildX32SAVESCENE
if %buildtempCmd% EQU SAVESNIPPET goto :buildX32SAVESNIPPET
if %buildtempCmd% EQU LOADSCENE goto :buildX32LOADSCENE
if %buildtempCmd% EQU LOADSNIPPET goto :buildX32LOADSNIPPET

echo ***************** UNKNOWN COMMAND RECEIVED ******************************
echo %buildtempCMD%
echo *************************************************************************
goto :endXbuildX32file


:: **********************************************Process the "CHAN" command

:: the CHAN command is easy...just mute or unmute the channel and you are done


:buildX32CHAN
set myFOUNDIT=0

:: Find the Channel Number for the name proivided in VarB

set tempvarb=%%myChan.!buildtempVarB!%%
call set buildtempChanNum=!!tempvarb!!

if not defined buildtempChanNum (
	color 04
	echo %buildtempVarB% is not a valid channel name!
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


:: echo chan num is %buildtempChanNum%

if %buildtempVarC% EQU MUTE (
::	echo MUTE FOUND
	echo %buildtempDevID%^^^/ch/%buildtempChanNum%/mix/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarC% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo %buildtempDevID%^^^/ch/%buildtempChanNum%/mix/on i 1 >> %buildtempFile%.%buildtempOutExt%
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

goto :endbuildX32file

:: **********************************************Process the "VARIABLEFROMFILE" command

:: the VARIABLEFROMFILE command is easy...just dump the string


:buildX32VARIABLEFROMFILE

:: Find the TRACK Number for the name provided in VarB

set tempvarb=%buildtempVarB%

:: echo var %w1_cue001a%
:: echo vb !%tempvarb%!

:: echo 
	echo %buildtempDevID%^^^^!%tempvarb%!>> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file


:: **********************************************Process the "CHANNAME" command

:: the CHANNAME command is easy...just name the channel and you are done


:buildX32CHANNAME

:: Find the Channel Number for the name proivided in VarB

set tempvarb=%%myChan.!buildtempVarB!%%
call set buildtempChanNum=!!tempvarb!!

if not defined buildtempChanNum (
	color 04
	echo %buildtempVarB% is not a valid channel name!
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


:: echo chan num is %buildtempChanNum%
	echo %buildtempDevID%^^^/ch/%buildtempChanNum%/config/name s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file


:: **********************************************Process the "CHANCOLOR" command

:: the CHANNAME command is easy...just color the channel and you are done


:buildX32CHANCOLOR

:: Find the Channel Number for the name proivided in VarB

set tempvarb=%%myChan.!buildtempVarB!%%
call set buildtempChanNum=!!tempvarb!!

if not defined buildtempChanNum (
	color 04
	echo %buildtempVarB% is not a valid channel name!
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


	echo %buildtempDevID%^^^/ch/%buildtempChanNum%/config/color i %buildtempColor% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file


:: **********************************************Process the "CHANDCA" command

:: the CHANDCA command is easy...look up values and set it


:buildX32CHANDCA

:: Find the Channel Number for the name provided in VarB

set tempvarb=%%myChan.!buildtempVarB!%%
call set buildtempChanNum=!!tempvarb!!

if not defined buildtempChanNum (
	color 04
	echo %buildtempVarB% is not a valid channel name!
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


:: Find the DCA Value for the name provided in VarC
set tempvarc=%%myDCAassign.!buildtempVarC!%%
call set buildtempDCANum=!!tempvarc!!

if not defined buildtempDCANum (
	color 04
	echo %buildtempVarC% is not a valid DCA name!
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


	echo %buildtempDevID%^^^/ch/%buildtempChanNum%/grp/dca i %buildtempDCANum% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file






:: **********************************************Process the "CHANSEND" command

:: the CHANSEND command is easy...just mute or unmute the channel send and you are done


:buildX32CHANSEND
set myFOUNDIT=0

:: Find the Channel Number for the name proivided in VarB

set tempvarb=%%myChan.!buildtempVarB!%%
call set buildtempChanNum=!!tempvarb!!

if not defined buildtempChanNum (
	color 04
	echo %buildtempVarB% is not a valid channel name!
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

set tempvarc=%%myBus.!buildtempVarC!%%
call set buildtempBusNum=!!tempvarC!!

if not defined buildtempBusNum (
	color 04
	echo %buildtempVarC% is not a valid Bus name!
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
	echo %buildtempDevID%^^^/ch/%buildtempChanNum%/mix/%buildtempBusNum%/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarD% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo %buildtempDevID%^^^/ch/%buildtempChanNum%/mix/%buildtempBusNum%/on i 1 >> %buildtempFile%.%buildtempOutExt%
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

goto :endbuildX32file







:: **********************************************Process the "DCA" command

:: the DCA command is easy...just mute or unmute the DCA and you are done


:buildX32DCA
set myFOUNDIT=0

:: Find the DCA Number for the name proivided in VarB

set tempvarb=%%myDCA.!buildtempVarB!%%
call set buildtempDCANum=!!tempvarb!!

if not defined buildtempDCANum (
	color 04
	echo %buildtempVarB% is not a valid DCA name!
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



if %buildtempVarC% EQU MUTE (
::	echo MUTE FOUND
	echo %buildtempDevID%^^^/dca/%buildtempDCANum%/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarC% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo %buildtempDevID%^^^/dca/%buildtempDCANum%/on i 1 >> %buildtempFile%.%buildtempOutExt%
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

goto :endbuildX32file


:: **********************************************Process the "DCANAME" command

:: the DCANAME command is easy...just name the DCA and you are done


:buildX32DCANAME

:: Find the DCA Number for the name proivided in VarB

set tempvarb=%%myDCA.!buildtempVarB!%%
call set buildtempDCANum=!!tempvarb!!

if not defined buildtempDCANum (
	color 04
	echo %buildtempVarB% is not a valid DCA name!
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


	echo %buildtempDevID%^^^/dca/%buildtempDCANum%/config/name s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file


:: **********************************************Process the "DCACOLOR" command

:: the DCANAME command is easy...just color the DCA and you are done


:buildX32DCACOLOR

:: Find the DCA Number for the name proivided in VarB

set tempvarb=%%myDCA.!buildtempVarB!%%
call set buildtempDCANum=!!tempvarb!!

if not defined buildtempDCANum (
	color 04
	echo %buildtempVarB% is not a valid DCA name!
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

	echo %buildtempDevID%^^^/dca/%buildtempDCANum%/config/color i %buildtempColor% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file


:: **********************************************Process the "BUS" command

:: the BUS command is easy...just mute or unmute the BUS and you are done


:buildX32BUS
set myFOUNDIT=0

:: Find the BUS Number for the name proivided in VarB

set tempvarb=%%myBus.!buildtempVarB!%%
call set buildtempBUSNum=!!tempvarb!!

if not defined buildtempBUSNum (
	color 04
	echo %buildtempVarB% is not a valid BUS name!
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



if %buildtempVarC% EQU MUTE (
::	echo MUTE FOUND
	echo %buildtempDevID%^^^/bus/%buildtempBUSNum%/mix/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarC% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo %buildtempDevID%^^^/bus/%buildtempBUSNum%/mix/on i 1 >> %buildtempFile%.%buildtempOutExt%
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

goto :endbuildX32file


:: **********************************************Process the "BUSNAME" command

:: the BUSNAME command is easy...just name the Bus and you are done


:buildX32BUSNAME

:: Find the BUS Number for the name proivided in VarB

set tempvarb=%%myBus.!buildtempVarB!%%
call set buildtempBUSNum=!!tempvarb!!

if not defined buildtempBUSNum (
	color 04
	echo %buildtempVarB% is not a valid BUS name!
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


	echo %buildtempDevID%^^^/bus/%buildtempBUSNum%/config/name s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file


:: **********************************************Process the "BUSCOLOR" command

:: the BUSCOLOR command is easy...just color the BUS and you are done


:buildX32BUSCOLOR

:: Find the BUS Number for the name proivided in VarB

set tempvarb=%%myBUS.!buildtempVarB!%%
call set buildtempBUSNum=!!tempvarb!!

if not defined buildtempBUSNum (
	color 04
	echo %buildtempVarB% is not a valid BUS name!
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

	echo %buildtempDevID%^^^/bus/%buildtempBUSNum%/config/color i %buildtempColor% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file




:: **********************************************Process the "MAINST" command

:: the MAINST command is easy...just mute or unmute the MAIN Stereo and you are done


:buildX32MAINST



if %buildtempVarB% EQU MUTE (
::	echo MUTE FOUND
	echo %buildtempDevID%^^^/main/st/mix/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarB% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo %buildtempDevID%^^^/main/st/mix/on i 1 >> %buildtempFile%.%buildtempOutExt%
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

goto :endbuildX32file


:: **********************************************Process the "MAINSTNAME" command

:: the MAINSTNAME command is easy...just name the MAIN ST and you are done


:buildX32MAINSTNAME


	echo %buildtempDevID%^^^/main/st/config/name s %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file


:: **********************************************Process the "MAINSTCOLOR" command

:: the MAINSTCOLOR command is easy...just color the MAINST and you are done


:buildX32MAINSTCOLOR
:: Find the Color for the name proivided in VarB

set tempvarb=%%myColor.!buildtempVarB!%%
call set buildtempColor=!!tempvarb!!

if not defined buildtempColor (
	color 04
	echo %buildtempVarB% is not a valid color name!
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

	echo %buildtempDevID%^^^/main/st/config/color i %buildtempColor% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file

:: **********************************************Process the "MAINM" command

:: the MAINM command is easy...just mute or unmute the MAINM and you are done


:buildX32MAINM



if %buildtempVarB% EQU MUTE (
::	echo MUTE FOUND
	echo %buildtempDevID%^^^/main/m/mix/on i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarB% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo %buildtempDevID%^^^/main/m/mix/on i 1 >> %buildtempFile%.%buildtempOutExt%
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

goto :endbuildX32file


:: **********************************************Process the "MAINMNAME" command

:: the MAINMNAME command is easy...just name the MAIN M and you are done


:buildX32MAINMNAME


	echo %buildtempDevID%^^^/main/m/config/name s %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file


:: **********************************************Process the "MAINMCOLOR" command

:: the MAINMCOLOR command is easy...just color the MAIN Mand you are done


:buildX32MAINMCOLOR
set tempvarb=%%myColor.!buildtempVarB!%%
call set buildtempColor=!!tempvarb!!

if not defined buildtempColor (
	color 04
	echo %buildtempVarB% is not a valid color name!
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

	echo %buildtempDevID%^^^/main/m/config/color i %buildtempColor% >> %buildtempFile%.%buildtempOutExt%


goto :endbuildX32file


:: *****************************
:: *****************************


:: **********************************************Process the "ROUTE_OUT" command

:: the ROUTE_OUT interprets 2 values and does one command


:buildX32ROUTE_OUT

:: Find the ROUTE Out for the name proivided in VarB

set tempvarb=%%myRouteOut.!buildtempVarB!%%
call set buildtempRouteOut=!!tempvarb!!

if not defined buildtempRouteOut (
	color 04
	echo %buildtempVarB% is not a valid Route Out value!
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


:: Find the ROUTE Name for the name proivided in VarC

set tempvarc=%%myRouteSourceOut.!buildtempVarC!%%
call set buildtempRouteName=!!tempvarc!!

if not defined buildtempRouteName (
	color 04
	echo %buildtempVarC% is not a valid Route Name value!
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


	echo %buildtempDevID%^^^/config/userrout/out/%buildtempRouteOut% i %buildtempRouteName% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file

:: **********************************************Process the "ROUTE_IN" command

:: the ROUTE_IN interprets 2 values and does one command


:buildX32ROUTE_IN

:: Find the ROUTE In for the name proivided in VarB

set tempvarb=%%myRouteIn.!buildtempVarB!%%
call set buildtempRouteIn=!!tempvarb!!

if not defined buildtempRouteIn (
	color 04
	echo %buildtempVarB% is not a valid Route In value!
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


:: Find the ROUTE Name for the name proivided in VarC

set tempvarc=%%myRouteSourceOut.!buildtempVarC!%%
call set buildtempRouteName=!!tempvarc!!

if not defined buildtempRouteName (
	color 04
	echo %buildtempVarC% is not a valid Route Name value!
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


	echo %buildtempDevID%^^^/config/userrout/in/%buildtempRouteIn% i %buildtempRouteName% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildX32file


:: **********************************************Process the "USBRECORDER" command

:: the USBRECORDER command is easy...just look up and set the value


:buildX32USBRECORDER
set tempvarb=%%myTape.!buildtempVarB!%%
call set buildtempUSBRECORDER=!!tempvarb!!

if not defined buildtempUSBRECORDER (
	color 04
	echo %buildtempVarB% is not a valid USB RECORDER choice!
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

	echo %buildtempDevID%^^^/-stat/tape/state i %buildtempUSBRECORDER% >> %buildtempFile%.%buildtempOutExt%


goto :endbuildX32file

:: **********************************************Process the "LIVERECORDER" command

:: the LIVERECORDER command is easy...just look up and set the value


:buildX32LIVERECORDER
set tempvarb=%%myCard.!buildtempVarB!%%
call set buildtempLIVERECORDER=!!tempvarb!!

if not defined buildtempLIVERECORDER (
	color 04
	echo %buildtempVarB% is not a valid LIVE RECORDER choice!
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

	echo %buildtempDevID%^^^/-stat/urec/state i %buildtempLIVERECORDER% >> %buildtempFile%.%buildtempOutExt%


goto :endbuildX32file


:: **********************************************Process the "SENDand_UNMUTE" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not change the send, increments position counter
::   * terminates the string processing



:buildX32SENDandUNMUTE


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

set /a mySendPosition=1
set /a myCharacterInString=0






:buildX32sendlooperB
set derivedSendPosition=%mySendPosition%
:: now for x32 the OSC requires a 2 digit track number so add leading 0 if needed
if %mySendPosition% LSS 10 set derivedSendPosition=0%mySendPosition%

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
	echo %buildtempDevID%^^^/ch/%buildtempChanNum%/mix/%derivedSendPosition%/on f 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildX32sendlooperB
)
if "%buildtempchar%" EQU "1" (
	echo %buildtempDevID%^^^/ch/%buildtempChanNum%/mix/%derivedSendPosition%/on f 1 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildX32sendlooperB
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildX32sendlooperB
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildX32sendlooperB
)
if "%buildtempchar%" EQU "*" (
	:: unmute the channel
	echo %buildtempDevID%^^^/ch/%buildtempChanNum%/mix/on i 1 >> %buildtempFile%.%buildtempOutExt%

	goto :endbuildX32file
)

goto :endbuildX32file


:: **********************************************Process the "SENDand_MUTE" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not change the send, increments position counter
::   * terminates the string processing


:buildX32SENDandMUTE

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

set /a mySendPosition=1
set /a myCharacterInString=0

:: mute the channel
echo %buildtempDevID%^^^/ch/%buildtempChanNum%/mix/on i 0 >> %buildtempFile%.%buildtempOutExt%

:buildX32sendlooperC
set derivedSendPosition=%mySendPosition%
:: now for x32 the OSC requires a 2 digit track number so add leading 0 if needed
if %mySendPosition% LSS 10 set derivedSendPosition=0%mySendPosition%

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
	echo %buildtempDevID%^^^/ch/%buildtempChanNum%/mix/%derivedSendPosition%/on f 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildX32sendlooperC
)
if "%buildtempchar%" EQU "1" (
	echo %buildtempDevID%^^^/ch/%buildtempChanNum%/mix/%derivedSendPosition%/on f 1 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildX32sendlooperC
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildX32sendlooperC
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildX32sendlooperC
)
if "%buildtempchar%" EQU "*" (

	goto :endbuildX32file
)

goto :endbuildX32file



:: **********************************************Process the "createfile" command

:: create an empty cue file so later output can just worry about appending to it
:buildX32CREATEFILE
	type NUL > %buildtempFile%.%buildtempOutExt%
	::echo delay %buildtempDeviceDelay% >> %buildtempFile%.%buildtempOutExt%

	echo Now building file %buildtempFile%.%buildtempOutExt%
	goto :endbuildX32file



:: **********************************************Process the "CUSTOMStartCue" command


:buildX32CUSTOMStartCue

type NUL > %buildtempFile%.%buildtempOutExt%
echo Created file %buildtempFile%.%buildtempOutExt%
::echo delay %buildtempDeviceDelay% >> %buildtempFile%.%buildtempOutExt%
echo %buildtempDevID%^^^/main/st/config/name s *%buildtempVarB% >> %buildtempFile%.%buildtempOutExt%
goto :endbuildX32file

:: **********************************************Process the "CUSTOMEndCue" command


:buildX32CUSTOMEndCue


echo %buildtempDevID%^^^/main/st/config/name s %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%
goto :endbuilX32dfile



:: **********************************************Process the "PAUSE" command

:: the PAUSE command is easy...just toggle


:buildX32PAUSE
	echo %buildtempDevID%^^^/pause i 1 >> %buildtempFile%.%buildtempOutExt%	
goto :endbuildX32file

:: **********************************************Process the "SAVESCENE" command

:buildX32SAVESCENE

echo %buildtempDevID%^^^/save s scene i %buildtempVarB% s "%buildtempVarC%" s "%buildtempVarD%" >> %buildtempFile%.%buildtempOutExt%
goto :endbuildX32file

:: **********************************************Process the "SAVESNIPPET" command

:buildX32SAVESNIPPET

echo %buildtempDevID%^^^/save s snippet i %buildtempVarB% s "%buildtempVarC%" >> %buildtempFile%.%buildtempOutExt%
goto :endbuildX32file

:: **********************************************Process the "LOADSCENE" command

:buildX32LOADSCENE

echo %buildtempDevID%^^^/load s scene i %buildtempVarB%  >> %buildtempFile%.%buildtempOutExt%
goto :endbuildX32file

:: **********************************************Process the "LOADSNIPPPET" command

:buildX32LOADSNIPPET

echo %buildtempDevID%^^^/load s snippet i %buildtempVarB%  >> %buildtempFile%.%buildtempOutExt%
goto :endbuildX32file


:endbuildX32file
goto :endALLbuildfile




:: END OF ALL FLAVORS ***************************************************************************************************************


:endALLbuildfile
:: echo ending
exit /B
:: ************************************************************
:: ************************************************************

:ENDOFSCRIPT







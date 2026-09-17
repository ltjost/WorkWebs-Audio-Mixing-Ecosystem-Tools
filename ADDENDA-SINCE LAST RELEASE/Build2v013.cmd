ECHO OFF
color 06
set scriptver=Build2v013 now with WING, X32 and REAPER support plus PASSTHROUGH
setlocal enabledelayedexpansion



:: display some initial script info for the record!  Weird code strips quote marks from the string so it displays nicely
set tempstring="."
set tempstringx=%tempstring:"=%
echo %tempstringx%
set tempstring=".      *** " MERMAID  %scriptver% "   ***"
set tempstringx=%tempstring:"=%
echo %tempstringx%
set tempstring="."
set tempstringx=%tempstring:"=%
echo %tempstringx%

echo LED on/off is presently not generated with settracktolatestdca

:: **************************************************************************************
:: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
:: ******************************** SET THESE *******************************************

:: Each Device to communicate with is designated by a Device String.
:: Each device has a TYPE that is used to set up OSC messages in the correct format.
:: This script currently accepts the following TYPES:
:: 	WING

:: Cues for this specific device of the specified TYPE are also tied to this 
::  Device String.  The Device String is used for the RUN script to find IP and Port.


:: Also set Delay...this is the number of ms that wosc should wait between
:: sending commands.  THIS IS A REDIDUAL value and is not used anymore.
::  A value of 0 to 10 is recommended 

:: This is a single character designation.

set Type.WING1=WING
set Delay.WING1=0

set Type.WING2=WING
set Delay.WING2=0

set Type.REAPER1=REAPER
set Delay.REAPER1=0

set Type.X1=X32
set Delay.X1=0

set Type.PASSTHROUGH=PASSTHROUGH
set Delay.PASSTHROUGH=0


:: The file extension defines the set of cues for a project
:: the generated commands will be placed in the same file name with OUT prior to the specified
:: extension being again added to the end of the file name

set myFileExtension=cuex


:: ********************************SPECIAL NOTE PASSTHROUGH ****************************************************************

:: If the line read in from the cue file starts with PASSTHROUGH then everything after the | is placed directly into the output file.  At RUN time this allows you
:: to run any custom command you want.  Be sure to start the PASSTHROUGH content with a device identifier so that you can define an
:: IP and PORT for it in the RUN script and have what you specify passed to that dvice when the cue is run.  Format of the OSC command needs to align with what SENDOSC uses.
::example: 
:: PASSTHROUGH|WING3^^/someosc/moreosc i 1
:: in the cue file is processed by build to add this in thr output cue:
::  WING3^/someosc/moreosc i 1
:: in RUN, WING3 will define an IP and Port and the subsequent OSC will be sent to that IP and Port.
:: NOTE the use of ^^ instead of ^ to separate the device from the OSC



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

set myWingColor.MEDIUMBLUE=1
set myWingColor.BRIGHTBLUE=2
set myWingColor.VIOLET=3
set myWingColor.TURQUOISE=4
set myWingColor.GREEN=5
set myWingColor.OLIVEGREEN=6
set myWingColor.YELLOW=7
set myWingColor.BROWN=8
set myWingColor.RED=9
set myWingColor.CORAL=10
set myWingColor.PINK=11
set myWingColor.DARKVIOLET=12
set myWingColor.GOLD=13
set myWingColor.LIGHTBLUE=14
set myWingColor.TANGERINE=15
set myWingColor.LIGHTGREEN=16
set myWingColor.GRAY=17
set myWingColor.WHITE=18



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

:: *************************************************************WING USER VARS**************************
:: WING VARIABLES USER SET

set  myTrackVar.w1cCaroline=1
set  myTrackVar.w1cCaroline.type=ch
set  myTrackVar.w1cCaroline.color.on=%myWingColor.PINK
set  myTrackVar.w1cCaroline.color.off=%myWingColor.GRAY

set  myTrackVar.w1cGabriel=2
set  myTrackVar.w1cGabriel.type=ch
set  myTrackVar.w1cGabriel.color.on=%myWingColor.PINK
set  myTrackVar.w1cGabriel.color.off=%myWingColor.GRAY

set  myTrackVar.w1cKeith=3
set  myTrackVar.w1cKeith.type=ch
set  myTrackVar.w1cKeith.color.on=%myWingColor.LIGHTBLUE
set  myTrackVar.w1cKeith.color.off=%myWingColor.GRAY

set  myTrackVar.w1cChadly=4
set  myTrackVar.w1cChadly.type=ch
set  myTrackVar.w1cChadly.color.on=%myWingColor.RED
set  myTrackVar.w1cChadly.color.off=%myWingColor.GRAY

set  myTrackVar.w1cAnna=5
set  myTrackVar.w1cAnna.type=ch
set  myTrackVar.w1cAnna.color.on=%myWingColor.CORAL
set  myTrackVar.w1cAnna.color.off=%myWingColor.GRAY

set  myTrackVar.w1cMargery=6
set  myTrackVar.w1cMargery.type=ch
set  myTrackVar.w1cMargery.color.on=%myWingColor.GREEN
set  myTrackVar.w1cMargery.color.off=%myWingColor.GRAY

set  myTrackVar.w1cJohn=7
set  myTrackVar.w1cJohn.type=ch
set  myTrackVar.w1cJohn.color.on=%myWingColor.GOLD
set  myTrackVar.w1cJohn.color.off=%myWingColor.GRAY

set  myTrackVar.w1cJudah=8
set  myTrackVar.w1cJudah.type=ch
set  myTrackVar.w1cJudah.color.on=%myWingColor.RED
set  myTrackVar.w1cJudah.color.off=%myWingColor.GRAY

set  myTrackVar.w1cBridget=9
set  myTrackVar.w1cBridget.type=ch
set  myTrackVar.w1cBridget.color.on=%myWingColor.GOLD
set  myTrackVar.w1cBridget.color.off=%myWingColor.GRAY

set  myTrackVar.w1cDylan=10
set  myTrackVar.w1cDylan.type=ch
set  myTrackVar.w1cDylan.color.on=%myWingColor.TANGERINE
set  myTrackVar.w1cDylan.color.off=%myWingColor.GRAY

set  myTrackVar.w1cElijah=11
set  myTrackVar.w1cElijah.type=ch
set  myTrackVar.w1cElijah.color.on=%myWingColor.TANGERINE
set  myTrackVar.w1cElijah.color.off=%myWingColor.GRAY

set  myTrackVar.w1cSyr=12
set  myTrackVar.w1cSyr.type=ch
set  myTrackVar.w1cSyr.color.on=%myWingColor.BRIGHTBLUE
set  myTrackVar.w1cSyr.color.off=%myWingColor.GRAY

set  myTrackVar.w1cKatelyn=13
set  myTrackVar.w1cKatelyn.type=ch
set  myTrackVar.w1cKatelyn.color.on=%myWingColor.GOLD
set  myTrackVar.w1cKatelyn.color.off=%myWingColor.GRAY

set  myTrackVar.w1cNadja=14
set  myTrackVar.w1cNadja.type=ch
set  myTrackVar.w1cNadja.color.on=%myWingColor.GOLD
set  myTrackVar.w1cNadja.color.off=%myWingColor.GRAY

set  myTrackVar.w1cRachelP=15
set  myTrackVar.w1cRachelP.type=ch
set  myTrackVar.w1cRachelP.color.on=%myWingColor.GOLD
set  myTrackVar.w1cRachelP.color.off=%myWingColor.GRAY

set  myTrackVar.w1cMaura=16
set  myTrackVar.w1cMaura.type=ch
set  myTrackVar.w1cMaura.color.on=%myWingColor.GOLD
set  myTrackVar.w1cMaura.color.off=%myWingColor.GRAY

set  myTrackVar.w1cJacklyn=17
set  myTrackVar.w1cJacklyn.type=ch
set  myTrackVar.w1cJacklyn.color.on=%myWingColor.GOLD
set  myTrackVar.w1cJacklyn.color.off=%myWingColor.GRAY

set  myTrackVar.w1cSarah=18
set  myTrackVar.w1cSarah.type=ch
set  myTrackVar.w1cSarah.color.on=%myWingColor.GOLD
set  myTrackVar.w1cSarah.color.off=%myWingColor.GRAY

set  myTrackVar.w1cRebecca=19
set  myTrackVar.w1cRebecca.type=ch
set  myTrackVar.w1cRebecca.color.on=%myWingColor.WHITE
set  myTrackVar.w1cRebecca.color.off=%myWingColor.GRAY

set  myTrackVar.w1cAnnie=20
set  myTrackVar.w1cAnnie.type=ch
set  myTrackVar.w1cAnnie.color.on=%myWingColor.WHITE
set  myTrackVar.w1cAnnie.color.off=%myWingColor.GRAY

set  myTrackVar.w1cKara=21
set  myTrackVar.w1cKara.type=ch
set  myTrackVar.w1cKara.color.on=%myWingColor.WHITE
set  myTrackVar.w1cKara.color.off=%myWingColor.GRAY

set  myTrackVar.w1cGenevieve=22
set  myTrackVar.w1cGenevieve.type=ch
set  myTrackVar.w1cGenevieve.color.on=%myWingColor.TURQUOISE
set  myTrackVar.w1cGenevieve.color.off=%myWingColor.GRAY

set  myTrackVar.w1cJocelyn=23
set  myTrackVar.w1cJocelyn.type=ch
set  myTrackVar.w1cJocelyn.color.on=%myWingColor.TURQUOISE
set  myTrackVar.w1cJocelyn.color.off=%myWingColor.GRAY

set  myTrackVar.w1cDavid=24
set  myTrackVar.w1cDavid.type=ch
set  myTrackVar.w1cDavid.color.on=%myWingColor.BROWN
set  myTrackVar.w1cDavid.color.off=%myWingColor.GRAY

set  myTrackVar.w1cRobert=25
set  myTrackVar.w1cRobert.type=ch
set  myTrackVar.w1cRobert.color.on=%myWingColor.BROWN
set  myTrackVar.w1cRobert.color.off=%myWingColor.GRAY

set  myTrackVar.w1cThomas=26
set  myTrackVar.w1cThomas.type=ch
set  myTrackVar.w1cThomas.color.on=%myWingColor.BROWN
set  myTrackVar.w1cThomas.color.off=%myWingColor.GRAY

set  myTrackVar.w1cBill=27
set  myTrackVar.w1cBill.type=ch
set  myTrackVar.w1cBill.color.on=%myWingColor.BROWN
set  myTrackVar.w1cBill.color.off=%myWingColor.GRAY

set  myTrackVar.w1cDennis=28
set  myTrackVar.w1cDennis.type=ch
set  myTrackVar.w1cDennis.color.on=%myWingColor.BROWN
set  myTrackVar.w1cDennis.color.off=%myWingColor.GRAY

set  myTrackVar.w1cJoshua=29
set  myTrackVar.w1cJoshua.type=ch
set  myTrackVar.w1cJoshua.color.on=%myWingColor.BROWN
set  myTrackVar.w1cJoshua.color.off=%myWingColor.GRAY

set  myTrackVar.w1cRay=30
set  myTrackVar.w1cRay.type=ch
set  myTrackVar.w1cRay.color.on=%myWingColor.BROWN
set  myTrackVar.w1cRay.color.off=%myWingColor.GRAY

set  myTrackVar.w1cWilliam=31
set  myTrackVar.w1cWilliam.type=ch
set  myTrackVar.w1cWilliam.color.on=%myWingColor.LIGHTGREEN
set  myTrackVar.w1cWilliam.color.off=%myWingColor.GRAY

set  myTrackVar.w1cPriscilla=32
set  myTrackVar.w1cPriscilla.type=ch
set  myTrackVar.w1cPriscilla.color.on=%myWingColor.LIGHTGREEN
set  myTrackVar.w1cPriscilla.color.off=%myWingColor.GRAY

set  myTrackVar.w1cRachelS=33
set  myTrackVar.w1cRachelS.type=ch
set  myTrackVar.w1cRachelS.color.on=%myWingColor.CORAL
set  myTrackVar.w1cRachelS.color.off=%myWingColor.GRAY

set  myTrackVar.w1cJen=34
set  myTrackVar.w1cJen.type=ch
set  myTrackVar.w1cJen.color.on=%myWingColor.CORAL
set  myTrackVar.w1cJen.color.off=%myWingColor.GRAY

set  myTrackVar.w1cOS1=35
set  myTrackVar.w1cOS1.type=ch
set  myTrackVar.w1cOS1.color.on=%myWingColor.RED
set  myTrackVar.w1cOS1.color.off=%myWingColor.GRAY

set  myTrackVar.w1cOS2=36
set  myTrackVar.w1cOS2.type=ch
set  myTrackVar.w1cOS2.color.on=%myWingColor.RED
set  myTrackVar.w1cOS2.color.off=%myWingColor.GRAY

set  myTrackVar.w1cOS3=37
set  myTrackVar.w1cOS3.type=ch
set  myTrackVar.w1cOS3.color.on=%myWingColor.RED
set  myTrackVar.w1cOS3.color.off=%myWingColor.GRAY

set  myTrackVar.w1cOS4=38
set  myTrackVar.w1cOS4.type=ch
set  myTrackVar.w1cOS4.color.on=%myWingColor.RED
set  myTrackVar.w1cOS4.color.off=%myWingColor.GRAY


set   myTrackVar.w1dOTHER=1
set   myTrackVar.w1dOTHER.type=dca

set   myTrackVar.w1dENS1=2
set   myTrackVar.w1dENS1.type=dca

set   myTrackVar.w1dENS2=3
set   myTrackVar.w1dENS2.type=dca

set   myTrackVar.w1dENS3=4
set   myTrackVar.w1dENS3.type=dca

set   myTrackVar.w1dENS4=5
set   myTrackVar.w1dENS4.type=dca



:: for multiples separate the identifiers by a comma

set   myTAGVar.w1dcaOTHER="#D1"
set   myTAGVar.w1dcaENS1="#D2"
set   myTAGVar.w1dcaENS2="#D3"
set   myTAGVar.w1dcaENS3="#D4"
set   myTAGVar.w1dcaENS4="#D5"




:: ********************************************************* REAPER USER VARS *************************************************

:: Now Define the identifiers for each Channel

:: Each name is tied to one and only one REAPER track number.
:: The name is preceeded by myChan.  Each name designation must be unique
:: or the last definition will be used.
:: The channel references are the Track in the REAPER instance they are used on.
:: It is up to you to manage names and numbers.  The same numbers
:: can exist on different REAPER or X32 instances, but the names must be unique across
:: all of the devices you will be controlling.

:: Named Tracks are as follows

:: 1-30 are the first row of small faders

set myChan.r1Sadie=1
set myChan.r1Braxson=2
set myChan.r1Sola=3
set myChan.r1Maya=4
set myChan.r1Walter=5
set myChan.r1Rose=6
set myChan.r1Reilly=7
set myChan.r1Evelyn=8
set myChan.r1Zara=9
set myChan.r1Naomi=10
set myChan.r1Cara=11
set myChan.r1Corra=12
set myChan.r1Hazel=13
set myChan.r1Eva=14
set myChan.r1Quinne=15
set myChan.r1HyenaEns1=16
set myChan.r1HyenaEns2=17
set myChan.r1HyenaEns3=18
set myChan.r1HyenaEns4=19
set myChan.r1LionessEns1=20
set myChan.r1LionessEns2=21


set /a myChan.chan1=1
set /a myChan.chan2=2
set /a myChan.chan3=3
set /a myChan.chan4=4
set /a myChan.chan5=5
set /a myChan.chan6=6
set /a myChan.chan7=7
set /a myChan.chan8=8
set /a myChan.chan9=9
set /a myChan.chan10=10
set /a myChan.chan11=11
set /a myChan.chan12=12
set /a myChan.chan13=13
set /a myChan.chan14=14
set /a myChan.chan15=15
set /a myChan.chan16=16
set /a myChan.chan17=17
set /a myChan.chan18=18
set /a myChan.chan19=19
set /a myChan.chan20=20
set /a myChan.chan21=21
set /a myChan.chan22=22
set /a myChan.chan23=23
set /a myChan.chan24=24
set /a myChan.chan25=25
set /a myChan.chan26=26
set /a myChan.chan27=27
set /a myChan.chan28=28
set /a myChan.chan29=29
set /a myChan.chan30=30




:: 31-60 are the 2nd row of small faders
set /a myChan.chan31=31
set /a myChan.chan32=32
set /a myChan.chan33=33
set /a myChan.chan34=34
set /a myChan.chan35=35
set /a myChan.chan36=36
set /a myChan.chan37=37
set /a myChan.chan38=38
set /a myChan.chan39=39
set /a myChan.chan40=40
set /a myChan.chan41=41
set /a myChan.chan42=42
set /a myChan.chan43=43
set /a myChan.chan44=44
set /a myChan.chan45=45
set /a myChan.chan46=46
set /a myChan.chan47=47
set /a myChan.chan48=48
set /a myChan.chan49=49
set /a myChan.chan50=50
set /a myChan.chan51=51
set /a myChan.chan52=52
set /a myChan.chan53=53
set /a myChan.chan54=54
set /a myChan.chan55=55
set /a myChan.chan56=56
set /a myChan.chan57=57
set /a myChan.chan58=58
set /a myChan.chan59=59
set /a myChan.chan60=60

set /a myChan.css=31
set /a myChan.calan=32
set /a myChan.cmeringue=33
set /a myChan.cop=34
set /a myChan.cll=35
set /a myChan.cfrisbee=36
set /a myChan.chank=37
set /a myChan.cmark=38
set /a myChan.cdavid=39
set /a myChan.cxaiver=40
set /a myChan.cbrad=41
set /a myChan.cleon=42
set /a myChan.csnetgreg=43
set /a myChan.cmishkin=44
set /a myChan.cyenchna=45
set /a myChan.cdoctor=46
set /a myChan.csophia=47

set /a myChan.cwelcome=55
set /a myChan.cspare1=56
set /a myChan.cspare2=57
set /a myChan.cspare3=58
set /a myChan.cspare4=59
set /a myChan.cpc=60


:: 61-76 re the first row of large faders
set /a myChan.chan61=61
set /a myChan.chan62=62
set /a myChan.chan63=63
set /a myChan.chan64=64
set /a myChan.chan65=65
set /a myChan.chan66=66
set /a myChan.chan67=67
set /a myChan.chan68=68
set /a myChan.chan69=69
set /a myChan.chan70=70
set /a myChan.chan71=71
set /a myChan.chan72=72
set /a myChan.chan73=73
set /a myChan.chan74=74
set /a myChan.chan75=75
set /a myChan.chan76=76


set /a myChan.cmix1=61
set /a myChan.cmix2=62
set /a myChan.cmix3=63
set /a myChan.cmix4=64
set /a myChan.cmix5=65
set /a myChan.cmix6=66
set /a myChan.cmix7=67
set /a myChan.cmix8=68

set /a myChan.cistereo=71
set /a myChan.civerb=72
set /a myChan.cvstereo=73
set /a myChan.cvverb=74
set /a myChan.ceverb=75

set /a myChan.clisten=76

set /a myChan.chan61=61
set /a myChan.chan62=62
set /a myChan.chan63=63
set /a myChan.chan64=64
set /a myChan.chan65=65
set /a myChan.chan66=66
set /a myChan.chan67=67
set /a myChan.chan68=68
set /a myChan.chan69=69
set /a myChan.chan70=70
set /a myChan.chan71=71
set /a myChan.chan72=72
set /a myChan.chan73=73
set /a myChan.chan74=74
set /a myChan.chan75=75
set /a myChan.chan76=76

:: 77-92 are the 2nd row of large faders
set /a myChan.chan77=77
set /a myChan.chan78=78
set /a myChan.chan79=79
set /a myChan.chan80=80
set /a myChan.chan81=81
set /a myChan.chan82=82
set /a myChan.chan83=83
set /a myChan.chan84=84
set /a myChan.chan85=85
set /a myChan.chan86=86
set /a myChan.chan87=87
set /a myChan.chan88=88
set /a myChan.chan89=89
set /a myChan.chan90=90
set /a myChan.chan91=91
set /a myChan.chan92=92



set /a myChan.bus1=77
set /a myChan.bus2=78
set /a myChan.bus3=79
set /a myChan.bus4=80
set /a myChan.bus5=81
set /a myChan.bus6=82
set /a myChan.bus7=83
set /a myChan.bus8=84
set /a myChan.bus9=85
set /a myChan.bus10=86
set /a myChan.bus11=87
set /a myChan.bus12=88
set /a myChan.bus13=89
set /a myChan.bus14=90
set /a myChan.bus15=91
set /a myChan.bus16=92

set /a myChan.bperson1=77
set /a myChan.bperson2=78
set /a myChan.bperson3=79
set /a myChan.bperson4=80
set /a myChan.bperson5=81
set /a myChan.bperson6=82
set /a myChan.bpark=91
set /a myChan.bpc=92

:: 93-140 are the 48 inputs
set /a myChan.chan93=93
set /a myChan.chan94=94
set /a myChan.chan95=95
set /a myChan.chan96=96
set /a myChan.chan97=97
set /a myChan.chan98=98
set /a myChan.chan99=99
set /a myChan.chan100=100
set /a myChan.chan101=101
set /a myChan.chan102=102
set /a myChan.chan103=103
set /a myChan.chan104=104
set /a myChan.chan105=105
set /a myChan.chan106=106
set /a myChan.chan107=107
set /a myChan.chan108=108
set /a myChan.chan109=109
set /a myChan.chan110=110
set /a myChan.chan111=111
set /a myChan.chan112=112
set /a myChan.chan113=113
set /a myChan.chan114=114
set /a myChan.chan115=115
set /a myChan.chan116=116
set /a myChan.chan117=117
set /a myChan.chan118=118
set /a myChan.chan119=119
set /a myChan.chan120=120
set /a myChan.chan121=121
set /a myChan.chan122=122
set /a myChan.chan123=123
set /a myChan.chan124=124
set /a myChan.chan125=125
set /a myChan.chan126=126
set /a myChan.chan127=127
set /a myChan.chan128=128
set /a myChan.chan129=129
set /a myChan.chan130=130
set /a myChan.chan131=131
set /a myChan.chan132=132
set /a myChan.chan133=133
set /a myChan.chan134=134
set /a myChan.chan135=135
set /a myChan.chan136=136
set /a myChan.chan137=137
set /a myChan.chan138=138
set /a myChan.chan139=139
set /a myChan.chan140=140

set /a myChan.in01=93
set /a myChan.in02=94
set /a myChan.in03=95
set /a myChan.in04=96
set /a myChan.in05=97
set /a myChan.in06=98
set /a myChan.in07=99
set /a myChan.in08=100
set /a myChan.in09=101
set /a myChan.in10=102
set /a myChan.in11=103
set /a myChan.in12=104
set /a myChan.in13=105
set /a myChan.in14=106
set /a myChan.in15=107
set /a myChan.in16=108
set /a myChan.in17=109
set /a myChan.in18=110
set /a myChan.in19=111
set /a myChan.in20=112
set /a myChan.in21=113
set /a myChan.in22=114
set /a myChan.in23=115
set /a myChan.in24=116
set /a myChan.in25=117
set /a myChan.in26=118
set /a myChan.in27=119
set /a myChan.in28=120
set /a myChan.in29=121
set /a myChan.in30=122
set /a myChan.in31=123
set /a myChan.in32=124
set /a myChan.in33=125
set /a myChan.in34=126
set /a myChan.in35=127
set /a myChan.in36=128
set /a myChan.in37=129
set /a myChan.in38=130
set /a myChan.in39=131
set /a myChan.in40=132
set /a myChan.in41=133
set /a myChan.in42=134
set /a myChan.in43=135
set /a myChan.in44=136
set /a myChan.in45=137
set /a myChan.in46=138
set /a myChan.in47=139
set /a myChan.in48=140

:: 141-149 are unused
set /a myChan.chan141=141
set /a myChan.chan142=142
set /a myChan.chan143=143
set /a myChan.chan144=144
set /a myChan.chan145=145
set /a myChan.chan146=146
set /a myChan.chan147=147
set /a myChan.chan148=148
set /a myChan.chan149=149

:: 150-170 are mute groups
set /a myChan.chan150=150
set /a myChan.chan151=151
set /a myChan.chan152=152
set /a myChan.chan153=153
set /a myChan.chan154=154
set /a myChan.chan155=155
set /a myChan.chan156=156
set /a myChan.chan157=157
set /a myChan.chan158=158
set /a myChan.chan159=159
set /a myChan.chan160=160
set /a myChan.chan161=161
set /a myChan.chan162=162
set /a myChan.chan163=163
set /a myChan.chan164=164
set /a myChan.chan165=165
set /a myChan.chan166=166
set /a myChan.chan167=167
set /a myChan.chan168=168
set /a myChan.chan169=169
set /a myChan.chan170=170

set /a myChan.mutegroup1=150
set /a myChan.mutegroup2=151
set /a myChan.mutegroup3=152
set /a myChan.mutegroup4=153
set /a myChan.mutegroup5=154
set /a myChan.mutegroup6=155
set /a myChan.mutegroup7=156
set /a myChan.mutegroup8=157
set /a myChan.mutegroup9=158
set /a myChan.mutegroup10=159
set /a myChan.mutegroup11=160
set /a myChan.mutegroup12=161
set /a myChan.mutegroup13=162
set /a myChan.mutegroup14=163
set /a myChan.mutegroup15=164
set /a myChan.mutegroup16=165
set /a myChan.mutegroup17=166
set /a myChan.mutegroup18=167
set /a myChan.mutegroup19=168
set /a myChan.mutegroup20=169
set /a myChan.mutegroup21=170




:: 171-180 are channel VCAs
set /a myChan.chan171=171
set /a myChan.chan172=172
set /a myChan.chan173=173
set /a myChan.chan174=174
set /a myChan.chan175=175
set /a myChan.chan176=176
set /a myChan.chan177=177
set /a myChan.chan178=178
set /a myChan.chan179=179
set /a myChan.chan180=180
:: Channel VCAs are here...NOTE that these are STATIC and must be set up
:: in Reaper Group Matrix Information.
set /a myChan.cvca1=171
set /a myChan.cvca2=172
set /a myChan.cvca3=173
set /a myChan.cvca4=174
set /a myChan.cvca5=175
set /a myChan.cvca6=176
set /a myChan.cvca7=177
set /a myChan.cvca8=178
set /a myChan.cvca9=179
set /a myChan.cvca10=180

:: 181-196 are unused
set /a myChan.chan181=181
set /a myChan.chan182=182
set /a myChan.chan183=183
set /a myChan.chan184=184
set /a myChan.chan185=185
set /a myChan.chan186=186
set /a myChan.chan187=187
set /a myChan.chan188=188
set /a myChan.chan189=189
set /a myChan.chan190=190
set /a myChan.chan191=191
set /a myChan.chan192=192
set /a myChan.chan193=193
set /a myChan.chan194=194
set /a myChan.chan195=195
set /a myChan.chan196=196

:: 197-199 are information areas
set /a myChan.chan197=197
set /a myChan.chan198=198
set /a myChan.chan199=199

set /a myChan.cstatusofcue=199

:: 200 is unused
set /a myChan.chan200=200

:: 201-230 are listeners for the first row of small channels 1-30
set /a myChan.chan201=201
set /a myChan.chan202=202
set /a myChan.chan203=203
set /a myChan.chan204=204
set /a myChan.chan205=205
set /a myChan.chan206=206
set /a myChan.chan207=207
set /a myChan.chan208=208
set /a myChan.chan209=209
set /a myChan.chan210=210
set /a myChan.chan211=211
set /a myChan.chan212=212
set /a myChan.chan213=213
set /a myChan.chan214=214
set /a myChan.chan215=215
set /a myChan.chan216=216
set /a myChan.chan217=217
set /a myChan.chan218=218
set /a myChan.chan219=219
set /a myChan.chan220=220
set /a myChan.chan221=221
set /a myChan.chan222=222
set /a myChan.chan223=223
set /a myChan.chan224=224
set /a myChan.chan225=225
set /a myChan.chan226=226
set /a myChan.chan227=227
set /a myChan.chan228=228
set /a myChan.chan229=229
set /a myChan.chan230=230

:: 231-260 are listeners for the first row of small channels 31-60
set /a myChan.chan231=231
set /a myChan.chan232=232
set /a myChan.chan233=233
set /a myChan.chan234=234
set /a myChan.chan235=235
set /a myChan.chan236=236
set /a myChan.chan237=237
set /a myChan.chan238=238
set /a myChan.chan239=239
set /a myChan.chan240=240
set /a myChan.chan241=241
set /a myChan.chan242=242
set /a myChan.chan243=243
set /a myChan.chan244=244
set /a myChan.chan245=245
set /a myChan.chan246=246
set /a myChan.chan247=247
set /a myChan.chan248=248
set /a myChan.chan249=249
set /a myChan.chan250=250
set /a myChan.chan251=251
set /a myChan.chan252=252
set /a myChan.chan253=253
set /a myChan.chan254=254
set /a myChan.chan255=255
set /a myChan.chan256=256
set /a myChan.chan257=257
set /a myChan.chan258=258
set /a myChan.chan259=259
set /a myChan.chan260=260

:: 261-276 are listeners for the first row of large channels 61-76
set /a myChan.chan261=261
set /a myChan.chan262=262
set /a myChan.chan263=263
set /a myChan.chan264=264
set /a myChan.chan265=265
set /a myChan.chan266=266
set /a myChan.chan267=267
set /a myChan.chan268=268
set /a myChan.chan269=269
set /a myChan.chan270=270
set /a myChan.chan271=271
set /a myChan.chan272=272
set /a myChan.chan273=273
set /a myChan.chan274=274
set /a myChan.chan275=275
set /a myChan.chan276=276

:: 277-292 are listeners for the first row of large channels 77-92
set /a myChan.chan277=277
set /a myChan.chan278=278
set /a myChan.chan279=279
set /a myChan.chan280=280
set /a myChan.chan281=281
set /a myChan.chan282=282
set /a myChan.chan283=283
set /a myChan.chan284=284
set /a myChan.chan285=285
set /a myChan.chan286=286
set /a myChan.chan287=287
set /a myChan.chan288=288
set /a myChan.chan289=289
set /a myChan.chan290=290
set /a myChan.chan291=291
set /a myChan.chan292=292

:: 293-340 are listeners for inputs
set /a myChan.chan293=293
set /a myChan.chan294=294
set /a myChan.chan295=295
set /a myChan.chan296=296
set /a myChan.chan297=297
set /a myChan.chan298=298
set /a myChan.chan299=299
set /a myChan.chan300=300
set /a myChan.chan301=301
set /a myChan.chan302=302
set /a myChan.chan303=303
set /a myChan.chan304=304
set /a myChan.chan305=305
set /a myChan.chan306=306
set /a myChan.chan307=307
set /a myChan.chan308=308
set /a myChan.chan309=309
set /a myChan.chan310=310
set /a myChan.chan311=311
set /a myChan.chan312=312
set /a myChan.chan313=313
set /a myChan.chan314=314
set /a myChan.chan315=315
set /a myChan.chan316=316
set /a myChan.chan317=317
set /a myChan.chan318=318
set /a myChan.chan319=319
set /a myChan.chan320=320
set /a myChan.chan321=321
set /a myChan.chan322=322
set /a myChan.chan323=323
set /a myChan.chan324=324
set /a myChan.chan325=325
set /a myChan.chan326=326
set /a myChan.chan327=327
set /a myChan.chan328=328
set /a myChan.chan329=329
set /a myChan.chan330=330
set /a myChan.chan331=331
set /a myChan.chan332=332
set /a myChan.chan333=333
set /a myChan.chan334=334
set /a myChan.chan335=335
set /a myChan.chan336=336
set /a myChan.chan337=337
set /a myChan.chan338=338
set /a myChan.chan339=339
set /a myChan.chan340=340

:: 341-350 are unused
set /a myChan.chan341=341
set /a myChan.chan342=342
set /a myChan.chan343=343
set /a myChan.chan344=344
set /a myChan.chan345=345
set /a myChan.chan346=346
set /a myChan.chan347=347
set /a myChan.chan348=348
set /a myChan.chan349=349
set /a myChan.chan350=350

:: 351- 380 are a 3rd set of small faders
set /a myChan.chan351=351
set /a myChan.chan352=352
set /a myChan.chan353=353
set /a myChan.chan354=354
set /a myChan.chan355=355
set /a myChan.chan356=356
set /a myChan.chan357=357
set /a myChan.chan358=358
set /a myChan.chan359=359
set /a myChan.chan360=360
set /a myChan.chan361=361
set /a myChan.chan362=362
set /a myChan.chan363=363
set /a myChan.chan364=364
set /a myChan.chan365=365
set /a myChan.chan366=366
set /a myChan.chan367=367
set /a myChan.chan368=368
set /a myChan.chan369=369
set /a myChan.chan370=370
set /a myChan.chan371=371
set /a myChan.chan372=372
set /a myChan.chan373=373
set /a myChan.chan374=374
set /a myChan.chan375=375
set /a myChan.chan376=376
set /a myChan.chan377=377
set /a myChan.chan378=378
set /a myChan.chan379=379
set /a myChan.chan380=380

:: 381- 410 are a 4th set of small faders
set /a myChan.chan381=381
set /a myChan.chan382=382
set /a myChan.chan383=383
set /a myChan.chan384=384
set /a myChan.chan385=385
set /a myChan.chan386=386
set /a myChan.chan387=387
set /a myChan.chan388=388
set /a myChan.chan389=389
set /a myChan.chan390=390
set /a myChan.chan391=391
set /a myChan.chan392=392
set /a myChan.chan393=393
set /a myChan.chan394=394
set /a myChan.chan395=395
set /a myChan.chan396=396
set /a myChan.chan397=397
set /a myChan.chan398=398
set /a myChan.chan399=399
set /a myChan.chan400=400
set /a myChan.chan401=401
set /a myChan.chan402=402
set /a myChan.chan403=403
set /a myChan.chan404=404
set /a myChan.chan405=405
set /a myChan.chan406=406
set /a myChan.chan407=407
set /a myChan.chan408=408
set /a myChan.chan409=409
set /a myChan.chan410=410

:: 411- 426 are a 3rd set of large faders
set /a myChan.chan411=411
set /a myChan.chan412=412
set /a myChan.chan413=413
set /a myChan.chan414=414
set /a myChan.chan415=415
set /a myChan.chan416=416
set /a myChan.chan417=417
set /a myChan.chan418=418
set /a myChan.chan419=419
set /a myChan.chan420=420
set /a myChan.chan421=421
set /a myChan.chan422=422
set /a myChan.chan423=423
set /a myChan.chan424=424
set /a myChan.chan425=425
set /a myChan.chan426=426

:: 427- 442 are a 4th set of large faders
set /a myChan.chan427=427
set /a myChan.chan428=428
set /a myChan.chan429=429
set /a myChan.chan430=430
set /a myChan.chan431=431
set /a myChan.chan432=432
set /a myChan.chan433=433
set /a myChan.chan434=434
set /a myChan.chan435=435
set /a myChan.chan436=436
set /a myChan.chan437=437
set /a myChan.chan438=438
set /a myChan.chan439=439
set /a myChan.chan440=440
set /a myChan.chan441=441
set /a myChan.chan442=442

:: 443-450 are unused
set /a myChan.chan443=443
set /a myChan.chan444=444
set /a myChan.chan445=445
set /a myChan.chan446=446
set /a myChan.chan447=447
set /a myChan.chan448=448
set /a myChan.chan449=449
set /a myChan.chan450=450

:: 451-542 are listeners for inputs

set /a myChan.chan451=451
set /a myChan.chan452=452
set /a myChan.chan453=453
set /a myChan.chan454=454
set /a myChan.chan455=455
set /a myChan.chan456=456
set /a myChan.chan457=457
set /a myChan.chan458=458
set /a myChan.chan459=459
set /a myChan.chan460=460
set /a myChan.chan461=461
set /a myChan.chan462=462
set /a myChan.chan463=463
set /a myChan.chan464=464
set /a myChan.chan465=465
set /a myChan.chan466=466
set /a myChan.chan467=467
set /a myChan.chan468=468
set /a myChan.chan469=469
set /a myChan.chan470=470
set /a myChan.chan471=471
set /a myChan.chan472=472
set /a myChan.chan473=473
set /a myChan.chan474=474
set /a myChan.chan475=475
set /a myChan.chan476=476
set /a myChan.chan477=477
set /a myChan.chan478=478
set /a myChan.chan479=479
set /a myChan.chan480=480
set /a myChan.chan481=481
set /a myChan.chan482=482
set /a myChan.chan483=483
set /a myChan.chan484=484
set /a myChan.chan485=485
set /a myChan.chan486=486
set /a myChan.chan487=487
set /a myChan.chan488=488
set /a myChan.chan489=489
set /a myChan.chan490=490
set /a myChan.chan491=491
set /a myChan.chan492=492
set /a myChan.chan493=493
set /a myChan.chan494=494
set /a myChan.chan495=495
set /a myChan.chan496=496
set /a myChan.chan497=497
set /a myChan.chan498=498
set /a myChan.chan499=499
set /a myChan.chan500=500
set /a myChan.chan501=501
set /a myChan.chan502=502
set /a myChan.chan503=503
set /a myChan.chan504=504
set /a myChan.chan505=505
set /a myChan.chan506=506
set /a myChan.chan507=507
set /a myChan.chan508=508
set /a myChan.chan509=509
set /a myChan.chan510=510
set /a myChan.chan511=511
set /a myChan.chan512=512
set /a myChan.chan513=513
set /a myChan.chan514=514
set /a myChan.chan515=515
set /a myChan.chan516=516
set /a myChan.chan517=517
set /a myChan.chan518=518
set /a myChan.chan519=519
set /a myChan.chan520=520
set /a myChan.chan521=521
set /a myChan.chan522=522
set /a myChan.chan523=523
set /a myChan.chan524=524
set /a myChan.chan525=525
set /a myChan.chan526=526
set /a myChan.chan527=527
set /a myChan.chan528=528
set /a myChan.chan529=529
set /a myChan.chan530=530
set /a myChan.chan531=531
set /a myChan.chan532=532
set /a myChan.chan533=533
set /a myChan.chan534=534
set /a myChan.chan535=535
set /a myChan.chan536=536
set /a myChan.chan537=537
set /a myChan.chan538=538
set /a myChan.chan539=539
set /a myChan.chan540=540
set /a myChan.chan541=541
set /a myChan.chan542=542

:: 543-549 are unused
set /a myChan.chan543=543
set /a myChan.chan544=544
set /a myChan.chan545=545
set /a myChan.chan546=546
set /a myChan.chan547=547
set /a myChan.chan548=548
set /a myChan.chan549=549

:: 550-559 are CV
set /a myChan.chan550=550
set /a myChan.chan551=551
set /a myChan.chan552=552
set /a myChan.chan553=553
set /a myChan.chan554=554
set /a myChan.chan555=555
set /a myChan.chan556=556
set /a myChan.chan557=557
set /a myChan.chan558=558
set /a myChan.chan559=559


:: Now Define the identifiers for each set of Send Values

:: For REAPER for Sends
:: 1 sets the send to the specified volume level
:: 0 sets the send to 0 volume
:: x does not change the send
:: - does not count in the increment of the send number and is ignored
:: * terminates the processing of the string
:: Note that REAPER does not have OSC commands to Mute Sends so
:: if you are managing via Sends in REAPER you will have to deal with this
:: limitation.
:: You may instead send each channel to all needed "sends" by adding tracks for each send
:: which you can then manage with mutes instead.
:: To do this, mute channels by using a send string of "*" since it does not adjust sends but
:: just unmutes the channel with whatever sends are already in place.


:: For this event, sends are set up to
:: match the busses, as normal.
::
:: Instruments never change so are hard coded in REAPER and not adjusted here
::
::  Every vocal track has this sequence of Sends in REAPER:
::  1   BUS 1  for blines1
::  2   BUS 2  for blines2
::  3   BUS 3  for blines3
::  4   BUS 4  for blines4
::  5   BUS 5  for blines5
::  6   BUS 6  for blines6
::  7   BUS 7  for bgroup1
::  8   BUS 8  for bgroup2
::  9   BUS 9  for bstagemic
:: 10   BUS 10 for bpark

:: 11   AFL associated with the mic



:: Patterns for setting up
::                            123456-gg-s-p-A
:: set     mySend.ssetuplines=000000-00-s-1-1*

:: For when you just want to be fast and not change anything
set      mySend.sunchanged=*

:: clear all routes
set      mySend.sunroute=0000000000*

:: Now Strings for Plugin Processing, unused here
set         myPlugin.pdisable=xa*

::  GENERAL USE
::  G=Gomez
::  M=Morticia
::  L=Lines in general
::  later GG are Group2 1 and 2
::  Then offstage mics but these are fixed so just mute/unmute them
::                     GM 
::		       LLLLLL GG 					          
::                     123456-gg-p-A*
set     mySend.slines1=100000-00-0*
set     mySend.slines2=010000-00-0*
set     mySend.slines3=001000-00-0*
set     mySend.slines4=000100-00-0*
set     mySend.slines5=000010-00-0*
set     mySend.slines6=000001-00-0*
set     mySend.sgroup1=000000-10-0*
set     mySend.sgroup2=000000-01-0*
set       mySend.spark=000000-00-1*


:: ********************************************************* X32 USER VARS *************************************************


:: Now Define the identifiers for each Channel

:: Each name is tied to one and only one channel number
:: The name is preceeded by myChan.  Each name designation must be unique
:: or the last definition will be used.
:: The channel references are the channel on the device they are used on.
:: It is up to you to manage names and channel numbers.  The same numbers
:: can exist on different devices, but the names must be unique across
:: all of the devices you will be controlling.
:: This must be a 2 digit value

set  myChan.cVIOLIN1=28
set  myChan.cVIOLIN2=29
set  myChan.cVIOLA=27
set  myChan.cCELLO=31
set  myChan.cKEYS=01
set  myChan.cAG=04



:: Now Define the identifiers for each Bus.  There are only 16 available.
:: Rules are like for channels.


:: set   myBus.testbus1=01



:: Now Define the identifiers for each set of Send Values

:: For X32 for Sends
:: 1 sets the send to not muted
:: 0 sets the send to muted
:: x does not change the send
:: - does not count in the increment of the send number and is ignored
:: * terminates the processing of the string


:: set mySend.solo=1000*



:: Now Define the identifiers for each DCA.  The values range from 0-255,
:: 0 being no DCAs to 255 meaning All DCAs on.
:: DCA 1 is 1
:: DCA 2 is 2
:: DCA 3 is 4
:: DCA 4 is 8
:: DCA 5 is 16
:: DCA 6 is 32
:: DCA 7 is 64
:: DCA 8 is 128
:: DCA 1 and 3 is 1+4=5
:: etc.

::set   myDCAassign.testassigndca1=1



:: Now Define the identifiers for each DCA for single DCA use.  The values range from 1-8.

::set   myDCA.testdca1=1

:: Now Define the identifiers for each Out Route. 
:: This will be used to  define an output route.
:: For example, if you want a Cello to go to REAPER as REAPER Input 1
:: then you would want to set User Out 1 to "Cello" where "Cello" is defined as 1.
:: This naming is so that you can change the Cello later and regenerate cues without editing the cue files directly.
::  for this example so you can use "Cello" in cues in the Build  stage set myRouteOut.Cello=01

:: set myRouteOut.testoutroute1=01


:: Now Define the identifiers for each In Route. 
:: This will be used to  define an input route.


:: set myRouteIn.testinroute1=01




:: THE BELOW ARE PREDEFINED FOR YOU and re to be used with ROUTE related entries

:: 0-168 can be used for In Routing, 0-208 can be used for Out Routing
::  Two sets of variables are provided to allow different designations for each if desired.

set myRouteSourceIn.OFF=0
set myRouteSourceIn.LOCAL1=1
set myRouteSourceIn.LOCAL2=2
set myRouteSourceIn.LOCAL3=3
set myRouteSourceIn.LOCAL4=4
set myRouteSourceIn.LOCAL5=5
set myRouteSourceIn.LOCAL6=6
set myRouteSourceIn.LOCAL7=7
set myRouteSourceIn.LOCAL8=8
set myRouteSourceIn.LOCAL9=9
set myRouteSourceIn.LOCAL10=10
set myRouteSourceIn.LOCAL11=11
set myRouteSourceIn.LOCAL12=12
set myRouteSourceIn.LOCAL13=13
set myRouteSourceIn.LOCAL14=14
set myRouteSourceIn.LOCAL15=15
set myRouteSourceIn.LOCAL16=16
set myRouteSourceIn.LOCAL17=17
set myRouteSourceIn.LOCAL18=18
set myRouteSourceIn.LOCAL19=19
set myRouteSourceIn.LOCAL20=20
set myRouteSourceIn.LOCAL21=21
set myRouteSourceIn.LOCAL22=22
set myRouteSourceIn.LOCAL23=23
set myRouteSourceIn.LOCAL24=24
set myRouteSourceIn.LOCAL25=25
set myRouteSourceIn.LOCAL26=26
set myRouteSourceIn.LOCAL27=27
set myRouteSourceIn.LOCAL28=28
set myRouteSourceIn.LOCAL29=29
set myRouteSourceIn.LOCAL30=30
set myRouteSourceIn.LOCAL31=31
set myRouteSourceIn.LOCAL32=32
set myRouteSourceIn.AES50A1=33
set myRouteSourceIn.AES50A2=34
set myRouteSourceIn.AES50A3=35
set myRouteSourceIn.AES50A4=36
set myRouteSourceIn.AES50A5=37
set myRouteSourceIn.AES50A6=38
set myRouteSourceIn.AES50A7=39
set myRouteSourceIn.AES50A8=40
set myRouteSourceIn.AES50A9=41
set myRouteSourceIn.AES50A10=42
set myRouteSourceIn.AES50A11=43
set myRouteSourceIn.AES50A12=44
set myRouteSourceIn.AES50A13=45
set myRouteSourceIn.AES50A14=46
set myRouteSourceIn.AES50A15=47
set myRouteSourceIn.AES50A16=48
set myRouteSourceIn.AES50A17=49
set myRouteSourceIn.AES50A18=50
set myRouteSourceIn.AES50A19=51
set myRouteSourceIn.AES50A20=52
set myRouteSourceIn.AES50A21=53
set myRouteSourceIn.AES50A22=54
set myRouteSourceIn.AES50A23=55
set myRouteSourceIn.AES50A24=56
set myRouteSourceIn.AES50A25=57
set myRouteSourceIn.AES50A26=58
set myRouteSourceIn.AES50A27=59
set myRouteSourceIn.AES50A28=60
set myRouteSourceIn.AES50A29=61
set myRouteSourceIn.AES50A30=62
set myRouteSourceIn.AES50A31=63
set myRouteSourceIn.AES50A32=64
set myRouteSourceIn.AES50A33=65
set myRouteSourceIn.AES50A34=66
set myRouteSourceIn.AES50A35=67
set myRouteSourceIn.AES50A36=68
set myRouteSourceIn.AES50A37=69
set myRouteSourceIn.AES50A38=70
set myRouteSourceIn.AES50A39=71
set myRouteSourceIn.AES50A40=72
set myRouteSourceIn.AES50A41=73
set myRouteSourceIn.AES50A42=74
set myRouteSourceIn.AES50A43=75
set myRouteSourceIn.AES50A44=76
set myRouteSourceIn.AES50A45=77
set myRouteSourceIn.AES50A46=78
set myRouteSourceIn.AES50A47=79
set myRouteSourceIn.AES50A48=80
set myRouteSourceIn.AES50B1=81
set myRouteSourceIn.AES50B2=82
set myRouteSourceIn.AES50B3=83
set myRouteSourceIn.AES50B4=84
set myRouteSourceIn.AES50B5=85
set myRouteSourceIn.AES50B6=86
set myRouteSourceIn.AES50B7=87
set myRouteSourceIn.AES50B8=88
set myRouteSourceIn.AES50B9=89
set myRouteSourceIn.AES50B10=90
set myRouteSourceIn.AES50B11=91
set myRouteSourceIn.AES50B12=92
set myRouteSourceIn.AES50B13=93
set myRouteSourceIn.AES50B14=94
set myRouteSourceIn.AES50B15=95
set myRouteSourceIn.AES50B16=96
set myRouteSourceIn.AES50B17=97
set myRouteSourceIn.AES50B18=98
set myRouteSourceIn.AES50B19=99
set myRouteSourceIn.AES50B20=100
set myRouteSourceIn.AES50B21=101
set myRouteSourceIn.AES50B22=102
set myRouteSourceIn.AES50B23=103
set myRouteSourceIn.AES50B24=104
set myRouteSourceIn.AES50B25=105
set myRouteSourceIn.AES50B26=106
set myRouteSourceIn.AES50B27=107
set myRouteSourceIn.AES50B28=108
set myRouteSourceIn.AES50B29=109
set myRouteSourceIn.AES50B30=110
set myRouteSourceIn.AES50B31=111
set myRouteSourceIn.AES50B32=112
set myRouteSourceIn.AES50B33=113
set myRouteSourceIn.AES50B34=114
set myRouteSourceIn.AES50B35=115
set myRouteSourceIn.AES50B36=116
set myRouteSourceIn.AES50B37=117
set myRouteSourceIn.AES50B38=118
set myRouteSourceIn.AES50B39=119
set myRouteSourceIn.AES50B40=120
set myRouteSourceIn.AES50B41=121
set myRouteSourceIn.AES50B42=122
set myRouteSourceIn.AES50B43=123
set myRouteSourceIn.AES50B44=124
set myRouteSourceIn.AES50B45=125
set myRouteSourceIn.AES50B46=126
set myRouteSourceIn.AES50B47=127
set myRouteSourceIn.AES50B48=128
set myRouteSourceIn.CARD1=129
set myRouteSourceIn.CARD2=130
set myRouteSourceIn.CARD3=131
set myRouteSourceIn.CARD4=132
set myRouteSourceIn.CARD5=133
set myRouteSourceIn.CARD6=134
set myRouteSourceIn.CARD7=135
set myRouteSourceIn.CARD8=136
set myRouteSourceIn.CARD9=137
set myRouteSourceIn.CARD10=138
set myRouteSourceIn.CARD11=139
set myRouteSourceIn.CARD12=140
set myRouteSourceIn.CARD13=141
set myRouteSourceIn.CARD14=142
set myRouteSourceIn.CARD15=143
set myRouteSourceIn.CARD16=144
set myRouteSourceIn.CARD17=145
set myRouteSourceIn.CARD18=146
set myRouteSourceIn.CARD19=147
set myRouteSourceIn.CARD20=148
set myRouteSourceIn.CARD21=149
set myRouteSourceIn.CARD22=150
set myRouteSourceIn.CARD23=151
set myRouteSourceIn.CARD24=152
set myRouteSourceIn.CARD25=153
set myRouteSourceIn.CARD26=154
set myRouteSourceIn.CARD27=155
set myRouteSourceIn.CARD28=156
set myRouteSourceIn.CARD29=157
set myRouteSourceIn.CARD30=158
set myRouteSourceIn.CARD31=159
set myRouteSourceIn.CARD32=160
set myRouteSourceIn.AUXIN1=161
set myRouteSourceIn.AUXIN2=162
set myRouteSourceIn.AUXIN3=163
set myRouteSourceIn.AUXIN4=164
set myRouteSourceIn.AUXIN5=165
set myRouteSourceIn.AUXIN6=166
set myRouteSourceIn.TBINT=167
set myRouteSourceIn.TBEXT=168



set myRouteSourceOut.OFF=0
set myRouteSourceOut.LOCAL1=1
set myRouteSourceOut.LOCAL2=2
set myRouteSourceOut.LOCAL3=3
set myRouteSourceOut.LOCAL4=4
set myRouteSourceOut.LOCAL5=5
set myRouteSourceOut.LOCAL6=6
set myRouteSourceOut.LOCAL7=7
set myRouteSourceOut.LOCAL8=8
set myRouteSourceOut.LOCAL9=9
set myRouteSourceOut.LOCAL10=10
set myRouteSourceOut.LOCAL11=11
set myRouteSourceOut.LOCAL12=12
set myRouteSourceOut.LOCAL13=13
set myRouteSourceOut.LOCAL14=14
set myRouteSourceOut.LOCAL15=15
set myRouteSourceOut.LOCAL16=16
set myRouteSourceOut.LOCAL17=17
set myRouteSourceOut.LOCAL18=18
set myRouteSourceOut.LOCAL19=19
set myRouteSourceOut.LOCAL20=20
set myRouteSourceOut.LOCAL21=21
set myRouteSourceOut.LOCAL22=22
set myRouteSourceOut.LOCAL23=23
set myRouteSourceOut.LOCAL24=24
set myRouteSourceOut.LOCAL25=25
set myRouteSourceOut.LOCAL26=26
set myRouteSourceOut.LOCAL27=27
set myRouteSourceOut.LOCAL28=28
set myRouteSourceOut.LOCAL29=29
set myRouteSourceOut.LOCAL30=30
set myRouteSourceOut.LOCAL31=31
set myRouteSourceOut.LOCAL32=32
set myRouteSourceOut.AES50A1=33
set myRouteSourceOut.AES50A2=34
set myRouteSourceOut.AES50A3=35
set myRouteSourceOut.AES50A4=36
set myRouteSourceOut.AES50A5=37
set myRouteSourceOut.AES50A6=38
set myRouteSourceOut.AES50A7=39
set myRouteSourceOut.AES50A8=40
set myRouteSourceOut.AES50A9=41
set myRouteSourceOut.AES50A10=42
set myRouteSourceOut.AES50A11=43
set myRouteSourceOut.AES50A12=44
set myRouteSourceOut.AES50A13=45
set myRouteSourceOut.AES50A14=46
set myRouteSourceOut.AES50A15=47
set myRouteSourceOut.AES50A16=48
set myRouteSourceOut.AES50A17=49
set myRouteSourceOut.AES50A18=50
set myRouteSourceOut.AES50A19=51
set myRouteSourceOut.AES50A20=52
set myRouteSourceOut.AES50A21=53
set myRouteSourceOut.AES50A22=54
set myRouteSourceOut.AES50A23=55
set myRouteSourceOut.AES50A24=56
set myRouteSourceOut.AES50A25=57
set myRouteSourceOut.AES50A26=58
set myRouteSourceOut.AES50A27=59
set myRouteSourceOut.AES50A28=60
set myRouteSourceOut.AES50A29=61
set myRouteSourceOut.AES50A30=62
set myRouteSourceOut.AES50A31=63
set myRouteSourceOut.AES50A32=64
set myRouteSourceOut.AES50A33=65
set myRouteSourceOut.AES50A34=66
set myRouteSourceOut.AES50A35=67
set myRouteSourceOut.AES50A36=68
set myRouteSourceOut.AES50A37=69
set myRouteSourceOut.AES50A38=70
set myRouteSourceOut.AES50A39=71
set myRouteSourceOut.AES50A40=72
set myRouteSourceOut.AES50A41=73
set myRouteSourceOut.AES50A42=74
set myRouteSourceOut.AES50A43=75
set myRouteSourceOut.AES50A44=76
set myRouteSourceOut.AES50A45=77
set myRouteSourceOut.AES50A46=78
set myRouteSourceOut.AES50A47=79
set myRouteSourceOut.AES50A48=80
set myRouteSourceOut.AES50B1=81
set myRouteSourceOut.AES50B2=82
set myRouteSourceOut.AES50B3=83
set myRouteSourceOut.AES50B4=84
set myRouteSourceOut.AES50B5=85
set myRouteSourceOut.AES50B6=86
set myRouteSourceOut.AES50B7=87
set myRouteSourceOut.AES50B8=88
set myRouteSourceOut.AES50B9=89
set myRouteSourceOut.AES50B10=90
set myRouteSourceOut.AES50B11=91
set myRouteSourceOut.AES50B12=92
set myRouteSourceOut.AES50B13=93
set myRouteSourceOut.AES50B14=94
set myRouteSourceOut.AES50B15=95
set myRouteSourceOut.AES50B16=96
set myRouteSourceOut.AES50B17=97
set myRouteSourceOut.AES50B18=98
set myRouteSourceOut.AES50B19=99
set myRouteSourceOut.AES50B20=100
set myRouteSourceOut.AES50B21=101
set myRouteSourceOut.AES50B22=102
set myRouteSourceOut.AES50B23=103
set myRouteSourceOut.AES50B24=104
set myRouteSourceOut.AES50B25=105
set myRouteSourceOut.AES50B26=106
set myRouteSourceOut.AES50B27=107
set myRouteSourceOut.AES50B28=108
set myRouteSourceOut.AES50B29=109
set myRouteSourceOut.AES50B30=110
set myRouteSourceOut.AES50B31=111
set myRouteSourceOut.AES50B32=112
set myRouteSourceOut.AES50B33=113
set myRouteSourceOut.AES50B34=114
set myRouteSourceOut.AES50B35=115
set myRouteSourceOut.AES50B36=116
set myRouteSourceOut.AES50B37=117
set myRouteSourceOut.AES50B38=118
set myRouteSourceOut.AES50B39=119
set myRouteSourceOut.AES50B40=120
set myRouteSourceOut.AES50B41=121
set myRouteSourceOut.AES50B42=122
set myRouteSourceOut.AES50B43=123
set myRouteSourceOut.AES50B44=124
set myRouteSourceOut.AES50B45=125
set myRouteSourceOut.AES50B46=126
set myRouteSourceOut.AES50B47=127
set myRouteSourceOut.AES50B48=128
set myRouteSourceOut.CARD1=129
set myRouteSourceOut.CARD2=130
set myRouteSourceOut.CARD3=131
set myRouteSourceOut.CARD4=132
set myRouteSourceOut.CARD5=133
set myRouteSourceOut.CARD6=134
set myRouteSourceOut.CARD7=135
set myRouteSourceOut.CARD8=136
set myRouteSourceOut.CARD9=137
set myRouteSourceOut.CARD10=138
set myRouteSourceOut.CARD11=139
set myRouteSourceOut.CARD12=140
set myRouteSourceOut.CARD13=141
set myRouteSourceOut.CARD14=142
set myRouteSourceOut.CARD15=143
set myRouteSourceOut.CARD16=144
set myRouteSourceOut.CARD17=145
set myRouteSourceOut.CARD18=146
set myRouteSourceOut.CARD19=147
set myRouteSourceOut.CARD20=148
set myRouteSourceOut.CARD21=149
set myRouteSourceOut.CARD22=150
set myRouteSourceOut.CARD23=151
set myRouteSourceOut.CARD24=152
set myRouteSourceOut.CARD25=153
set myRouteSourceOut.CARD26=154
set myRouteSourceOut.CARD27=155
set myRouteSourceOut.CARD28=156
set myRouteSourceOut.CARD29=157
set myRouteSourceOut.CARD30=158
set myRouteSourceOut.CARD31=159
set myRouteSourceOut.CARD32=160
set myRouteSourceOut.AUXIN1=161
set myRouteSourceOut.AUXIN2=162
set myRouteSourceOut.AUXIN3=163
set myRouteSourceOut.AUXIN4=164
set myRouteSourceOut.AUXIN5=165
set myRouteSourceOut.AUXIN6=166
set myRouteSourceOut.TBINT=167
set myRouteSourceOut.TBEXT=168
set myRouteSourceOut.OUT1=169
set myRouteSourceOut.OUT2=170
set myRouteSourceOut.OUT3=171
set myRouteSourceOut.OUT4=172
set myRouteSourceOut.OUT5=173
set myRouteSourceOut.OUT6=174
set myRouteSourceOut.OUT7=175
set myRouteSourceOut.OUT8=176
set myRouteSourceOut.OUT9=177
set myRouteSourceOut.OUT10=178
set myRouteSourceOut.OUT11=179
set myRouteSourceOut.OUT12=180
set myRouteSourceOut.OUT13=181
set myRouteSourceOut.OUT14=182
set myRouteSourceOut.OUT15=183
set myRouteSourceOut.OUT16=184
set myRouteSourceOut.P161=185
set myRouteSourceOut.P162=186
set myRouteSourceOut.P163=187
set myRouteSourceOut.P164=188
set myRouteSourceOut.P165=189
set myRouteSourceOut.P166=190
set myRouteSourceOut.P167=191
set myRouteSourceOut.P168=192
set myRouteSourceOut.P169=193
set myRouteSourceOut.P1610=194
set myRouteSourceOut.P1611=195
set myRouteSourceOut.P1612=196
set myRouteSourceOut.P1613=197
set myRouteSourceOut.P1614=198
set myRouteSourceOut.P1615=199
set myRouteSourceOut.P1616=200
set myRouteSourceOut.AUX1=201
set myRouteSourceOut.AUX2=202
set myRouteSourceOut.AUX3=203
set myRouteSourceOut.AUX4=204
set myRouteSourceOut.AUX5=205
set myRouteSourceOut.AUX6=206
set myRouteSourceOut.MONL=207
set myRouteSourceOut.MONR=208



:: Set color names to numerical x32 color values

set myColor.OFF=0
set myColor.RD=1
set myColor.GN=2
set myColor.YE=3
set myColor.BL=4
set myColor.MG=5
set myColor.CY=6
set myColor.WH=7
set myColor.OFFi=8
set myColor.RDi=9
set myColor.GNi=10
set myColor.YEi=11
set myColor.BLi=12
set MyColor.MGi=13
set myColor.CYi=14
set myColor.WHi=15


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
call set buildtempDeviceType=!!tempvartype!
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

::  ****************** Use WING syntax ******************
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


:: if the command does not have a channel name to test, it isd not an error

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


if %buildtempCmd% EQU # goto :endbuildReaperfile





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







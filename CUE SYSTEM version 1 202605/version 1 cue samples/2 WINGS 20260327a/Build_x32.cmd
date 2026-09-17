ECHO OFF
color 06
set scriptver=Bethlehem 2025 X32RACK v20251125a
setlocal enabledelayedexpansion




:: display some initial script info for the record!  Weird code strips quote marks from the string so it displays nicely
set tempstring="."
set tempstringx=%tempstring:"=%
echo %tempstringx%
set tempstring=".      ***  Build x32 "  %scriptver% " base 20250512a  ***"
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
:: 	X32

:: Cues for this specific device of the specified TYPE are also tied to this 
::  Device Letter.  The Device Letter is used as the first letter in the cue file name
::  for all cues for this specific Device.

:: When running the Cues you will also provide an IP and a Port tied to the same letter
:: to asscociate these items together.  Since that can vary, these values are not built into
:: the cues but are assigned at the time the cue file are used.

:: Also set Delay...this is the number of ms that LTCOmmand should wait between
:: sending commands.  The default may be around 10, but seems not to be consistent.  
::  Also on an AMD processor thigns go very fast at the default delay, but on Intel the default is way too long.
::  A value of 0 is recommended for Intel and may work for an x32 but if you find x32 
::  lacking capacity to run these commands and process your audio, try bumping this up.

:: This is a single character designation.

set Type.X=X32
set Delay.X=0
set Prefix=X




:: File format is one of these choices

:: for X32 cues:

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
 


:: The file extension defines the set of cues for a project
:: the generated commands will be placed in the same file name with OUT prior to the specified
:: extension being again added to the end of the file name

set myFileExtension=cuex



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



for /F "tokens=1,2,3,4,5 delims=^|" %%a in ("%linetempvar%")do (
		set parma=%%a
		set parmb=%%b
		set parmc=%%c
		set parmd=%%d
		set parme=%%e
)


:: echo "Parameters are:"
:: echo           a is !parma!
:: echo           b is !parmb!
:: echo           c is !parmc!
:: echo           d is !parmd!
:: echo           e is !parme!

:: **************THIS MAKES THE FILE****

call :BuildCueFile %myFileExtension%, %tempvarx%, %mycurlinenum%, %parma%, %parmb%, %parmc%, %parmd%, %parme%
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

:: the extension for the file name includes OUT before the ext so add it once here

set buildtempOutExt=OUT%buildtempExt%

:: Find the Channel Number for the name proivided in VarB

set tempvarb=%%myChan.!buildtempVarB!%%
call set buildtempChanNum=!!tempvarb!!


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

if %buildtempDeviceType% EQU X32 goto :BuildX32CueContent



goto :endbuildfile





:BuildX32CueContent




::  ****************** Use X32 syntax ******************


if %buildtempCmd% EQU CHAN goto :buildCHAN
if %buildtempCmd% EQU CHANNAME goto :buildCHANNAME
if %buildtempCmd% EQU CHANCOLOR goto :buildCHANCOLOR
if %buildtempCmd% EQU CHANDCA goto :buildCHANDCA
if %buildtempCmd% EQU CHANSEND goto :buildCHANSEND

if %buildtempCmd% EQU DCA goto :buildDCA
if %buildtempCmd% EQU DCANAME goto :buildDCANAME
if %buildtempCmd% EQU DCACOLOR goto :buildDCACOLOR


if %buildtempCmd% EQU BUS goto :buildBUS
if %buildtempCmd% EQU BUSNAME goto :buildBUSNAME
if %buildtempCmd% EQU BUSCOLOR goto :buildBUSCOLOR

if %buildtempCmd% EQU MAINST goto :buildMAINST
if %buildtempCmd% EQU MAINSTNAME goto :buildMAINSTNAME
if %buildtempCmd% EQU MAINSTCOLOR goto :buildMAINSTCOLOR

if %buildtempCmd% EQU MAINM goto :buildMAINM
if %buildtempCmd% EQU MAINMNAME goto :buildMAINMNAME
if %buildtempCmd% EQU MAINMCOLOR goto :buildMAINMCOLOR

if %buildtempCmd% EQU USB_RECORDER goto :buildUSBRECORDER
if %buildtempCmd% EQU LIVE_RECORDER goto :buildLIVERECORDER

if %buildtempCmd% EQU ROUTE_OUT goto :buildROUTE_OUT
if %buildtempCmd% EQU ROUTE_IN goto :buildROUTE_IN

if %buildtempCmd% EQU createfile goto :buildCREATEFILE

if %buildtempCmd% EQU CUSTOMStartCue goto :buildCUSTOMStartCue

if %buildtempCmd% EQU CUSTOMEndCue goto :buildCustomEndCue

if %buildtempCmd% EQU SENDand_MUTE goto :buildSENDandMUTE
if %buildtempCmd% EQU SENDand_UNMUTE goto :buildSENDandUNMUTE


if %buildtempCmd% EQU SAVESCENE goto :buildSAVESCENE
if %buildtempCmd% EQU SAVESNIPPET goto :buildSAVESNIPPET
if %buildtempCmd% EQU LOADSCENE goto :buildLOADSCENE
if %buildtempCmd% EQU LOADSNIPPET goto :buildLOADSNIPPET

echo ***************** UNKNOWN COMMAND RECEIVED ******************************
echo %buildtempCMD%
echo *************************************************************************
goto :endbuildfile


:: **********************************************Process the "CHAN" command

:: the CHAN command is easy...just mute or unmute the channel and you are done


:buildCHAN
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
	echo /ch/%buildtempChanNum%/mix/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarC% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo /ch/%buildtempChanNum%/mix/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
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


:: **********************************************Process the "CHANNAME" command

:: the CHANNAME command is easy...just name the channel and you are done


:buildCHANNAME

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
	echo /ch/%buildtempChanNum%/config/name ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile


:: **********************************************Process the "CHANCOLOR" command

:: the CHANNAME command is easy...just color the channel and you are done


:buildCHANCOLOR

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


	echo /ch/%buildtempChanNum%/config/color ,i %buildtempColor% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile


:: **********************************************Process the "CHANDCA" command

:: the CHANDCA command is easy...look up values and set it


:buildCHANDCA

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


	echo /ch/%buildtempChanNum%/grp/dca ,i %buildtempDCANum% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile






:: **********************************************Process the "CHANSEND" command

:: the CHANSEND command is easy...just mute or unmute the channel send and you are done


:buildCHANSEND
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
	echo /ch/%buildtempChanNum%/mix/%buildtempBusNum%/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarD% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo /ch/%buildtempChanNum%/mix/%buildtempBusNum%/on  ,i 1 >> %buildtempFile%.%buildtempOutExt%
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







:: **********************************************Process the "DCA" command

:: the DCA command is easy...just mute or unmute the DCA and you are done


:buildDCA
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
	echo /dca/%buildtempDCANum%/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarC% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo /dca/%buildtempDCANum%/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
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


:: **********************************************Process the "DCANAME" command

:: the DCANAME command is easy...just name the DCA and you are done


:buildDCANAME

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


	echo /dca/%buildtempDCANum%/config/name ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile


:: **********************************************Process the "DCACOLOR" command

:: the DCANAME command is easy...just color the DCA and you are done


:buildDCACOLOR

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

	echo /dca/%buildtempDCANum%/config/color ,i %buildtempColor% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile


:: **********************************************Process the "BUS" command

:: the BUS command is easy...just mute or unmute the BUS and you are done


:buildBUS
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
	echo /bus/%buildtempBUSNum%/mix/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarC% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo /bus/%buildtempBUSNum%/mix/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
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


:: **********************************************Process the "BUSNAME" command

:: the BUSNAME command is easy...just name the Bus and you are done


:buildBUSNAME

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


	echo /bus/%buildtempBUSNum%/config/name ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile


:: **********************************************Process the "BUSCOLOR" command

:: the BUSCOLOR command is easy...just color the BUS and you are done


:buildBUSCOLOR

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

	echo /bus/%buildtempBUSNum%/config/color ,i %buildtempColor% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile




:: **********************************************Process the "MAINST" command

:: the MAINST command is easy...just mute or unmute the MAIN Stereo and you are done


:buildMAINST



if %buildtempVarB% EQU MUTE (
::	echo MUTE FOUND
	echo /main/st/mix/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarB% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo /main/st/mix/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
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


:: **********************************************Process the "MAINSTNAME" command

:: the MAINSTNAME command is easy...just name the MAIN ST and you are done


:buildMAINSTNAME


	echo /main/st/config/name ,s %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile


:: **********************************************Process the "MAINSTCOLOR" command

:: the MAINSTCOLOR command is easy...just color the MAINST and you are done


:buildMAINSTCOLOR
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

	echo /main/st/config/color ,i %buildtempColor% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile

:: **********************************************Process the "MAINM" command

:: the MAINM command is easy...just mute or unmute the MAINM and you are done


:buildMAINM



if %buildtempVarB% EQU MUTE (
::	echo MUTE FOUND
	echo /main/m/mix/on ,i 0 >> %buildtempFile%.%buildtempOutExt%
	set myFOUNDIT=1
)
if %buildtempVarB% EQU UNMUTE (
::	echo UNMUTE FOUND
	echo /main/m/mix/on ,i 1 >> %buildtempFile%.%buildtempOutExt%
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


:: **********************************************Process the "MAINMNAME" command

:: the MAINMNAME command is easy...just name the MAIN M and you are done


:buildMAINMNAME


	echo /main/m/config/name ,s %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile


:: **********************************************Process the "MAINMCOLOR" command

:: the MAINMCOLOR command is easy...just color the MAIN Mand you are done


:buildMAINMCOLOR
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

	echo /main/m/config/color ,i %buildtempColor% >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile


:: *****************************
:: *****************************


:: **********************************************Process the "ROUTE_OUT" command

:: the ROUTE_OUT interprets 2 values and does one command


:buildROUTE_OUT

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


	echo /config/userrout/out/%buildtempRouteOut% ,i %buildtempRouteName% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile

:: **********************************************Process the "ROUTE_IN" command

:: the ROUTE_IN interprets 2 values and does one command


:buildROUTE_IN

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


	echo /config/userrout/in/%buildtempRouteIn% ,i %buildtempRouteName% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile


:: **********************************************Process the "USBRECORDER" command

:: the USBRECORDER command is easy...just look up and set the value


:buildUSBRECORDER
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

	echo /-stat/tape/state ,i %buildtempUSBRECORDER% >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile

:: **********************************************Process the "LIVERECORDER" command

:: the LIVERECORDER command is easy...just look up and set the value


:buildLIVERECORDER
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

	echo /-stat/urec/state ,i %buildtempLIVERECORDER% >> %buildtempFile%.%buildtempOutExt%


goto :endbuildfile


:: **********************************************Process the "SENDand_UNMUTE" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not change the send, increments position counter
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

set /a mySendPosition=1
set /a myCharacterInString=0






:buildsendlooperB
set derivedSendPosition=%mySendPosition%
:: now for x32 the OSC requires a 2 digit track number so add leading 0 if needed
if %mySendPosition% LSS 10 set derivedSendPosition=0%mySendPosition%

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
	echo /ch/%buildtempChanNum%/mix/%derivedSendPosition%/on ,f 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperB
)
if "%buildtempchar%" EQU "1" (
	echo /ch/%buildtempChanNum%/mix/%derivedSendPosition%/on ,f 1 >> %buildtempFile%.%buildtempOutExt%
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
	:: unmute the channel
	echo /ch/%buildtempChanNum%/mix/on ,i 1 >> %buildtempFile%.%buildtempOutExt%

	goto :endbuildfile
)

goto :endbuildfile


:: **********************************************Process the "SENDand_MUTE" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not change the send, increments position counter
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

set /a mySendPosition=1
set /a myCharacterInString=0

:: mute the channel
echo /ch/%buildtempChanNum%/mix/on ,i 0 >> %buildtempFile%.%buildtempOutExt%

:buildsendlooperC
set derivedSendPosition=%mySendPosition%
:: now for x32 the OSC requires a 2 digit track number so add leading 0 if needed
if %mySendPosition% LSS 10 set derivedSendPosition=0%mySendPosition%

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
	echo /ch/%buildtempChanNum%/mix/%derivedSendPosition%/on ,f 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperC
)
if "%buildtempchar%" EQU "1" (
	echo /ch/%buildtempChanNum%/mix/%derivedSendPosition%/on ,f 1 >> %buildtempFile%.%buildtempOutExt%
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
	echo delay %buildtempDeviceDelay% >> %buildtempFile%.%buildtempOutExt%

	echo Now building file %buildtempFile%.%buildtempOutExt%
	goto :endbuildfile



:: **********************************************Process the "CUSTOMStartCue" command


:buildCUSTOMStartCue

type NUL > %buildtempFile%.%buildtempOutExt%
echo Created file %buildtempFile%.%buildtempOutExt%
echo delay %buildtempDeviceDelay% >> %buildtempFile%.%buildtempOutExt%
echo /main/st/config/name ,s *%buildtempVarB% >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile

:: **********************************************Process the "CUSTOMEndCue" command


:buildCUSTOMEndCue


echo /main/st/config/name ,s %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile



:: **********************************************Process the "PAUSE" command

:: the PAUSE command is easy...just toggle


:buildPAUSE
	echo /pause ,i 1 >> %buildtempFile%.%buildtempOutExt%	
goto :endbuildfile

:: **********************************************Process the "SAVESCENE" command

:buildSAVESCENE

echo /save ,siss scene %buildtempVarB% "%buildtempVarC%" "%buildtempVarD%" >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile

:: **********************************************Process the "SAVESNIPPET" command

:buildSAVESNIPPET

echo /save ,sis snippet %buildtempVarB% "%buildtempVarC%" >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile

:: **********************************************Process the "LOADSCENE" command

:buildLOADSCENE

echo /load ,si scene %buildtempVarB%  >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile

:: **********************************************Process the "LOADSNIPPPET" command

:buildLOADSNIPPET

echo /load ,si snippet %buildtempVarB%  >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile



:endbuildfile
:: echo ending
exit /B
:: ************************************************************
:: ************************************************************

:ENDOFSCRIPT







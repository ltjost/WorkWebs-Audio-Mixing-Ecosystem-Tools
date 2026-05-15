ECHO OFF
color 06
set scriptver=SPOTLIGHT_20250506a

setlocal enabledelayedexpansion

:: display some initial script info for the record!  Weird code strips quote marks from the string so it displays nicely
set tempstring="."
set tempstringx=%tempstring:"=%
echo %tempstringx%
set tempstring=".      ***  LJ LTCommand BUILD REAPER CODE 20250401a "  %scriptver% "   ***"
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
:: 	REAPER

:: Cues for this specific device of the specified TYPE are also tied to this 
::  Device Letter.  The Device Letter is used as the first letter in the cue file name
::  for all cues for this specific Device.

:: When running the Cues you will also provide an IP and a Port tied to the same letter
:: to asscociate these items together.  Since that can vary, these values are not built into
:: the cues but are assigned at the time the cue file are used.

:: Also set Delay...this is the number of ms that LTCOmmand shoudl wait between
:: sending commands.  The default may be around 10, but seems not to be consistent.  
::  Also on an AMD processor thigns go very fast at the default delay, but on Intel the default is way too long.
::  A value of 0 is recommended for Intel and may work for REAPER but if you find REAPER 
::  lacking CPU capacity to run these commands and process your audio, try bumping this up.

:: This is a single character designation.

set Type.A=REAPER
set Delay.A=0
set Prefix=A

:: The Run script will also need:
::	set IP.A=192.168.1.248
::	set Port.A=10027



:: File format is one of these choices

:: for REAPER cues:

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
 
:: ****************************** EDIT BELOW ***************************

:: The file extension defines the set of cues for a project
:: the generated commands will be placed in the same file name with OUT prior to the specified
:: extension being again added to the end of the file name

set myFileExtension=cuex



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

for %%f in (!Prefix!*.!myFileExtension!) do (
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

if %buildtempCmd% EQU createfile goto :SKIPChanNameTest
if %buildtempCmd% EQU MARKERName goto :SKIPChanNameTest
if %buildtempCmd% EQU LASTMARKERName goto :SKIPChanNameTest
if %buildtempCmd% EQU GOTMarker goto :SKIPChanNameTest
if %buildtempCmd% EQU RECORD goto :SKIPChanNameTest
if %buildtempCmd% EQU PLAY goto :SKIPChanNameTest
if %buildtempCmd% EQU STOP goto :SKIPChanNameTest
if %buildtempCmd% EQU PAUSE goto :SKIPChanNameTest
if %buildtempCmd% EQU ACTIONi goto :SKIPChanNameTest
if %buildtempCmd% EQU ACTIONs goto :SKIPChanNameTest
if %buildtempCmd% EQU PASSTHRU goto :SKIPChanNameTest


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

:SKIPChanNameTest



set buildtempDeviceLetter=%buildtempFile:~0,1%

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


	
:: pick a flavor and process accordingly

if %buildtempDeviceType% EQU REAPER goto :BuildReaperCueContent



goto :endbuildfile





:BuildReaperCueContent




::  ****************** Use REAPER syntax ******************


if %buildtempCmd% EQU SENDand_UNMUTE_NAME goto :buildWorkSENDandUNMUTENAMEThisA
if %buildtempCmd% EQU SENDand_MUTE_NAME goto :buildWorkSENDandMUTENAMEThisA
if %buildtempCmd% EQU SENDand_UNMUTE goto :buildWorkSENDandUNMUTEThisA
if %buildtempCmd% EQU SENDand_MUTE goto :buildWorkSENDandMUTEThisA
if %buildtempCmd% EQU MARKERName goto :buildMARKERNAME
if %buildtempCmd% EQU MUTE goto :buildMuteME
if %buildtempCmd% EQU UNMUTE goto :buildUNMuteME
if %buildtempCmd% EQU SELECT goto :buildSelectME
if %buildtempCmd% EQU UNSELECT goto :buildUnSelectME
if %buildtempCmd% EQU SENDand_ezMUTE goto :buildezMuteME
if %buildtempCmd% EQU SENDand_ezMUTE_NAME goto :buildezMuteME
if %buildtempCmd% EQU AUTOMIXON goto :buildAUTOMIXONme
if %buildtempCmd% EQU AUTOMIXOFF goto :buildAUTOMIXOFFme
if %buildtempCmd% EQU ARMON goto :buildARMONme
if %buildtempCmd% EQU ARMOFF goto :buildARMOFFme
if %buildtempCmd% EQU FXBYPASS goto :buildFXBYPASSME
if %buildtempCmd% EQU FXACTIVE goto :buildFXACTIVEME
if %buildtempCmd% EQU TRACKNAME goto :buildTRACKNAME
if %buildtempCmd% EQU TRACKVOLUME goto :buildTRACKVOLUME
if %buildtempCmd% EQU TRACKPAN goto :buildTRACKPAN
if %buildtempCmd% EQU ACTIONi goto :buildACTIONi
if %buildtempCmd% EQU ACTIONs goto :buildACTIONs
if %buildtempCmd% EQU LASTMARKERName goto :buildLASTMARKERName
if %buildtempCmd% EQU CUSTOMStartCue goto :buildCUSTOMStartCue
if %buildtempCmd% EQU CUSTOMEndCue goto :buildCUSTOMEndCue
if %buildtempCmd% EQU createfile goto :buildCREATEFILE
if %buildtempCmd% EQU GOTOMarker goto :buildGOTOMarker
if %buildtempCmd% EQU RECORD goto :buildRECORD
if %buildtempCmd% EQU PLAY goto :buildPLAY
if %buildtempCmd% EQU STOP goto :buildSTOP
if %buildtempCmd% EQU PAUSE goto :buildPAUSE
if %buildtempCmd% EQU PLUGIN_ADJ goto :buildWorkPLUGIN_ADJThis
if %buildtempCmd% EQU FXOPENUI goto :buildFXOPENUI
if %buildtempCmd% EQU FXCLOSEUI goto :buildFXCLOSEUI





echo ***************** UNKNOWN COMMAND RECEIVED ******************************
echo %buildtempCMD%
echo *************************************************************************
goto :endbuildfile


:: **********************************************Process the "MUTE" command

:: the MUTE command is easy...just mute the channel and you are done...maybe new name too


:buildMuteME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/mute ,i 1 to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/mute ,i 1 >> %buildtempFile%.%buildtempOutExt%
	if defined buildtempVarC (
::		echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarB% to %buildtempFile%.%buildtempOutExt%
		echo /track/%buildtempChanNum%/name ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%
	)
goto :endbuildfile

:: **********************************************Process the "SENDand_ezMUTE"  or "SENDand_ezNUTE_NAME" command

:: ...just mute the channel and you are done


:buildezMuteME
	echo /track/%buildtempChanNum%/mute ,i 1 >> %buildtempFile%.%buildtempOutExt%
	goto :endbuildfile



:: **********************************************Process the "AUTOMIXON" command CUSTOM CODE

:: the AUTOMIXON command is easy...
:: clear fx 3 param 7 at (CHAN)


:buildAUTOMIXONme
	echo /track/%buildtempChanNum%/fx/2/fxparam/7/value ,f 0 >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile

:: **********************************************Process the "AUTOMIXOFF" command CUSTOM CODE

:: the AUTOMIXOFF command is easy...
:: set fx 3 param 7 at (CHAN)


:buildAUTOMIXOFFme
	echo /track/%buildtempChanNum%/fx/2/fxparam/7/value ,f 1 >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile


:: **********************************************Process the "ARMON" command


:buildARMONme
	echo /track/%buildtempChanNum%/recarm ,i 1 >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile

:: **********************************************Process the "ARMOFF" command




:buildARMOFFme
	echo /track/%buildtempChanNum%/recarm ,i 0 >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile




:: **********************************************Process the "UNMUTE" command

:: the UNMUTE command is easy...just unmute the channel and you are done...maybe new name too


:buildUNMuteME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/mute ,i 0 to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/mute ,i 0 >> %buildtempFile%.%buildtempOutExt%
	if defined buildtempVarC (
::		echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarC% to %buildtempFile%.%buildtempOutExt%
		echo /track/%buildtempChanNum%/name ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%
	)
goto :endbuildfile

:: **********************************************Process the "SELECT" command

:: the SELECT command is easy...just mute the channel and you are done...maybe new name too


:buildSelectME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/select ,i 1 to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/select ,i 1 >> %buildtempFile%.%buildtempOutExt%
	if defined buildtempVarC (
::		echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarB% to %buildtempFile%.%buildtempOutExt%
		echo /track/%buildtempChanNum%/name ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%
	)
goto :endbuildfile


:: **********************************************Process the "UNSELECT" command

:: the UNSELECT command is easy...just unmute the channel and you are done...maybe new name too


:buildUNSelectME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/select ,i 0 to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/select ,i 0 >> %buildtempFile%.%buildtempOutExt%
	if defined buildtempVarC (
::		echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarC% to %buildtempFile%.%buildtempOutExt%
		echo /track/%buildtempChanNum%/name ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%
	)
goto :endbuildfile







:: **********************************************Process the "SENDand_UNMUTE_NAME" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not change the send, increments position counter
::   * terminates the string processing



:buildWorkSENDandUNMUTENAMEThisA

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


:buildsendlooper

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f 0  to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooper
)
if "%buildtempchar%" EQU "1" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f %buildtempVarE%  to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f %buildtempVarE% >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooper
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooper
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildsendlooper
)
if "%buildtempchar%" EQU "*" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/mute ,i 0 to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/mute ,i 0 >> %buildtempFile%.%buildtempOutExt%
	if defined buildtempVarD (
::		echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarE% to %buildtempFile%.%buildtempOutExt%
		echo /track/%buildtempChanNum%/name ,s %buildtempVarD% >> %buildtempFile%.%buildtempOutExt%
	)
	goto :endbuildfile
)
goto :endbuildfile


:: **********************************************Process the "SENDand_MUTE_NAME" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not change the send, increments position counter
::   * terminates the string processing


:buildWorkSENDandMUTENAMEThisA

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
echo /track/%buildtempChanNum%/mute ,i 1 >> %buildtempFile%.%buildtempOutExt%

:buildsendlooperA

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f 0  to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperA
)
if "%buildtempchar%" EQU "1" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f %buildtempVarE%  to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f %buildtempVarE% >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperA
)
if "%buildtempchar%" EQU "x" (
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperA
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildsendlooperA
)
if "%buildtempchar%" EQU "*" (
	if defined buildtempVarD (
::		echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarD% to %buildtempFile%.%buildtempOutExt%
		echo /track/%buildtempChanNum%/name ,s %buildtempVarD% >> %buildtempFile%.%buildtempOutExt%
	)
	goto :endbuildfile
)

goto :endbuildfile



:: **********************************************Process the "SENDand_UNMUTE" command

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   0 sets the send to 0 volume, increments position counter
::   1 sets the send to VarE value, increments position counter
::   x does not change the send, increments position counter
::   * terminates the string processing



:buildWorkSENDandUNMUTEThisA

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


:buildsendlooperB

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f 0  to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperB
)
if "%buildtempchar%" EQU "1" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f %buildtempVarD%  to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f %buildtempVarD% >> %buildtempFile%.%buildtempOutExt%
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
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/mute ,i 0 to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/mute ,i 0 >> %buildtempFile%.%buildtempOutExt%

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


:buildWorkSENDandMUTEThisA

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
echo /track/%buildtempChanNum%/mute ,i 1 >> %buildtempFile%.%buildtempOutExt%

:buildsendlooperC

call set "buildtempchar=%%buildtempSendString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "0" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f 0  to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f 0 >> %buildtempFile%.%buildtempOutExt%
	set /a mySendPosition+=1
	set /a myCharacterInString+=1
	goto :buildsendlooperC
)
if "%buildtempchar%" EQU "1" (
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f %buildtempVarD%  to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/send/%mySendPosition%/volume ,f %buildtempVarD% >> %buildtempFile%.%buildtempOutExt%
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




:: **********************************************Process the "PLUGIN_ADJ" command CUSTOM CODE

:: run the string for sends below like this
::   - is ignored and does not even increment the position number
::   x does not change the send, increments position counter
::   * terminates the string processing
::   {anything else} processes specific custom code based on the character specified


:buildWorkPLUGIN_ADJThis

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

:buildpluginlooper

call set "buildtempchar=%%buildtempPluginString:~%myCharacterInString%,1%%"
if "%buildtempchar%" EQU "a" (
	echo /track/%buildtempChanNum%/fx/%myPluginPosition%/fxparam/1/value ,f 1 >> %buildtempFile%.%buildtempOutExt%
	set /a myPluginPosition+=1
	set /a myCharacterInString+=1
	goto :buildpluginlooper
)
if "%buildtempchar%" EQU "x" (
	set /a myPluginPosition+=1
	set /a myCharacterInString+=1
	goto :buildpluginlooper
)
if "%buildtempchar%" EQU "-" (
	set /a myCharacterInString+=1
	goto :buildpluginlooper
)
if "%buildtempchar%" EQU "*" (

	goto :endbuildfile
)

goto :endbuildfile











:: **********************************************Process the "MARKERNAME" command

:: the MARKERName command is easy...just place the name

:buildMARKERNAME

::	echo Writing Reaper OSC line /marker/%buildtempVarB%/name ,s %buildtempVarC%  to %buildtempFile%.%buildtempOutExt%
	echo /marker/%buildtempVarB%/name ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile

:: **********************************************Process the "LASTMARKERNAME" command

:: the LASTMARKERName command is easy...just place the name

:buildLASTMARKERNAME

::	echo Writing Reaper OSC line /lastmarker/name ,s %buildtempVarB%  to %buildtempFile%.%buildtempOutExt%
	echo /lastmarker/name ,s %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile

:: **********************************************Process the "FXBYPASS" command

:buildFXBYPASSME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/fx/%buildtempVarC% ,i 0 to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/fx/%buildtempVarC% ,i 0 >> %buildtempFile%.%buildtempOutExt%

:: **********************************************Process the "FXACTIVE" command
goto :endbuildfile

:buildFXACTIVEME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/fx/%buildtempVarC% ,i 1 to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/fx/%buildtempVarC% ,i 1 >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile

:: **********************************************Process the "TRACKNAME" command

:buildTRACKNAME
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/name ,s %buildtempVarC% to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/name ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile

:: **********************************************Process the "TRACKVOLUME" command
:buildTRACKVOLUME
	echo /track/%buildtempChanNum%/volume ,f %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile

:: **********************************************Process the "TRACKPAN" command
:buildTRACKPAN
	echo /track/%buildtempChanNum%/pan ,f %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%

goto :endbuildfile
:: **********************************************Process the "ACTIONi" command

:buildACTIONi
::	echo Writing Reaper OSC line /action ,i %buildtempVarB% to %buildtempFile%.%buildtempOutExt%
	echo /action ,i %buildtempVarB%  >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile
:: **********************************************Process the "ACTIONs" command

:buildACTIONs
::	echo Writing Reaper OSC line /action/str ,s %buildtempVarB% to %buildtempFile%.%buildtempOutExt%
	echo /action/str ,s %buildtempVarB%>> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile

:: **********************************************Process the "FXOPENUI" command

:buildFXOPENUI
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/fx/%buildtempVarC%/openui ,i 1 to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/fx/%buildtempVarC%/openui ,i 1 >> %buildtempFile%.%buildtempOutExt%

:: **********************************************Process the "FXCLOSEUI" command
goto :endbuildfile

:buildFXCLOSEUI
::	echo Writing Reaper OSC line /track/%buildtempChanNum%/fx/%buildtempVarC%/openui ,i 0 to %buildtempFile%.%buildtempOutExt%
	echo /track/%buildtempChanNum%/fx/%buildtempVarC%/openui ,i 0 >> %buildtempFile%.%buildtempOutExt%
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
echo /track/%buildtempChanNum%/name ,s *%buildtempVarC% >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile

:: **********************************************Process the "CUSTOMEndCue" command


:buildCUSTOMEndCue


echo /track/%buildtempChanNum%/name ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%
echo /action ,i 40157  >> %buildtempFile%.%buildtempOutExt%
echo /lastmarker/name ,s %buildtempVarC% >> %buildtempFile%.%buildtempOutExt%
goto :endbuildfile




:: **********************************************Process the "GOTOMarker" command

:: the GOTOMarker command is easy...just one argument 


:buildGOTOMarker
	echo /marker ,i %buildtempVarB% >> %buildtempFile%.%buildtempOutExt%	
goto :endbuildfile



:: **********************************************Process the "STOP" command

:: the STOP command is easy...just toggle


:buildSTOP
	echo /stop ,i 1 >> %buildtempFile%.%buildtempOutExt%	
goto :endbuildfile


:: **********************************************Process the "PLAY" command

:: the PLAY command is easy...just toggle


:buildPLAY
	echo /play ,i 1 >> %buildtempFile%.%buildtempOutExt%	
goto :endbuildfile

:: **********************************************Process the "RECORD" command

:: the RECORD command is easy...just toggle


:buildRECORD
	echo /record ,i 1 >> %buildtempFile%.%buildtempOutExt%	
goto :endbuildfile

:: **********************************************Process the "PAUSE" command

:: the PAUSE command is easy...just toggle


:buildPAUSE
	echo /pause ,i 1 >> %buildtempFile%.%buildtempOutExt%	
goto :endbuildfile




:endbuildfile
:: echo ending
exit /B
:: ************************************************************
:: ************************************************************

:ENDOFSCRIPT







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

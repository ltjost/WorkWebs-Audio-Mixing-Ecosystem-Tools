ECHO OFF
color 06
set scriptver=EASTER HOLY WEEK 2026 v20260327a v2
setlocal enabledelayedexpansion


:: display some initial script info for the record!  Weird code strips quote marks from the string so it displays nicely
set tempstring="."
set tempstringx=%tempstring:"=%
echo %tempstringx%
set tempstring=".      ***   LJ LTCommand RUN CODE 20250523a "  %scriptver% "   ***"
set tempstringx=%tempstring:"=%
echo %tempstringx%
set tempstring="."
set tempstringx=%tempstring:"=%
echo %tempstringx%


:: **************************************************************************************
:: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
:: ******************************** SET THESE *******************************************


:: The Device Letter is based on the first letter in the cue file name.
:: This directs creation of OSC commands that match that device's OSC implememntation.
:: Each such device also needs and IP and Port to specify how to send command files.
:: This is a single letter designation.  The TYPE is also needed can can be WING or anything else

:: Pause is the number of seconds to wait after running this cue...handy if you want some rough delays between things.

:: Follow is the name of a cue that should be run automatically immediately after the current cue. In this way you can
:: trigger a set of cues for the same or different devices from one keystroke

:: Execute tells if you want to use "call" or "start" to run the cue.  
:: If you say "call" (without the  quotes), it does a call which waits for the script to run before going on.
::  If you specify "start" (without the quotes) then a window opens and runs the commands and then the window closes.
::  Other things can run immediately as there is no attempt to wait  for one cue to finish
:: before starting the next.  If you do things back to back you may end up with overlap to the same device so be careful.

set IP.A=192.168.0.107
set Port.A=10030
set Type.A=REAPER
set myFileExtension=cuex.OUTcuex

set IP.X=192.168.0.196
set Port.X=10023
set Type.X=X32

set IP.V=192.168.0.11
set Port.V=2223
set Type.V=WING

set IP.I=192.168.0.12
set Port.I=2223
set Type.I=WING


:: set myFileExtension=fr.OUTfr


echo Processing cue files
::  ***********************************************************************************
::  ************  CUES ARE DEFINED HERE ***********************************************
::  ***********************************************************************************


:: set the cue subscript to the starting point to 0

set /a cuecount=0


::  FOR EACH CUE


set /a cuecount+=1
set cue[%cuecount%].cuename=000
set cue[%cuecount%].file=V_OFF
set cue[%cuecount%].cuedescr= setup for service-all that need to mute and unmute are muted
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=000a
set cue[%cuecount%].execute=call
set /a cuecount+=1
set cue[%cuecount%].cuename=000a
set cue[%cuecount%].file=I_OFF
set cue[%cuecount%].cuedescr= setup for service-all that need to mute and unmute are muted
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=010
set cue[%cuecount%].file=I_GFTRAD_SETUP
set cue[%cuecount%].cuedescr= set trad good friday instr setup so mute group works
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=010a
set cue[%cuecount%].execute=call
set /a cuecount+=1
set cue[%cuecount%].cuename=010a
set cue[%cuecount%].file=V_GFTRAD_SETUP
set cue[%cuecount%].cuedescr= set trad good friday instr setup so mute group works
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=020
set cue[%cuecount%].file=I_E58_SETUP
set cue[%cuecount%].cuedescr= set trad instr setup for Easter Saturday at 5 and Sunday at 8 so mute group works
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=020a
set cue[%cuecount%].execute=call
set /a cuecount+=1
set cue[%cuecount%].cuename=020a
set cue[%cuecount%].file=V_E58_SETUP
set cue[%cuecount%].cuedescr= set trad instr setup for Easter Saturday at 5 and Sunday at 8 so mute group works
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=030
set cue[%cuecount%].file=I_E930_SETUP
set cue[%cuecount%].cuedescr= set trad instr setup for Easter Sunday at 9:30 so mute group works
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=030a
set cue[%cuecount%].execute=call
set /a cuecount+=1
set cue[%cuecount%].cuename=030a
set cue[%cuecount%].file=V_E930_SETUP
set cue[%cuecount%].cuedescr= set trad instr setup for Easter Sunday at 9:30 so mute group works
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=040
set cue[%cuecount%].file=I_E11_SETUP
set cue[%cuecount%].cuedescr= set trad instr setup for Easter Sunday at 11 so mute group works
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=040a
set cue[%cuecount%].execute=call
set /a cuecount+=1
set cue[%cuecount%].cuename=040a
set cue[%cuecount%].file=V_E11_SETUP
set cue[%cuecount%].cuedescr= set trad instr setup for Easter Sunday at 11 so mute group works
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call


::  ***********************************************************************************
::  ************  CUES for 530 Good Friday ARE DEFINED HERE ***************************
::  ***********************************************************************************



set /a cuecount+=1
set cue[%cuecount%].cuename=200
set cue[%cuecount%].file=V_OFF
set cue[%cuecount%].cuedescr= mute all vocals for start of 530 Good Friday
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=200a
set cue[%cuecount%].execute=call
set /a cuecount+=1
set cue[%cuecount%].cuename=200a
set cue[%cuecount%].file=I_OFF
set cue[%cuecount%].cuedescr= mute all instruments for start of 530 Good Friday
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=220
set cue[%cuecount%].file=V_GF530_220
set cue[%cuecount%].cuedescr= only YUTES
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=230
set cue[%cuecount%].file=V_GF530_230
set cue[%cuecount%].cuedescr= only skit
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=240
set cue[%cuecount%].file=V_GF530_240
set cue[%cuecount%].cuedescr= only PK singers including some in skit
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=241
set cue[%cuecount%].file=V_GF530_241
set cue[%cuecount%].cuedescr= off
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=250
set cue[%cuecount%].file=V_GF530_250
set cue[%cuecount%].cuedescr= + jocelyn amelia am 
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=260
set cue[%cuecount%].file=V_GF530_260
set cue[%cuecount%].cuedescr= only yutes
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=270
set cue[%cuecount%].file=V_GF530_270
set cue[%cuecount%].cuedescr= only carson lottie
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=280
set cue[%cuecount%].file=V_GF530_280
set cue[%cuecount%].cuedescr= only yutes
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=290
set cue[%cuecount%].file=V_GF530_290
set cue[%cuecount%].cuedescr= only jocelyn amelia
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=300
set cue[%cuecount%].file=V_GF530_300
set cue[%cuecount%].cuedescr= only yutes
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=310
set cue[%cuecount%].file=V_GF530_310
set cue[%cuecount%].cuedescr= only carson lottie
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=320
set cue[%cuecount%].file=V_GF530_320
set cue[%cuecount%].cuedescr= only yutes
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=330
set cue[%cuecount%].file=V_GF530_330
set cue[%cuecount%].cuedescr= only skit
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=340
set cue[%cuecount%].file=V_GF530_340
set cue[%cuecount%].cuedescr= only yutes
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=350
set cue[%cuecount%].file=V_GF530_350
set cue[%cuecount%].cuedescr= only carson lottie
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=360
set cue[%cuecount%].file=V_GF530_360
set cue[%cuecount%].cuedescr= only yutes
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=370
set cue[%cuecount%].file=V_GF530_370
set cue[%cuecount%].cuedescr= only jocelyn amelia lottie
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=380
set cue[%cuecount%].file=V_GF530_380
set cue[%cuecount%].cuedescr= only yutes pks and some skitters
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=390
set cue[%cuecount%].file=V_GF530_390
set cue[%cuecount%].cuedescr= only skitters
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=401
set cue[%cuecount%].file=V_OFF
set cue[%cuecount%].cuedescr= off
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=401a
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=401a
set cue[%cuecount%].file=I_OFF
set cue[%cuecount%].cuedescr= off
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call



echo CUE COUNT is %cuecount%

:: ************************************************************************************
:: ********  ALL IS NOW SET UP - BELOW IS THE CODE  ***********************************
:: ************************************************************************************

::*************************************************************************************
::*** USER DIALOGUE AND MAIN LOOP IS HERE *********************************************
::*************************************************************************************

:: Initially not on a cue
set /A cueloopCurCue=0

:: wait for instructions
:cueloopPROMPT

set /A nextcue=%cueloopCurCue%+1

	call set nextcuelooptempCueName=!cue[%nextcue%].cuename!
	call set nextcuelooptempCueDescr=!cue[%nextcue%].cuedescr!
echo  [1;93m

	call echo .
	call echo .
	call echo .
	call echo .
	call echo   --- (%nextcue%) Next Cue is:   %nextcuelooptempCueName% %nextcuelooptempCueDescr%
::	     echo *******************************************************************
::	     echo *******************************************************************

echo  [1;97m





:: check if there is an automatic follow to execute
if "%tempFOLLOW%" == "" goto :heyNofollow
set usersays=%tempFOLLOW%

echo FOLLOW FOUND

goto :cueloopCUENAME
:heyNofollow



	set usersays=n

        echo [0;94m 
	echo ***
	set /P usersays=*** Press ENTER for next / p and Enter for Prior / Cue Name and enter / x to exit:
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

	if %usersays% == n goto :cueloopNEXT
	if %usersays% == p goto :cueloopPRIOR
	if %usersays% == x goto :cueloopEXIT
			     goto :cueloopCUENAME


:cueloopNEXT

	if %cueloopCurCue% GEQ %cuecount% echo There is no next Cue

	if %cueloopCurCue% GEQ %cuecount% goto :cueloopPROMPT

	set /A cueloopCurCue=%cueloopCurCue%+1
	call :DoCue %cueloopCurCue%
	call set cuelooptempCueName=!cue[%cueloopCurCue%].cuename!
	call set cuelooptempCueDescr=!cue[%cueloopCurCue%].cuedescr!
 echo [1;97m 

::	     echo *******************************************************************
	call echo   --- (%cueloopCurCue%) Now on  Cue:   %cuelooptempCueName% %cuelooptempCueDescr% 




	goto :cueloopPROMPT

:cueloopPRIOR
	:: echo cur is %cueloopCurCue%

	if %cueloopCurCue% LEQ 1 echo There is no prior Cue

	if %cueloopCurCue% LEQ 1 goto :cueloopPROMPT

	set /A cueloopCurCue=%cueloopCurCue%-1
	call :DoCue %cueloopCurCue%
	call set cuelooptempCueName=!cue[%cueloopCurCue%].cuename!
	call set cuelooptempCueDescr=!cue[%cueloopCurCue%].cuedescr!
 echo [1;97m 
::	     echo *******************************************************************
	call echo   --- (%cueloopCurCue%) Now on  Cue:   %cuelooptempCueName% %cuelooptempCueDescr% 
 


	goto :cueloopPROMPT

:cueloopCUENAME
	set /A cuelooptempINDEX=1
	set tempFOLLOW=
:cueloopNEXTNAME
	if %cuelooptempINDEX% GTR %cuecount% goto :cueloopNOTVALID
	if !cue[%cuelooptempINDEX%].cuename! EQU %usersays% goto :cueloopFOUNDMATCH
	set /A cuelooptempINDEX=%cuelooptempINDEX%+1
	goto :cueloopNEXTNAME
	
:cueloopFOUNDMATCH
	set /A cueloopCurCue=%cuelooptempINDEX%
	call :DoCue %cueloopCurCue%
:: COMMENT	set tempFollow=
 echo [1;97m 
	call set cuelooptempCueName=!cue[%cueloopCurCue%].cuename!
	call set cuelooptempCueDescr=!cue[%cueloopCurCue%].cuedescr!
::	     echo *******************************************************************
	call echo   --- (%cueloopCurCue%) Now on  Cue:   %cuelooptempCueName% %cuelooptempCueDescr% 
	goto :cueloopPROMPT

:cueloopNOTVALID

	echo The requested cue is not present: %usersays%
	set tempFOLLOW=
	goto :cueloopPROMPT

	
:cueloopEXIT
echo ***************************************************
echo ****   Goodbye and enjoy the rest of your day! ****
echo ***************************************************



EXIT /B

::*************************************************************************************
::****** This ends the main prompt and user entry loop ********************************
::*************************************************************************************






::*************************************************************************************
::*** DoCUE ---RUN THE DESIRED CUE called with the arument of the cue subscript *******
::*************************************************************************************




:DoCue
:: argument is the cue subscript number
set tempCueNum=%~1

:: get the full file name
call set myTempCuefile=!cue[%tempCueNum%].file!.!myFileExtension!

:: get the destination letter from the first letter of the file name
call set myTempCueType=%myTempCueFile:~0,1%

:: get the ip for this file type
call set myTempIP=!IP.%myTempCueType%!

:: get the port for this file type
call set myTempPort=!Port.%myTempCueType%!

:: get the type for this file type
call set myTempType=!Type.%myTempCueType%!

::check start method
call set myTempExecute=!cue[%tempCueNum%].execute!


:: echo FILE IS: %myTempCueFile%
:: echo TYPE IS: %myTempCueType%
:: echo IP   IS: %myTempIP%
:: echo PORT IS: %myTempPort%
:: echo EXECUTE IS: %myTempExecute%
:: echo TYPE IS: %myTempType%


IF %myTempType% EQU WING goto :wingcmd

IF EXIST %myTempCueFile% (
			if %myTempExecute% EQU start (
					start LT_Command -c -n -i %myTempIP% -p %myTempPort% -t %myTempCueFile%
			) ELSE (
			call LT_Command -c -n -i %myTempIP% -p %myTempPort% -t %myTempCueFile% -l LOGFILE
			)
	
) ELSE (
	color 04
  	echo %myTempCueFile% DOES NOT EXIST
)
goto :commandhandled
:wingcmd
IF EXIST %myTempCueFile% (
			if %myTempExecute% EQU start (
					start wosc -i %myTempIP% -f %myTempCueFile% -v 0 > NUL
			) ELSE (
			call wosc -i %myTempIP% -f %myTempCueFile% -v 0 > NUL
			)
	
) ELSE (
	color 04
  	echo %myTempCueFile% DOES NOT EXIST
)






:commandhandled

::*************************************************************************************
::*** IF an AFTERPAUSE is specified wait for it !!!!!  *****************************************************
::*************************************************************************************

call set tempPAUSE=%%cue[%tempCueNum%].afterpause%%
if not defined tempPAUSE goto :noAfterPause
if %tempPAUSE% EQU 0 goto :noAfterPause
if %tempPAUSE% EQU x goto :noAfterPause
timeout /t %tempPAUSE%

:noAfterPause



::*************************************************************************************
::*** IF an follow is specified save it off !!!!!  *****************************************************
::*************************************************************************************

set tempFOLLOW=
call set tempFOLLOW=%%cue[%tempCueNum%].follow%%



exit /B 0
::*************************************************************************************
::*** THE CUE IS PROCESSED !!!!!  *****************************************************
::*************************************************************************************


:ENDOFSCRIPT







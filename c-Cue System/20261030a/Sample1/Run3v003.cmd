ECHO OFF
color 06
set scriptver=RUN3v003
setlocal enabledelayedexpansion
set myDevice=
Set myContent=

:: display some initial script info for the record!  Weird code strips quote marks from the string so it displays nicely
set tempstring="."
set tempstringx=%tempstring:"=%
echo %tempstringx%
set tempstring=".      ***   RUN "  %scriptver% "   ***"
set tempstringx=%tempstring:"=%
echo %tempstringx%
set tempstring="."
set tempstringx=%tempstring:"=%
echo %tempstringx%


:: **************************************************************************************
:: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
:: ******************************** SET THESE *******************************************



:: Each such device also needs and IP and Port to specify how to send command files.

:: Pause is the number of seconds to wait after running this cue...handy if you want some rough delays between things.

:: Follow is the name of a cue that should be run automatically immediately after the current cue. In this way you can
:: trigger a set of cues for the same or different devices from one keystroke

:: Execute tells if you want to use "call" or "start" to run the cue.  
:: If you say "call" (without the  quotes), it does a call which waits for the script to run before going on.
::  If you specify "start" (without the quotes) then a window opens and runs the commands and then the window closes.
::  Other things can run immediately as there is no attempt to wait  for one cue to finish
:: before starting the next.  If you do things back to back you may end up with overlap to the same device so be careful.



call Run_File_Extension.cmd

call Run_Device_Info.cmd





echo Processing cue files
::  ***********************************************************************************
::  ************  CUES ARE DEFINED HERE ***********************************************
::  ***********************************************************************************


call Run_Cues.cmd

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

echo on


:DoCue
:: argument is the cue subscript number
set tempCueNum=%~1

:: get the full file name
call set myTempCuefile=!cue[%tempCueNum%].file!.!myFileExtension!

:: echo cue file is %myTempCueFile%


IF EXIST %myTempCueFile% (

	for /F "delims=*" %%a in (%myTempCueFile%) do (
		for /F "tokens=1* delims=^" %%w in ("%%a") do (
			set myTempIP=!IP.%%w!
			set myTempPort=!Port.%%w!



::			echo sendosc !myTempIP! !myTempPort! %%x
			call sendosc !myTempIP! !myTempPort! %%x		
)
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







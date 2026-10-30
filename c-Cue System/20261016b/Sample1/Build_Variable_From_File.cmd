:: If you build a cue file in excel via then need to add cue content variabl;es here form the cue file export in unicode format
::  First set the file name to read in...then process the line.  Use these in VARIABLEFROMFILE commands
:: 
:: below, use
:: 	set "cleaned_line=!line:"=!"
:: if you did an excel savwe as to text because it has quoter marks that need to be removed.
:: If you copies and pasted the export content from excel into notepad the quotes are not present so use:
::  	set "cleaned_line=!line!"
:: because it is a bit faster because stipping quotes is not needed

::  repeat this set of code for each file you want processed, but change the file name and the target of the goto and the label after the code to match 
::  as somethign new...to prevent duplicating other names already in use, jsut increment the number at the end or modify something at the end of the label


:: xxxxxxxxxxxxxxxxxxxxxxxxxxxx
for /F "delims=" %%a in ('type VariableCueTextSample.txt') do (
  	set "line=%%a"
	if !line!=="" goto :CompletedVariableFile1
::	set "cleaned_line=!line:"=!"
	set "cleaned_line=!line!"
        !cleaned_line!	
)
:CompletedVariableFile1
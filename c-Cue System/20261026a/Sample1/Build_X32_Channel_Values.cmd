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

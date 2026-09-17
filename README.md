September 17 2026 B ADDENDA Added for a new BUILD cmd script for new WING CUE MUTE handling commands:



WING CUES



You can now build cues for WING that include these commands (much like SETLATESTDCA and SETTRACKTOLATESTDCA):

Build2v013.cmd now includes the support for this command set:





:: SETLATESTMUTEtoMUTE 

:: sets the SETTOLATESTMUTEVALUE to MUTE



:: SETLATESTMUTEtoUNMUTE

:: sets the SETTOLATESTMUTEVALUE to UNMUTE



:: SETTRACKTOLATESTMUTE

:: sets the specified track to the latest specified SETLATESTMUTE designation

:: SETTRACKTOLATESTMUTE|myTrackVar's name|



This could be handy if you want to use  the SETLATESTDCA and SETTRACKTOLATESTDCA for major cues that take time to set up and then

use SETLATESTMUTEtoMUTE, SETLATESTMUTEtoUNMUTE and SETTRACKTOLATESTMUTE 

for quicker commands after your DCAs are set up.





Cue Sample content:



WING1|SETLATESTMUTEtoMUTE|

WING1|SETTRACKTOLATESTMUTE  | w1cGabriel   | # Eric

WING1|SETTRACKTOLATESTMUTE  | w1cKeith     | # Grimsby

WING1|SETTRACKTOLATESTMUTE  | w1cChadly    | # Sebastian



WING1|SETLATESTMUTEtoUNMUTE|

WING1|SETTRACKTOLATESTMUTE  | w1cGabriel   | # Eric

WING1|SETTRACKTOLATESTMUTE  | w1cKeith     | # Grimsby

WING1|SETTRACKTOLATESTMUTE  | w1cChadly    | # Sebastian



WING1|SETLATESTMUTEtoMUTE|

WING1|SETTRACKTOLATESTMUTE  | w1cGabriel   | # Eric

WING1|SETTRACKTOLATESTMUTE  | w1cKeith     | # Grimsby

WING1|SETTRACKTOLATESTMUTE  | w1cChadly    | # Sebastian







September 17 2026

Now cues for mixed targets reside in the same cue files.  This is now VERSION 2 of the CUE system.

The documentation for the CUE SYSTEM is now separate form the rest for VERSION 2.  Specifically new:

•	WING now includes the ability to change track color when muting.

•	Cue files now include a target IP and Port for each OSC command allowing multiple devices to be impacted by a single cue file (1 or more WINGS + 1 or more X32s + 1 or more REAPERs + 1 or more of anything using OSC via passthrough commands.



The 2 WING mixer has its own folder for tooling.





May 27 2026
Added to WING Cue commands:  TRACK\_GATE\_ON, TRACK\_GATE\_OFF, TRACK\_EQ\_ON, TRACK\_EQ\_OFF, TRACK\_DYN\_ON, TRACK\_DYN\_OFF, TRACK\_PREINS\_ON, TRACK\_PREINS\_OFF, TRACK\_POSTINS\_ON, TRACK\_POSTINS\_OFF



May 15 2026
Now each piece of the system has its own folder into which the latest items will be placed.



May 8 2026 - added a new Mixing Station config file for the WINGs

v20260423a is the latest release!

Now is for 2 WING racks and 1 X32 and added a SOLO Mixing Station configuration tool as well as mixing station configs for the WING racks.



v202601114a

This tool is also described at WorkWebs.com

Cue management tools are incldued for building and running cues using OSC to control one or more instance of REAPER,
X/M32, Behringer Wing systems.

Cues are text files using simple syntax.

Each Release has its own ZIP file in the repository.

Each release incldues an example use of the tools...either using REAPER, X/M32, WING or a combination of these.

The CUE running script can run cues you can write for other OSC controlled solutions.

The Cue system only works on WIndows systems and is written in Cmd scripting to keep it safe and to eliminate the need to install programs.

The system includes Bitfocus Companion config that can be run on any web connected device with /tablet to manage cue execution via the Vicreo Listener.

Included are Open Stage Control configs for REAPER

Included are Mixing Station configs for WING and X32

Inlcuded are web scripts for REAPER to manage track muting and level adjustments

Each new release adds some functionality, but in recent releases old Cues work with new Cues...but the old scripts also still work.
Enjoy!

\*\*\* Use the 20250512 RELEASE content for REAPER mixing and Open Stage Control code and samples.

\*\*\* Use the 20260114 RELEASE content for mixing with X/M32 + WING and recording / playback from REAPER.



CHANGELOG:

Changes made in the 20260114a release (sample is for mixing in WING+X32 with REAPER recording), see the 20250512a release for the full REAPER mixing samples)

VB Matrix Coconut virtual Windows audio Driver to allow recording 128 inputs to REAPER and allowing playback for the same.

Routing and Samples for combining 2 x32s and 1 WING with the VB Matrix Coconut and REAPER combo.



Changes made in the 20250811a release:

Added Cue capabilities for the Behringer WING

Changes made in release 20250512a (SAMPLE is for REAPER recording and live flow)

Added Scripting Commands

REAPER

TRACKPAN|track|value| where value ranges from 0 (full left) to 1 (full right)
Controls Pan of the track

SELECT|myChan's Name|Channel Display Name|
Selects the track tied to the associated cue config name specified and optionally changes the displayed REAPER track name if a name is provided.

UNSELECT|myChan's Name|Channel Display Name|
UnSelects the track tied to the associated cue config name specified and optionally changes the displayed REAPER track name if a name is provided.

ACTIONs|action string|
This runs a REAPER action based on a string name. (ACTIONi also still remains in place for numerical actions.)

x/M32

SAVESCENE|number|name|notes|
Saves the current scene to the scene number specified (0-99) and gives it the “name” specified with the scene “notes” specified.  Place the name in quotes if it contains blanks, same for the notes.

SAVESNIPPET|number|name|
Saves a SNIPPET to the SNIPPETnumber specified (0-99) and gives it the “name” specified.  Place the name in quotes if it contains blanks.  Note that the snippet will only be saved it filters are already in place for the specified snippet slot, so be sure to really only use this to replace a snippet.

LOADSCENE|number|
Loads the SCENE that pre-exists in the slot number specified (0-99).

LOADSNIPPET|number|
Loads the SNIPPET that pre-exists in the slot number specified (0-99).

Complete new track and touch screen layout.

There are now about 500 tracks in the system, a slight increase, but overall the tracks are fairly generic (no special sections or pre-build section labels).

There are 2 sizes of fader tracks displayed.

There are 120 small faders (designed for general purpose tracks, fx’s, etc.).

There are 64 large faders (designed for buses or frequently accessed VCAs).

There are 48 level-only views (designed to be used for inputs).

There are 20 rotary tracks (designed to be used as VCAs, monitor mixes).

There are 21 button tracks (designed to be used as mute groups for example).

There are also a few text display area tracks (designed to present messages from cues in scripts or whatever is desired).

New Open Stage Control json file for all these tracks laid out across what would work on 2 HD touchscreens.

New REAPER OSC definitions file to eliminate plugin and plugin parameter information. Now, just use the touch screen to open the plugin UI and work form there.  This reduced a lot of load from the system in regards to plugin information.

You are now encouraged to creatively design your work space with REAPER routing.

You are also encouraged to add and remove overlays over unused screen areas and to select colors for used track overlays to help you distinguish sections that you have created.


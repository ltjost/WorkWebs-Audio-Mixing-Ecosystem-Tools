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

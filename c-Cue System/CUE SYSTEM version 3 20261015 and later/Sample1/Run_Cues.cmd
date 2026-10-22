:: set the cue subscript to the starting point to 0

set /a cuecount=0


::  FOR EACH CUE


set /a cuecount+=1
set cue[%cuecount%].cuename=10
set cue[%cuecount%].file=10
set cue[%cuecount%].cuedescr=mute them all and all out of DCAs
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=20
set cue[%cuecount%].file=20
set cue[%cuecount%].cuedescr=all in their dcas BUT DCAs Muted
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=30
set cue[%cuecount%].file=30
set cue[%cuecount%].cuedescr=mute them all and all out of DCAs AND DCA unmuted
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=40
set cue[%cuecount%].file=40
set cue[%cuecount%].cuedescr=start of show Ariel on AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=50
set cue[%cuecount%].file=50
set cue[%cuecount%].cuedescr=add eric AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=60
set cue[%cuecount%].file=60
set cue[%cuecount%].cuedescr=remove ariel eric add pilot sailors and OS e4
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=70
set cue[%cuecount%].file=70
set cue[%cuecount%].cuedescr=only eric grimsby pilot AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=80
set cue[%cuecount%].file=80
set cue[%cuecount%].cuedescr=only  grimsby pilot and add sailors and OS e4
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=100
set cue[%cuecount%].file=100
set cue[%cuecount%].cuedescr=add ariel eric AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=110
set cue[%cuecount%].file=110
set cue[%cuecount%].cuedescr=remove ariel pilot AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=115
set cue[%cuecount%].file=115
set cue[%cuecount%].cuedescr=SFX SPLASH 10
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=120
set cue[%cuecount%].file=120
set cue[%cuecount%].cuedescr=add ariel pilot AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=130
set cue[%cuecount%].file=130
set cue[%cuecount%].cuedescr=remove pilot AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=140
set cue[%cuecount%].file=140
set cue[%cuecount%].cuedescr=remove eric  add sailors e4
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=150
set cue[%cuecount%].file=150
set cue[%cuecount%].cuedescr=only ariel flounder AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=160
set cue[%cuecount%].file=160
set cue[%cuecount%].cuedescr=add scuttle AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=170
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=ALLOFF 170
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=180
set cue[%cuecount%].file=180
set cue[%cuecount%].cuedescr=add triton and sea creatures onstage e3Sea yes AM sinceonly jabbering AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=190
set cue[%cuecount%].file=190
set cue[%cuecount%].cuedescr=remove sea creatures add leeward windward sebastian AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=200
set cue[%cuecount%].file=200
set cue[%cuecount%].cuedescr=remove windward leeward AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=210
set cue[%cuecount%].file=210
set cue[%cuecount%].cuedescr=only daughters
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=250
set cue[%cuecount%].file=250
set cue[%cuecount%].cuedescr=add sebastian triton and remove AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=260
set cue[%cuecount%].file=AMIXXON
set cue[%cuecount%].cuedescr=quick cue just turn AM on
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=270
set cue[%cuecount%].file=270
set cue[%cuecount%].cuedescr=only triton sebastian aquate ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=280
set cue[%cuecount%].file=280
set cue[%cuecount%].cuedescr=remove aquata AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=290
set cue[%cuecount%].file=290
set cue[%cuecount%].cuedescr=add atina aquata adella AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=300
set cue[%cuecount%].file=300
set cue[%cuecount%].cuedescr=only triton ariel flounder AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=310
set cue[%cuecount%].file=310
set cue[%cuecount%].cuedescr=remove flounder AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=320
set cue[%cuecount%].file=320
set cue[%cuecount%].cuedescr=remove ariel add sebastian AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=330
set cue[%cuecount%].file=330
set cue[%cuecount%].cuedescr=remove sebastian AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=340
set cue[%cuecount%].file=340
set cue[%cuecount%].cuedescr=add sebastian AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=350
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=ALLOFF 250
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=360
set cue[%cuecount%].file=360
set cue[%cuecount%].cuedescr=add flotsam jetsam ursula 
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=370
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 370
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=380
set cue[%cuecount%].file=380
set cue[%cuecount%].cuedescr=add flounder ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=390
set cue[%cuecount%].file=390
set cue[%cuecount%].cuedescr=remove flounder AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=400
set cue[%cuecount%].file=400
set cue[%cuecount%].cuedescr=add sebastian AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=410
set cue[%cuecount%].file=410
set cue[%cuecount%].cuedescr=add eric grims sailors OS
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=420
set cue[%cuecount%].file=420
set cue[%cuecount%].cuedescr=remove sailors AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=430
set cue[%cuecount%].file=430
set cue[%cuecount%].cuedescr=add ariel scuttle AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=440
set cue[%cuecount%].file=440
set cue[%cuecount%].cuedescr=remove grimsby add flounder AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=450
set cue[%cuecount%].file=450
set cue[%cuecount%].cuedescr=remove flounder add pilot AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=455
set cue[%cuecount%].file=455
set cue[%cuecount%].cuedescr=SFX THUNDER 20
set cue[%cuecount%].afterpause=
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=456
set cue[%cuecount%].file=456
set cue[%cuecount%].cuedescr=SFX THUNDER 30
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=460
set cue[%cuecount%].file=460
set cue[%cuecount%].cuedescr=remove ariel add grimsby AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=470
set cue[%cuecount%].file=470
set cue[%cuecount%].cuedescr=add sisters ens3 os remove pilot
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=480
set cue[%cuecount%].file=480
set cue[%cuecount%].cuedescr=remove sisters only ariel scuttle AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=490
set cue[%cuecount%].file=490
set cue[%cuecount%].cuedescr=add grimsby AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=500
set cue[%cuecount%].file=500
set cue[%cuecount%].cuedescr=remove ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=510
set cue[%cuecount%].file=510
set cue[%cuecount%].cuedescr=remove scuttle add eric AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=520
set cue[%cuecount%].file=520
set cue[%cuecount%].cuedescr=remove eric grims add ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=530
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=alloff 530
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=540
set cue[%cuecount%].file=540
set cue[%cuecount%].cuedescr=add sisters AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=550
set cue[%cuecount%].file=AMIXXOFF
set cue[%cuecount%].cuedescr=QUICK CUE -AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=560
set cue[%cuecount%].file=AMIXXON
set cue[%cuecount%].cuedescr=QUICK CUE +AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=570
set cue[%cuecount%].file=AMIXXOFF
set cue[%cuecount%].cuedescr=QUICK CUE -AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=580
set cue[%cuecount%].file=580
set cue[%cuecount%].cuedescr=arista flounder with otehr sisters in ens2
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=590
set cue[%cuecount%].file=590
set cue[%cuecount%].cuedescr=move arista to ens2
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=600
set cue[%cuecount%].file=600
set cue[%cuecount%].cuedescr=add sebastian AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=610
set cue[%cuecount%].file=610
set cue[%cuecount%].cuedescr=remove flounder and andrina AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=620
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 620
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=630
set cue[%cuecount%].file=630
set cue[%cuecount%].cuedescr=only Eric AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=640
set cue[%cuecount%].file=640
set cue[%cuecount%].cuedescr=add grimsby AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=650
set cue[%cuecount%].file=650
set cue[%cuecount%].cuedescr=remove grimsby AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=660
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 660
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=670
set cue[%cuecount%].file=670
set cue[%cuecount%].cuedescr=add sebastian ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=680
set cue[%cuecount%].file=680
set cue[%cuecount%].cuedescr=remove ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=690
set cue[%cuecount%].file=690
set cue[%cuecount%].cuedescr=AADD OS AND CREATURES
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=710
set cue[%cuecount%].file=710
set cue[%cuecount%].cuedescr=only sebastian triton AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=720
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=ALL OFF 720
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=730
set cue[%cuecount%].file=730
set cue[%cuecount%].cuedescr=add ariel triton flounder aquate AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=740
set cue[%cuecount%].file=740
set cue[%cuecount%].cuedescr=remove aquate flounder AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=745
set cue[%cuecount%].file=745
set cue[%cuecount%].cuedescr=SFX EXPLODE 40
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call


set /a cuecount+=1
set cue[%cuecount%].cuename=750
set cue[%cuecount%].file=750
set cue[%cuecount%].cuedescr=only sebastian ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=760
set cue[%cuecount%].file=760
set cue[%cuecount%].cuedescr=remove sebastian AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=770
set cue[%cuecount%].file=770
set cue[%cuecount%].cuedescr=add flotsam jetsam AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=780
set cue[%cuecount%].file=780
set cue[%cuecount%].cuedescr=add flounder remove ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=790
set cue[%cuecount%].file=790
set cue[%cuecount%].cuedescr=remove flotsam jetsam AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=800
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 800
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=810
set cue[%cuecount%].file=810
set cue[%cuecount%].cuedescr=add ursula flotsam jetsam ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=820
set cue[%cuecount%].file=820
set cue[%cuecount%].cuedescr=remove  flotsam jetsam AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=830
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 830 INTERMISSION
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=840
set cue[%cuecount%].file=840
set cue[%cuecount%].cuedescr=add scuttle sebastian flounder AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=850
set cue[%cuecount%].file=850
set cue[%cuecount%].cuedescr=remove sebastian and flounder AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=860
set cue[%cuecount%].file=860
set cue[%cuecount%].cuedescr=ADD sebastian and GULLS PLUS OFFSTAGE
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=870
set cue[%cuecount%].file=870
set cue[%cuecount%].cuedescr=only eric AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=880
set cue[%cuecount%].file=880
set cue[%cuecount%].cuedescr=add scuttle sebastian remove eric AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=890
set cue[%cuecount%].file=890
set cue[%cuecount%].cuedescr=remove sebastian  
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=900
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 900 
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=910
set cue[%cuecount%].file=910
set cue[%cuecount%].cuedescr=add windward triton aquatte AM 
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=920
set cue[%cuecount%].file=920
set cue[%cuecount%].cuedescr=remove windward add allana AM 
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=930
set cue[%cuecount%].file=930
set cue[%cuecount%].cuedescr=remove allana aquate AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=940
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 940
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=950
set cue[%cuecount%].file=950
set cue[%cuecount%].cuedescr=add grimsby and main rebecca AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=960
set cue[%cuecount%].file=960
set cue[%cuecount%].cuedescr=only ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=970
set cue[%cuecount%].file=970
set cue[%cuecount%].cuedescr=add maids grimsby AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=980
set cue[%cuecount%].file=980
set cue[%cuecount%].cuedescr=only ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call


set /a cuecount+=1
set cue[%cuecount%].cuename=984
set cue[%cuecount%].file=984
set cue[%cuecount%].cuedescr=only ariel plus eric AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=985
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 985
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=990
set cue[%cuecount%].file=990
set cue[%cuecount%].cuedescr=add chef louis AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1000
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 1000
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1010
set cue[%cuecount%].file=1010
set cue[%cuecount%].cuedescr=only grimsby and eric AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1020
set cue[%cuecount%].file=1020
set cue[%cuecount%].cuedescr=remove grimsby and eric add chefLouis AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1030
set cue[%cuecount%].file=1030
set cue[%cuecount%].cuedescr=add chefs OSjen e1
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1060
set cue[%cuecount%].file=1060
set cue[%cuecount%].cuedescr=only Chef Louis AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1070
set cue[%cuecount%].file=1070
set cue[%cuecount%].cuedescr=remove Chef Louis add eric AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1075
set cue[%cuecount%].file=1075
set cue[%cuecount%].cuedescr=SFX AH AHAHAH 50
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call


set /a cuecount+=1
set cue[%cuecount%].cuename=1080
set cue[%cuecount%].file=1080
set cue[%cuecount%].cuedescr=only sebastian AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call


set /a cuecount+=1
set cue[%cuecount%].cuename=1085
set cue[%cuecount%].file=QUICKALLOFF
set cue[%cuecount%].cuedescr=quick all off 1085
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1090
set cue[%cuecount%].file=1090
set cue[%cuecount%].cuedescr=only flotdsam jetsam ursula AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1100
set cue[%cuecount%].file=AMIXXOFF
set cue[%cuecount%].cuedescr=auto mix x off Quick Cue 1100
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1110
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 1100
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1120
set cue[%cuecount%].file=1120
set cue[%cuecount%].cuedescr=add eric scuttle sebastian AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1130
set cue[%cuecount%].file=1130
set cue[%cuecount%].cuedescr=remove eric AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call


set /a cuecount+=1
set cue[%cuecount%].cuename=1140
set cue[%cuecount%].file=1140
set cue[%cuecount%].cuedescr=remove scuttle add animals and OS
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1150
set cue[%cuecount%].file=1150
set cue[%cuecount%].cuedescr=separate out scuttle and eric 
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1160
set cue[%cuecount%].file=1160
set cue[%cuecount%].cuedescr=QUICK CUE remove eric scuttle add ursula
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1170
set cue[%cuecount%].file=1170
set cue[%cuecount%].cuedescr=QUICK CUE only ursula eric scuttle AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call


set /a cuecount+=1
set cue[%cuecount%].cuename=1180
set cue[%cuecount%].file=1180
set cue[%cuecount%].cuedescr=SFX SPARK 60 then remove ursula add sebastian AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1190
set cue[%cuecount%].file=1190
set cue[%cuecount%].cuedescr=only eric AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1200
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 1200
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1210
set cue[%cuecount%].file=1210
set cue[%cuecount%].cuedescr=only sebastian triton flounder
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1220
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 1220
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1230
set cue[%cuecount%].file=1230
set cue[%cuecount%].cuedescr=only grimsby AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1240
set cue[%cuecount%].file=1240
set cue[%cuecount%].cuedescr=remove grimsby add ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1250
set cue[%cuecount%].file=1250
set cue[%cuecount%].cuedescr=add eric AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1260
set cue[%cuecount%].file=1260
set cue[%cuecount%].cuedescr=add sebastian AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1270
set cue[%cuecount%].file=1270
set cue[%cuecount%].cuedescr=add triton 
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1280
set cue[%cuecount%].file=AMIXXOFF
set cue[%cuecount%].cuedescr=QUICK CUE remove automix x
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1290
set cue[%cuecount%].file=AMIXXON
set cue[%cuecount%].cuedescr=QUICK CUE add automix x
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1300
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 1300
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1310
set cue[%cuecount%].file=1310
set cue[%cuecount%].cuedescr=add grimsby AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1320
set cue[%cuecount%].file=1320
set cue[%cuecount%].cuedescr=add princess5 AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1330
set cue[%cuecount%].file=1330
set cue[%cuecount%].cuedescr=add eric p2 p4 remove grimsby AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1340
set cue[%cuecount%].file=1340
set cue[%cuecount%].cuedescr=add p1 p3 p6 AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1360
set cue[%cuecount%].file=1360
set cue[%cuecount%].cuedescr=add grimsby AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1370
set cue[%cuecount%].file=1370
set cue[%cuecount%].cuedescr=remove p1-6 AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call


set /a cuecount+=1
set cue[%cuecount%].cuename=1375
set cue[%cuecount%].file=1375
set cue[%cuecount%].cuedescr=SFX AH AHHHHH 80
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1380
set cue[%cuecount%].file=1380
set cue[%cuecount%].cuedescr=add ursula  AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1410
set cue[%cuecount%].file=1410
set cue[%cuecount%].cuedescr=only ursula AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1415
set cue[%cuecount%].file=QUICKALLOFF
set cue[%cuecount%].cuedescr=quick all off 1415
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call


set /a cuecount+=1
set cue[%cuecount%].cuename=1416
set cue[%cuecount%].file=1416
set cue[%cuecount%].cuedescr=only ursula flotsam jetsam AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1420
set cue[%cuecount%].file=1420
set cue[%cuecount%].cuedescr=remove flotsam jetsam add triton AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1425
set cue[%cuecount%].file=1425
set cue[%cuecount%].cuedescr=addd flotsam jetsam AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1430
set cue[%cuecount%].file=1430
set cue[%cuecount%].cuedescr=add ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1440
set cue[%cuecount%].file=1440
set cue[%cuecount%].cuedescr=remove flot jet ursula AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1450
set cue[%cuecount%].file=1450
set cue[%cuecount%].cuedescr=add flounder and SISTERS OS MICS ahs no AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1460
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=all off 1460
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1470
set cue[%cuecount%].file=1470
set cue[%cuecount%].cuedescr=only eric grimsby ariel AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1480
set cue[%cuecount%].file=1480
set cue[%cuecount%].cuedescr=add triton AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1490
set cue[%cuecount%].file=1490
set cue[%cuecount%].cuedescr=only eric triton AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1500
set cue[%cuecount%].file=1500
set cue[%cuecount%].cuedescr=remove eric add ariel grimsby AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1510
set cue[%cuecount%].file=1510
set cue[%cuecount%].cuedescr=remove ariel  AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1520
set cue[%cuecount%].file=1520
set cue[%cuecount%].cuedescr=add ariel eric  AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1530
set cue[%cuecount%].file=1530
set cue[%cuecount%].cuedescr=remove triton  AM
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1540
set cue[%cuecount%].file=1540
set cue[%cuecount%].cuedescr=eric ariel in main group then ADD ENS as all mics but not OS but include individual mics
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

set /a cuecount+=1
set cue[%cuecount%].cuename=1550
set cue[%cuecount%].file=ALLOFF
set cue[%cuecount%].cuedescr=ALL OFF END OF SHOW 1550
set cue[%cuecount%].afterpause=
set cue[%cuecount%].follow=
set cue[%cuecount%].execute=call

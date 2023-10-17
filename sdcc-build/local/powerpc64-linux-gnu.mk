# Debian GNU/Linux on Power9
MAKEJOBFLAGS = -j 80
TARGETOS = powerpc64-linux-gnu
HOSTOS = powerpc64-linux-gnu

TARGETCC = cc
TARGETCXX = c++

# local includes and libraries
TARGETCXXFLAGS = "-O2 -I/usr/local/include"
TARGETCFLAGS = "-O2 -I/usr/local/include"
TARGETCPPFLAGS = "-I/usr/local/include"
TARGETLDFLAGS = "-L/usr/local/lib"

# This machine is powerful enough to do the full regression test every day.
CROSSREGTESTTARGETS = $(FULL_CROSSREGTESTTARGETS)
REGTESTTARGETS = $(FULL_REGTESTTARGETS)

# disable pic14 and pic16 (bug #3659)
SDCCCONFIGUREFLAGS = --disable-pic14-port --disable-pic16-port


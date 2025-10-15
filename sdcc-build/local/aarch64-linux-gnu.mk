# Debian GNU/Linux on aarch64
MAKEJOBFLAGS = -j 80
TARGETOS = aarch64-linux-gnu
HOSTOS = aarch64-linux-gnu

TARGETCC = cc --std=gnu17
TARGETCXX = c++

# local includes and libraries
#TARGETCXXFLAGS = "-O2 -I/usr/local/include"
#TARGETCFLAGS = "-O2 -I/usr/local/include"
#TARGETCPPFLAGS = "-I/usr/local/include"
#TARGETLDFLAGS = "-L/usr/local/lib"

# This machine is powerful enough to do a full regression test every day.
CROSSREGTESTTARGETS = $(FULL_CROSSREGTESTTARGETS)
REGTESTTARGETS = $(FULL_REGTESTTARGETS)


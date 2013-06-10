_CXXRT?=/usr/lib
_BOOST?=/usr/local
GCCVER?=


IBOOST?=$(_BOOST)/include
LBOOST?=$(_BOOST)/lib
CXX=env CXX=g++$(GCCVER) gfilt
CXX=g++$(GCCVER)
CXXFLAGS=$(CXXSTD) $(CXXOPTFLAGS) $(CXXWFLAGS) -I$(IBOOST)
LDFLAGS=-Wl,-s -Wl,-L $(LCXXRT) -Wl,-rpath $(RCXXRT) -Wl,-L $(LBOOST)

CXXSTD=-pedantic -std=c++98
CXXOPTFLAGS=-O3
CXXWFLAGS=-Wall -Wextra -Werror -Wfatal-errors
LCXXRT=$(_CXXRT_$(GCCVER))
RCXXRT=$(_CXXRT_$(GCCVER))
LDLIBS=-lboost_filesystem -lboost_system

_CXXRT_=/usr/lib
_CXXRT_43=/usr/local/lib/gcc43
_CXXRT_44=/usr/local/lib/gcc44
_CXXRT_45=/usr/local/lib/gcc45

all: maildirs

clean:
	rm -f maildirs *.o

.PHONY: all clean

_CXXRT?=/usr/local/lib/gcc$(GCCVER)
_BOOST=/usr/local

IBOOST?=$(_BOOST)/include
CXX=g++$(GCCVER)
CXX=env CXX=g++$(GCCVER) gfilt
CXXFLAGS=$(CXXSTD) $(CXXOPTFLAGS) $(CXXWFLAGS) -I$(IBOOST)
LDFLAGS=-Wl,-s -Wl,-L $(LCXXRT) -Wl,-rpath $(RCXXRT) -Wl,-L $(_BOOST)/lib $(LIBS)

CXXSTD=
CXXOPTFLAGS=-O3
CXXWFLAGS=-Wall -Wextra -Werror -Wfatal-errors
LCXXRT=$(_CXXRT)
RCXXRT=$(_CXXRT)
LDLIBS=-lboost_filesystem

GCCVER?=44

all: maildirs

clean:
	rm -f maildirs *.o

.PHONY: all clean

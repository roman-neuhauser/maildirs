PREFIX ?=		/usr/local
BINDIR ?=		$(PREFIX)/bin
MANDIR ?=		$(PREFIX)/share/man
MAN1DIR ?=		$(MANDIR)/man1

GZIP ?=			gzip
INSTALL ?=		install
INSTALL_DATA ?=		$(INSTALL) -m 0644
INSTALL_DIR ?=		$(INSTALL) -m 0755 -d
INSTALL_PROGRAM ?=	$(INSTALL) -m 0755 -s

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

all: maildirs maildirs.1.gz

clean:
	rm -f maildirs maildirs.1.gz *.o

maildirs.1.gz: maildirs.1
	$(GZIP) < $< > $@

install:
	$(INSTALL_DIR) $(DESTDIR)$(BINDIR)
	$(INSTALL_DIR) $(DESTDIR)$(MAN1DIR)
	$(INSTALL_PROGRAM) maildirs $(DESTDIR)$(BINDIR)/maildirs
	$(INSTALL_DATA) maildirs.1.gz $(DESTDIR)$(MAN1DIR)/maildirs.1.gz


.PHONY: all
.PHONY: clean
.PHONY: install

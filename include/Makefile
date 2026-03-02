.POSIX:

include ../config.mk

HEADER1 = librevdep.h
HEADER2 = revdep/elf_cache.h \
	revdep/elf.h \
	revdep/pkg.h \
	revdep/revdep_context.h \
	revdep/revdep_engine.h \
	revdep/revdep_format.h \
	revdep/revdep_parallel.h \
	revdep/utility.h

ALL_HEADERS = $(HEADER1) $(HEADER2)

all:

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/include/revdep
	cp -f $(HEADER1) $(DESTDIR)$(PREFIX)/include
	cp -f $(HEADER2) $(DESTDIR)$(PREFIX)/include/revdep
	cd $(DESTDIR)$(PREFIX)/include && chmod 0644 $(ALL_HEADERS)

uninstall:
	cd $(DESTDIR)$(PREFIX)/include && rm -f $(ALL_HEADERS)

clean:

.PHONY: all install uninstall clean

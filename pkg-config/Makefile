.POSIX:

include ../config.mk

PC = librevdep.pc

all: $(PC)

$(PC): $(PC).in
	sed -e 's|@PREFIX@|$(PREFIX)|g' \
	    -e 's|@VERSION@|$(VERSION)|g' $(PC).in > $(PC)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/lib/pkgconfig
	cp -f $(PC) $(DESTDIR)$(PREFIX)/lib/pkgconfig
	chmod 0644 $(DESTDIR)$(PREFIX)/lib/pkgconfig/$(PC)

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/lib/pkgconfig/$(PC)

clean:
	rm -f $(PC)

.PHONY: all install uninstall clean

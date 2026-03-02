.POSIX:

include ../config.mk

MAN3 = librevdep.3 revdep_context.3 revdep_engine.3 revdep_format.3 revdep_parallel.3
MAN7 = librevdep.7 revdep_semantics.7

all: $(MAN3) $(MAN7)

$(MAN3) $(MAN7):
	scdoc < $@.scdoc > $@

install: all
	mkdir -p $(DESTDIR)$(MANPREFIX)/man3
	mkdir -p $(DESTDIR)$(MANPREFIX)/man7
	cp -f $(MAN3) $(DESTDIR)$(MANPREFIX)/man3
	cp -f $(MAN7) $(DESTDIR)$(MANPREFIX)/man7
	cd $(DESTDIR)$(MANPREFIX)/man3 && chmod 0644 $(MAN3)
	cd $(DESTDIR)$(MANPREFIX)/man7 && chmod 0644 $(MAN7)

uninstall:
	cd $(DESTDIR)$(MANPREFIX)/man3 && rm -f $(MAN3)
	cd $(DESTDIR)$(MANPREFIX)/man7 && rm -f $(MAN7)

clean:
	rm -f $(MAN3) $(MAN7)

.PHONY: all install uninstall clean

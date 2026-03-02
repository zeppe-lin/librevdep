.POSIX:

include config.mk

SUBDIRS = include man pkg-config src

all install uninstall clean:
	for subdir in $(SUBDIRS); do (cd $$subdir; $(MAKE) $@); done

release:
	git tag -a v$(VERSION) -m v$(VERSION)

.PHONY: all install uninstall clean release

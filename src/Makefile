.POSIX:
.SUFFIXES: .cpp .o

include ../config.mk
#include ../extra/flags-extra.mk
#include ../extra/flags-sanitizer.mk

LIB = $(NAME).a
OBJ = elf_cache.o elf.o pkg.o utility.o revdep_engine.o revdep_parallel.o revdep_format.o

all: $(LIB)

.cpp.o:
	$(CXX) -c $< $(CPPFLAGS) $(CXXFLAGS) -I../include

$(LIB): $(OBJ)
	$(AR) $(ARFLAGS) $@ $^

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/lib
	cp -f $(LIB) $(DESTDIR)$(PREFIX)/lib

uninstall:
	cd $(DESTDIR)$(PREFIX)/lib && rm -f $(LIB)

clean:
	rm -f $(OBJ) $(LIB)

.PHONY: all install uninstall clean

# =================================================================
# Project metadata
# =================================================================
NAME        = librevdep
VERSION     = 5.0

# =================================================================
# Installation paths
# =================================================================
PREFIX      = /usr
MANPREFIX   = $(PREFIX)/share/man
PKGCONFDIR  = $(PREFIX)/lib/pkgconfig

# =================================================================
# Compiler and archiver flags
# =================================================================
CPPFLAGS    = -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 \
              -DVERSION=\"$(VERSION)\"
CXXFLAGS    = -std=c++17 -pedantic -Wall -Wextra
LDFLAGS     = -lelf
ARFLAGS     = rcs

# =================================================================
# Toolchain
# =================================================================
CXX         = c++
AR          = ar
LD          = $(CXX)

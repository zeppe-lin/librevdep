public_inc = include_directories('../include')

librevdep = library(
  'revdep',
  [
    'elf_cache.cpp',
    'elf.cpp',
    'pkg.cpp',
    'revdep_engine.cpp',
    'revdep_format.cpp',
    'revdep_parallel.cpp',
    'utility.cpp',
  ],
  include_directories: [public_inc],
  dependencies: [libelf_dep],
  install: true,
  version: meson.project_version(),
  soversion: '5',
)

install_headers(
  '../include/librevdep/elf_cache.h',
  '../include/librevdep/elf.h',
  '../include/librevdep/librevdep.h',
  '../include/librevdep/pkg.h',
  '../include/librevdep/revdep_context.h',
  '../include/librevdep/revdep_engine.h',
  '../include/librevdep/revdep_format.h',
  '../include/librevdep/revdep_parallel.h',
  '../include/librevdep/utility.h',
)

pkgconf.generate(
  librevdep,
  name: 'librevdep',
  filebase: 'librevdep',
  description: 'Reverse dependency auditing library',
  subdirs: 'librevdep',
  requires_private: ['libelf'],
)

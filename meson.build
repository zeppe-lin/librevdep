project(
  'librevdep',
  'cpp',
  version: '5.1.2',
  meson_version: '>=1.2.0',
  default_options: [
    'cpp_std=c++17',
    'warning_level=3',
    'default_library=both',
    'b_ndebug=if-release',
    'b_lto=false',
  ],
)

want_static = get_option('link_mode') == 'static'

if want_static and get_option('default_library') == 'both'
  error(
    'link_mode=static is incompatible with default_library=both. ' +
    'Building a shared library requires shared (or PIC) dependencies. ' +
    'Use -Ddefault_library=static or -Ddefault_library=shared.'
  )
endif

libelf_dep = dependency(
  'libelf',
  required: true,
  static: want_static,
)

pkgconf = import('pkgconfig')

subdir('src')
subdir('man')

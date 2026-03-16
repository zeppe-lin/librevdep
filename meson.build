project(
  'librevdep',
  'cpp',
  version: '5.0',
  meson_version: '>=1.2.0',
  default_options: [
    'cpp_std=c++17',
    'warning_level=3',
    'default_library=both',
    'b_ndebug=if-release',
  ],
)

libelf_dep = dependency('libelf', required: true)
pkgconf = import('pkgconfig')

subdir('src')
subdir('man')

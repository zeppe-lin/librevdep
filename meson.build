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
  ],
)

libelf_dep = dependency(
  'libelf',
  required: true,
  static: get_option('prefer_static_deps'),
)

pkgconf = import('pkgconfig')

subdir('src')
subdir('man')

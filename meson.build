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
    'b_pie=true',
  ],
)

want_static = get_option('link_mode') == 'static'
if want_static
  add_project_link_arguments('-no-pie', language: 'cpp')
endif

libelf_dep = dependency(
  'libelf',
  required: true,
  static: want_static,
)

pkgconf = import('pkgconfig')

subdir('src')
subdir('man')

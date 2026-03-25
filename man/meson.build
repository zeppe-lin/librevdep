if get_option('build_man')
  scdoc = find_program('scdoc')

  foreach section, pages: {
    '3': [
      'librevdep',
      'revdep_context',
      'revdep_engine',
      'revdep_format',
      'revdep_parallel',
    ],
    '7': [
      'librevdep',
      'revdep_semantics',
    ],
  }
    foreach page: pages
      custom_target(
        page + '.' + section,
        input: page + '.' + section + '.scdoc',
        output: page + '.' + section,
        command: [scdoc],
        feed: true,
        capture: true,
        install: true,
        install_dir: get_option('mandir') / ('man' + section),
        install_tag: 'man',
      )
    endforeach
  endforeach
endif

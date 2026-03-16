OVERVIEW
========

`librevdep` is a reusable C++17 library for auditing installed ELF
objects and reporting unresolved shared-library dependencies.

It models dynamic loader search semantics relevant to static audit:
`DT_NEEDED`, `RUNPATH`, `RPATH`, and configurable search directories.
Findings are reported per file and may be aggregated per package by
the embedding application.

The library is structured for reuse:
- clear separation of audit engine, context, ELF parsing, formatting,
  and optional parallel scheduling
- no built-in package manager policy (*FIXME: not yet*)
- no built-in CLI I/O contract (*FIXME: CLI storytelling still leaks*)
- sink-based reporting for incremental consumptions by callers

`librevdep` originated from the `revdep` work previously coupled to
the CLI utility.
The command-line frontend now lives in a separate project:

https://github.com/zeppe-lin/revdep

This library lineage ultimately traces back to the CRUX `revdep`
implementation from `prt-utils` (fork point: `41dfcb6`, Thu Oct 15
2020), but has since been substantially refactored.

Major differences from the original CRUX implementation include:
- extracted reusable code into C++17 library
- separation of engine, context, formatting, and parallel scheduler
- optional parallel audit support
- broader ELF machine coverage (powerpc{,64}, loongarch{,64}, RISC-V)
- API documentation and library manual pages in `scdoc(5)` format

See the git history for detailed changes.

Original sources:

https://git.crux.nu/tools/prt-utils.git

---

ARCHITECTURE
============

The library is layered as follows:

Engine (`revdep_engine`)  
Audits ELF objects and emits structured findings.

Context (`revdep_context`)  
Holds configuration and shared state, including ELF cache.

ELF layer (`elf`, `elf_cache`)  
Parses ELF objects and performs loader-like resolution.

Formatting (`revdep_format`)  
Converts findings into stable textual representations.

Parallel scheduler (`revdep_parallel`)  
Optional concurrency layer for large audits.

Umbrella header (`librevdep.h`)  
Pulls in the public API for embedders.

`librevdep` is intended to provide facts and resolution results.
Policy, package-database interpretations, presentation style, and CLI
storytelling belong to the embedding application.

---

NON-GOALS
=========

`librevdep` is not a dynamic loader implementation.

Specifically:

- It does not use or parse `/etc/ld.so.cache`.
- It does not implement full glibc `ld.so` behavior.
- It does not execute binaries.
- It does not resolve `dlopen(3)` at runtime.
- It does not validate symbol-level resolution.
- It does not perform ABI compatibility analysis.

The library focuses strictly on static `DT_NEEDED` dependency
resolution using documented search rules (see `revdep_semantics(7)`).

---

EMBEDDING librevdep
===================

`librevdep` provides a C++ API for programmatic audits.

Minimal example:

```cpp
#include <librevdep/librevdep.h>
#include <iostream>

int main() {
    RevdepConfig cfg;
    cfg.searchDirs = {"/lib", "/usr/lib"};

    RevdepContext ctx(cfg);

    auto sink = [](const RevdepFinding& f) {
        std::cout << RevdepFormatFinding(f) << "\n";
    };

    Package pkg;
    pkg.name = "example";
    pkg.files = {"/usr/bin/example"};

    RevdepAuditPackage(pkg, ctx, sink);
}
```

The engine is sink-based: findings are delivered incrementally
via a callback.
The library itself does not impose CLI output or package manager
policy.

Parallel scheduling is available via
`RevdepAuditWorkItemsParallel()`; see `revdep_parallel(3)`.

---

API AND ABI STABILITY
=====================

The `librevdep` API is intended to remain source-stable within major
version.

ABI stability is **not** guaranteed across major releases.

Consumers are encouraged to:
- link dynamically when possible
- rebuild against new major releases
- consult `librevdep(3)` for authoritative API documentation

---

REQUIREMENTS
============

Build-time
----------

- C++17 compiler
- Meson
- Ninja
- `elfutils` (`libelf`)
- `scdoc(1)` to generate manual pages (if manpage build is enabled)
- `pkg-config(1)` for dependency discovery

Runtime
-------

- ELF-based system
- package/file inventory supplied by the embedded application
  (*FIXME: Package database in expected format is expected now*)

`librevdep` itself does not require a specific package manager, but
many embedding use-cases will provide package/file ownership data from
an external database.

---

INSTALLATION
============

Configure and build with Meson:

```sh
meson setup build \
    --buildtype=plain \
    --wrap-mode=nodownload

ninja -C build
```

Install:

```sh
DESTDIR="$PKG" ninja -C build install
```

Common options:

```sh
meson setup build \
    --prefix=/usr \
    -D build_man=true \
    -D b_lto=false
```

Use `meson configure build` to inspect available options.

---

DEFAULT PATHS
=============

Some runtime defaults (*FIXME: like package database, yeah*) are
compiled in at build time.

These defaults are intended to be removed.

---

DOCUMENTATION
=============

Manual pages are provided in `/man` and installed under the system
manual hierarchy.

Key entry points:

- `librevdep(3)` - public API overview
- `librevdep(7)` - library overview
- `revdep_context(3)` - context and configuration
- `revdep_engine(3)` - audit engine
- `revdep_format(3)` - formatting helpers
- `revdep_parallel(3)` - optional parallel scheduler
- `revdep_semantics(7)` - resolver rules

The `revdep(1)` CLI and its user-facing manuals now live in the
separate `revdep` repository.

---

LICENSE
=======

`librevdep` is licensed under the
[GNU General Public License v3 or later](https://gnu.org/licenses/gpl.html).

See `COPYING` for license terms and `COPYRIGHT` for notices.

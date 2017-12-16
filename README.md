# Concat-preter
---

concatenative language consisting of 
- 2-phase interpreter
- optimising self-hosting compiler
- vm
- standalone object system


## Dependencies

* One of:
 * a C11   C   compiler and `libc`   ( >= ISO/IEC C99   ) (Clang, GCC, not MSVC)
 * a C++14 C++ compiler and `libc++` ( >= ISO/IEC C++98 ) (MSVC will suffice)

  to which `cc` or `c++` is symlinked, respectively


* GNU-compatible `make`
* GNU `coreutils` (`rm`, `basename`, `pwd`...)
* a vaguely POSIX conformant shell (`bash`, `sh`, `ksh93`...)
* for `build.bash` to work:
  * GNU Bash
  * Python3


The `mem` target requires GCC or Clang's AddressSanitizer, and if you want line numbers in the output, `/usr/bin/llvm-symbolizer` to be installed and symlinked to `/usr/bin/llvm-symbolizer-3.8`.

On Debian-likes, you may be able to install the needed tools using

```bash
apt-get install build-essential bash coreutils make python3 clang llvm llvm-3.8*
```

or so, or a simliar with your favourite package manager.

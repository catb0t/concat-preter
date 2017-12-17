-- name of the entire codebase
workspace "concat-preter"
  -- what ways this project can be built (dbg is the default because it is first)
  configurations { "dbg", "dist" }
  -- written in C (this only matters in VS)
  language "C"

  flags { "fatalwarnings", "linktimeoptimization" }

  filter "action:gmake*"
    buildoptions {
      "-Wall", "-Wextra", "-Wfloat-equal", "-Winline", "-Wundef", "-Werror",
      "-fverbose-asm", "-Wint-to-pointer-cast", "-Wshadow", "-Wpointer-arith",
      "-Wcast-align", "-Wcast-qual", "-Wunreachable-code", "-Wstrict-overflow=5",
      "-Wwrite-strings", "-Wconversion", "--pedantic-errors",
      "-Wredundant-decls", "-Werror=maybe-uninitialized",
      "-Wbad-function-cast", "-Wmissing-declarations", "-Wmissing-parameter-type",
      "-Wmissing-prototypes", "-Wnested-externs", "-Wold-style-declaration",
      "-Wold-style-definition", "-Wstrict-prototypes", "-Wpointer-sign"
    }

  -- lua variable
  SOURCEDIR = "src"

  -- make an executable named prog
  project "interpreter"
    kind "consoleapp"

    files { "src/%{wks.name}.*" }

    links { "m", "fnv" }

    targetdir "bin/%{cfg.buildcfg}"

  -- make a lib named 'libhello.a'
  project "concat"
    kind "staticlib"

    libfiles = {}

    -- all the subdirectories of src/lib (unix only)
    for dir in io.popen("find src/lib/ -maxdepth 1 -type d | tail -1"):lines()
    do
      -- create src/lib/x/xcommon.c from x
      table.insert(libfiles, path.join(dir, path.getbasename(dir) .. "common.c"))
    end

    -- src/lib/*/*common.c is what we care about
    files(libfiles)

    -- libraries upon which this relies
    links { "m", "fnv" }

    -- where these files will go
    targetdir "bin/%{cfg.buildcfg}/lib"

  -- make the tests
  project "test"
    kind "consoleapp"

    files { "src/test/*.c" }

    links { "criterion", "fnv" }

    targetdir  "bin/%{cfg.buildcfg}/test"
    -- test_hello
    targetname "test_%{wks.name}"

  project "fnv"
    kind "staticlib"
    files { "deps/fnv-hash/hash_*.c" }

    links { "m" }

    targetdir "bin/%{cfg.buildcfg}/lib"

  project "clobber"
    kind "makefile"

    -- on windows, clean like this
    filter "system:not windows"
      cleancommands {
        "({RMDIR} bin obj *.make Makefile *.o -r 2>/dev/null; echo)"
      }

    -- otherwise, clean like this
    filter "system:windows"
      cleancommands {
        "{DELETE} *.make Makefile *.o",
        "{RMDIR} bin obj"
      }

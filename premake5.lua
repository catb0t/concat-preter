-- name of the entire codebase
workspace "concat-preter"
  -- what ways this project can be built (dbg is the default because it is first)
  configurations { "dbg", "dist" }
  -- written in C (this only matters in VS)
  language "C"

  toolset "gcc"

  flags { "fatalwarnings" }

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

  filter "configurations:dbg"
    optimize "Off"
    symbols "On"
    buildoptions { "-ggdb3", "-O0" }

  filter "configurations:dist"
    optimize "Full"
    symbols "Off"
    buildoptions { "-O3" }

  filter {}

  -- lua variable
  SOURCEDIR = "src"

  -- make an executable named prog
  project "interp"
    kind "consoleapp"

    files { "src/%{wks.name}.*" }

    links { "m", "fnv", "concat" }

    targetdir "bin/%{cfg.buildcfg}"

  -- make a lib named 'libhello.a'
  project "concat"
    kind "staticlib"

    local libfiles = {}

    -- all the subdirectories of src/lib (unix only)
    for dir in io.popen("find src/lib/ -maxdepth 1 -type d | tail -1"):lines()
    do
      -- create src/lib/x/xcommon.c from x
      table.insert(libfiles, path.join(dir, path.getbasename(dir) .. "common.c"))
    end

    -- src/lib/*/*common.c is what we care about
    files { "src/lib/*/*.c" }

    -- libraries upon which this relies
    links { "m", "fnv" }

    -- where these files will go
    targetdir "bin/%{cfg.buildcfg}/lib"

  -- make the tests
  project "test"
    kind "consoleapp"

    local new_test_file = "#include<criterion/criterion.h>\n#include\"../headers.h\"\n"

    for test_file in io.popen("find src/test/ -maxdepth 1 -type f -iregex '[^_]+.c'"):lines()
    do
      local new_lines = ""
      for _, line in next, string.explode(io.readfile(test_file), "\n")
      do
        if not string.startswith(line, "#include")
        then
          new_lines = new_lines .. line .. "\n"
        end
      end
      new_test_file = new_test_file .. new_lines .. "\n"
    end

    io.writefile(path.join(SOURCEDIR, "test", "_test.c"), new_test_file)

    files { "src/test/_test.c" }

    links { "criterion", "fnv", "m", "concat" }

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

    -- on not windows, clean like this
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

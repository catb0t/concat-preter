function os.scandir(pth, dironly)
  local m = os.matchstart(pth .. "/*")
  local dirs = {}

  while os.matchnext(m) do
    this = os.matchname(m)
    if not dironly or (dironly and not os.matchisfile(m)) then
      table.insert(dirs, this)
    end
  end

  os.matchdone(m)

  return dirs
end

-- name of the entire codebase
workspace "concat-preter"
  -- what ways this project can be built (dbg is the default because it is first)
  configurations { "dbg", "dist" }
  -- written in C (this only matters in VS)
  language "C"

  toolset "gcc"

  flags { "fatalwarnings", "linktimeoptimization" }

  filter { "action:gmake*", "toolset:gcc" }
    buildoptions {
      "-Wall", "-Wextra", "-Wfloat-equal", "-Winline", "-Wundef", "-Werror",
      "-fverbose-asm", "-Wint-to-pointer-cast", "-Wshadow", "-Wpointer-arith",
      "-Wcast-align", "-Wcast-qual", "-Wunreachable-code", "-Wstrict-overflow=5",
      "-Wwrite-strings", "-Wconversion", "--pedantic-errors",
      "-Wredundant-decls", "-Werror=maybe-uninitialized",
      "-Wmissing-declarations", "-Wmissing-parameter-type",
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

  -- make an executable
  project "interp"
    kind "consoleapp"

    files { "src/%{wks.name}.*" }

    links { "m", "fnv", "object", "stack" }

    targetdir "bin/%{cfg.buildcfg}"

  project "object"
    kind "staticlib"

    files { "src/lib/object/unify_object.c" }

    targetdir "bin/%{cfg.buildcfg}/lib"
    targetextension ".o"

  project "stack"
    kind "staticlib"

    files { "src/lib/stack/unify_stack.c" }

    targetdir "bin/%{cfg.buildcfg}/lib"
    targetextension ".o"

  -- make a lib named 'libconcat.a'
  project "concat"
    kind "staticlib"

    --local libfiles = {}

    ---- all the subdirectories of src/lib (unix only)
    --for dir in os.subdir(path.join("src", "lib"))
    --do
    --  -- create src/lib/x/xcommon.c from x
    --  table.insert(libfiles, path.join(dir, path.getbasename(dir) .. "common.c"))
    --end

    -- files { "src/lib/*/*.c" }

    -- libraries upon which this relies
    links { "m", "object", "stack", "fnv" }

    -- where these files will go
    targetdir "bin/%{cfg.buildcfg}/lib"
    targetextension ".a"

  -- make the tests
  project "test"
    kind "consoleapp"

    local new_test_file = "#include<criterion/criterion.h>\n#include\"../headers.h\"\n"

    for test_file in io.popen("find ./src/test/ -type f -iregex '.*t_[a-z]*\\.c$'"):lines()
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

    links { "criterion", "m", "stack", "fnv" }

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

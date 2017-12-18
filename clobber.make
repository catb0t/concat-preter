# GNU Make project makefile autogenerated by Premake

ifndef config
  config=dbg
endif

ifndef verbose
  SILENT = @
endif

.PHONY: clean prebuild prelink

ifeq ($(config),dbg)
  TARGETDIR = bin/dbg
  TARGET = $(TARGETDIR)/clobber
  define BUILDCMDS
  endef
  define CLEANCMDS
	@echo Running clean commands
	(rm -rf bin obj *.make Makefile *.o -r 2>/dev/null; echo)
  endef
endif

ifeq ($(config),dist)
  TARGETDIR = bin/dist
  TARGET = $(TARGETDIR)/clobber
  define BUILDCMDS
  endef
  define CLEANCMDS
	@echo Running clean commands
	(rm -rf bin obj *.make Makefile *.o -r 2>/dev/null; echo)
  endef
endif

$(TARGET):
	$(BUILDCMDS)

clean:
	$(CLEANCMDS)
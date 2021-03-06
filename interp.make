# GNU Make project makefile autogenerated by Premake

ifndef config
  config=dbg
endif

ifndef verbose
  SILENT = @
endif

.PHONY: clean prebuild prelink

ifeq ($(config),dbg)
  RESCOMP = windres
  TARGETDIR = bin/dbg
  TARGET = $(TARGETDIR)/interp
  OBJDIR = obj/dbg/interp
  DEFINES +=
  INCLUDES +=
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -Werror -flto -O0 -g -Wall -Wextra -Wfloat-equal -Winline -Wundef -Werror -fverbose-asm -Wint-to-pointer-cast -Wshadow -Wpointer-arith -Wcast-align -Wcast-qual -Wunreachable-code -Wstrict-overflow=5 -Wwrite-strings -Wconversion --pedantic-errors -Wredundant-decls -Werror=maybe-uninitialized -Wmissing-declarations -Wmissing-parameter-type -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wstrict-prototypes -Wpointer-sign -ggdb3 -O0
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -Werror -flto -O0 -g -Wall -Wextra -Wfloat-equal -Winline -Wundef -Werror -fverbose-asm -Wint-to-pointer-cast -Wshadow -Wpointer-arith -Wcast-align -Wcast-qual -Wunreachable-code -Wstrict-overflow=5 -Wwrite-strings -Wconversion --pedantic-errors -Wredundant-decls -Werror=maybe-uninitialized -Wmissing-declarations -Wmissing-parameter-type -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wstrict-prototypes -Wpointer-sign -ggdb3 -O0
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS += bin/dbg/lib/libfnv.a bin/dbg/lib/libobject.o bin/dbg/lib/libstack.o -lm
  LDDEPS += bin/dbg/lib/libfnv.a bin/dbg/lib/libobject.o bin/dbg/lib/libstack.o
  ALL_LDFLAGS += $(LDFLAGS) -flto
  LINKCMD = $(CC) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

ifeq ($(config),dist)
  RESCOMP = windres
  TARGETDIR = bin/dist
  TARGET = $(TARGETDIR)/interp
  OBJDIR = obj/dist/interp
  DEFINES +=
  INCLUDES +=
  FORCE_INCLUDE +=
  ALL_CPPFLAGS += $(CPPFLAGS) -MMD -MP $(DEFINES) $(INCLUDES)
  ALL_CFLAGS += $(CFLAGS) $(ALL_CPPFLAGS) -Werror -flto -O3 -Wall -Wextra -Wfloat-equal -Winline -Wundef -Werror -fverbose-asm -Wint-to-pointer-cast -Wshadow -Wpointer-arith -Wcast-align -Wcast-qual -Wunreachable-code -Wstrict-overflow=5 -Wwrite-strings -Wconversion --pedantic-errors -Wredundant-decls -Werror=maybe-uninitialized -Wmissing-declarations -Wmissing-parameter-type -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wstrict-prototypes -Wpointer-sign -O3 -fomit-frame-pointer
  ALL_CXXFLAGS += $(CXXFLAGS) $(ALL_CPPFLAGS) -Werror -flto -O3 -Wall -Wextra -Wfloat-equal -Winline -Wundef -Werror -fverbose-asm -Wint-to-pointer-cast -Wshadow -Wpointer-arith -Wcast-align -Wcast-qual -Wunreachable-code -Wstrict-overflow=5 -Wwrite-strings -Wconversion --pedantic-errors -Wredundant-decls -Werror=maybe-uninitialized -Wmissing-declarations -Wmissing-parameter-type -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-style-definition -Wstrict-prototypes -Wpointer-sign -O3 -fomit-frame-pointer
  ALL_RESFLAGS += $(RESFLAGS) $(DEFINES) $(INCLUDES)
  LIBS += bin/dist/lib/libfnv.a bin/dist/lib/libobject.o bin/dist/lib/libstack.o -lm
  LDDEPS += bin/dist/lib/libfnv.a bin/dist/lib/libobject.o bin/dist/lib/libstack.o
  ALL_LDFLAGS += $(LDFLAGS) -flto -s
  LINKCMD = $(CC) -o "$@" $(OBJECTS) $(RESOURCES) $(ALL_LDFLAGS) $(LIBS)
  define PREBUILDCMDS
  endef
  define PRELINKCMDS
  endef
  define POSTBUILDCMDS
  endef
all: prebuild prelink $(TARGET)
	@:

endif

OBJECTS := \
	$(OBJDIR)/concat-preter.o \

RESOURCES := \

CUSTOMFILES := \

SHELLTYPE := msdos
ifeq (,$(ComSpec)$(COMSPEC))
  SHELLTYPE := posix
endif
ifeq (/bin,$(findstring /bin,$(SHELL)))
  SHELLTYPE := posix
endif

$(TARGET): $(GCH) ${CUSTOMFILES} $(OBJECTS) $(LDDEPS) $(RESOURCES)
	@echo Linking interp
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(TARGETDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(TARGETDIR))
endif
	$(SILENT) $(LINKCMD)
	$(POSTBUILDCMDS)

clean:
	@echo Cleaning interp
ifeq (posix,$(SHELLTYPE))
	$(SILENT) rm -f  $(TARGET)
	$(SILENT) rm -rf $(OBJDIR)
else
	$(SILENT) if exist $(subst /,\\,$(TARGET)) del $(subst /,\\,$(TARGET))
	$(SILENT) if exist $(subst /,\\,$(OBJDIR)) rmdir /s /q $(subst /,\\,$(OBJDIR))
endif

prebuild:
	$(PREBUILDCMDS)

prelink:
	$(PRELINKCMDS)

ifneq (,$(PCH))
$(OBJECTS): $(GCH) $(PCH)
$(GCH): $(PCH)
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CC) -x c-header $(ALL_CFLAGS) -o "$@" -MF "$(@:%.gch=%.d)" -c "$<"
endif

$(OBJDIR)/concat-preter.o: src/concat-preter.c
	@echo $(notdir $<)
ifeq (posix,$(SHELLTYPE))
	$(SILENT) mkdir -p $(OBJDIR)
else
	$(SILENT) mkdir $(subst /,\\,$(OBJDIR))
endif
	$(SILENT) $(CC) $(ALL_CFLAGS) $(FORCE_INCLUDE) -o "$@" -MF "$(@:%.o=%.d)" -c "$<"

-include $(OBJECTS:%.o=%.d)
ifneq (,$(PCH))
  -include $(OBJDIR)/$(notdir $(PCH)).d
endif
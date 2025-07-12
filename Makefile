#--SETTINGS--

#Some options: native, windows, macos, linux-gnu
PLATFORM ?= native

#Some options: native, x86_64, i386, aarm64
ARCH ?= native

#Run the project immediately after export?
RUN = true

#The following are needed for linux only

#GlibC version to use. You should probably keep this at 2.41 unless it doesn't work.
LINUX_GLIBC_VERSION ?= 2.41 
#A search prefix is needed for the compiler to find all libraries. If you're on linux,
#you can get away with using /usr, else you should download a minimal linux installation and use that(it must have a usr folder).
LINUX_SEARCH_PREFIX ?= linux-usr-folder/

#--SCRIPT--

FLAGS := 

ifeq ($(RUN), true)
	FLAGS += run
endif

ifeq ($(PLATFORM), linux-gnu)
	FLAGS += -Dtarget=$(ARCH)-$(PLATFORM).$(LINUX_GLIBC_VERSION) --search-prefix $(LINUX_SEARCH_PREFIX)
else
	FLAGS += -Dtarget=$(ARCH)-$(PLATFORM)
endif

build:
	zig build $(FLAGS)
	
clean:
	rm -rf zig-out

.PHONY:

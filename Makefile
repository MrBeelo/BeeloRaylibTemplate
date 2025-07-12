#--SETTINGS--

#Some options: native, windows, macos, linux-gnu
PLATFORM ?= native

#Some options: native, x86_64, i386, aarm64
ARCH ?= native

#Run the project immediately after export?
RUN = true

#When exporting to linux, you may need to define the glibc version. Don't set this to true if not on linux!
INCLUDE_GLIBC_VERSION ?= false
GLIBC_VERSION ?= 2.41

#If you get an error that some libraries aren't found, set this to true and set a search prefix.
USE_SEARCH_PREFIX ?= false
SEARCH_PREFIX ?= /usr

#--SCRIPT--

FLAGS := 

ifeq ($(RUN), true)
	FLAGS += run
endif

ifeq ($(INCLUDE_GLIBC_VERSION), true)
	FLAGS += -Dtarget=$(ARCH)-$(PLATFORM).$(GLIBC_VERSION)
else
	FLAGS += -Dtarget=$(ARCH)-$(PLATFORM)
endif

ifeq ($(USE_SEARCH_PREFIX), true)
	FLAGS +=  --search-prefix $(SEARCH_PREFIX)
endif

build:
	zig build $(FLAGS)
	
clean:
	rm -rf zig-out

.PHONY:

#--SETTINGS--

#Defaults to C, change to c++ to use the C++ language.
TARGET_LANGUAGE ?= c
#Defaults to linux, change to win for Windows, osx for MacOS, or web for HTML5.
TARGET_PLATFORM ?= linux
#Defaults to x86_64, change to i386 (not for mac) or aarch64 (not for windows).
TARGET_ARCH ?= x86_64
#Defaults to raylib, change to blank for blank shell (used for web).
TARGET_SHELL ?= raylib
#GLibC version to use for linux (change in case 2.41 doesn't work).
GLIBC_VERSION ?= 2.41

#--SCRIPT--

SRC_DIR = src
BUILD_DIR = bin
RESOURCES_DIR = res
HEADERS_DIR = $(SRC_DIR)/headers
LIBRARIES_DIR = lib/linux
PROGRAM_NAME = BeeloRaylibTemplate
EXECUTABLE = $(BUILD_DIR)/$(PROGRAM_NAME)
CXX = zig cc
CXXFLAGS = -I$(HEADERS_DIR)
LDFLAGS = -L $(LIBRARIES_DIR) -lraylib
FILE_FORMAT = .c
TG_PLATFORM = linux

ifeq ($(TARGET_LANGUAGE), c)
    FILE_FORMAT = .c
    CXX = zig cc
endif

ifeq ($(TARGET_LANGUAGE), c++)
    FILE_FORMAT = .cpp
    CXX = zig c++
endif

ifeq ($(TARGET_PLATFORM), win)
	BUILD_DIR = bin/win
	LIBRARIES_DIR = lib/win
	TG_PLATFORM = windows-gnu
	CXXFLAGS += -DPLATFORM_DESKTOP
	LDFLAGS += -lkernel32 -luser32 -lgdi32 -lopengl32 -lwinmm
	EXECUTABLE = $(BUILD_DIR)/$(PROGRAM_NAME).exe
endif

ifeq ($(TARGET_PLATFORM), linux)
	BUILD_DIR = bin/linux
	LIBRARIES_DIR = lib/linux
	TG_PLATFORM = linux-gnu.$(GLIBC_VERSION)
	CXXFLAGS += -DPLATFORM_DESKTOP
	LDFLAGS += -lm -ldl -lpthread -lrt
	EXECUTABLE = $(BUILD_DIR)/$(PROGRAM_NAME)
endif

ifeq ($(TARGET_PLATFORM), osx)
	BUILD_DIR = bin/osx
	LIBRARIES_DIR = lib/osx
	TG_PLATFORM = macos
	CXXFLAGS += -DPLATFORM_DESKTOP
	LDFLAGS += -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo
	EXECUTABLE = $(BUILD_DIR)/$(PROGRAM_NAME)
endif

ifeq ($(TARGET_PLATFORM), web)
	BUILD_DIR = bin/web
	CXX = em++
	OBJ_DIR = obj/web
	LIBRARIES_DIR = lib/web
	EXECUTABLE = $(BUILD_DIR)/$(PROGRAM_NAME).html
	CXXFLAGS += -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2
	LDFLAGS += -s ASYNCIFY -s USE_GLFW=3 -s MIN_WEBGL_VERSION=2 -s MAX_WEBGL_VERSION=2 -s ENVIRONMENT=web --preload-file $(RESOURCES_DIR) -s TOTAL_MEMORY=64MB -s EXPORTED_RUNTIME_METHODS=HEAPF32
	
	ifeq ($(TARGET_SHELL), raylib)
		LDFLAGS += --shell-file res/assets/shell/raylib-shell.html
	endif

	ifeq ($(TARGET_SHELL), blank)
		LDFLAGS += --shell-file res/assets/shell/blank-shell.html
	endif
endif

rwildcard = $(foreach d,$(wildcard $1*),$(call rwildcard,$d/,$2) $(filter $(subst *,%,$2),$d))
SRC_FILES := $(call rwildcard, $(SRC_DIR)/, *$(FILE_FORMAT))

all: $(EXECUTABLE) copy-res

$(EXECUTABLE): $(SRC_FILES)
	@mkdir -p $(BUILD_DIR)
ifeq ($(TARGET_PLATFORM), web)
	$(CXX) $(SRC_FILES) $(LIBRARIES_DIR)/libraylib.a -o $@ $(LDFLAGS)
else
	$(CXX) -target $(TARGET_ARCH)-$(TG_PLATFORM) $(CXXFLAGS) $(LDFLAGS) $(SRC_FILES) -o $@ 
endif

copy-res:
	@mkdir -p $(BUILD_DIR)
	@cp -r $(RESOURCES_DIR) $(BUILD_DIR)

clean-this:
	rm -rf $(OBJ_DIR) $(BUILD_DIR)
	
clean:
	rm -rf obj bin
	
run:
	./$(EXECUTABLE)

.PHONY: all clean copy-assets

# Variables
SRC_DIR = src
OBJ_DIR = obj/linux
BUILD_DIR = bin
RESOURCES_DIR = res
HEADERS_DIR = $(SRC_DIR)/headers
LIBRARIES_DIR = lib/linux
LIBRARY = $(LIBRARIES_DIR)/libraylib.a
PROGRAM_NAME = BeeloRaylibTemplate
EXECUTABLE = $(BUILD_DIR)/$(PROGRAM_NAME)
CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++17 -I$(HEADERS_DIR)
LDFLAGS = -L $(LIBRARIES_DIR) -lraylib
FILE_FORMAT = .cpp

#Defaults to C++, change to c to use the C language.
TARGET_LANGUAGE ?= c
#Defaults to linux, change to win for Windows or web for HTML5.
TARGET_PLATFORM ?= linux

ifeq ($(TARGET_PLATFORM), win)
	BUILD_DIR = bin/win
	CXX = g++
	OBJ_DIR = obj/win
	LIBRARIES_DIR = lib/win
	LDFLAGS += -lopengl32 -lgdi32 -lwinmm
	EXECUTABLE = $(BUILD_DIR)/$(PROGRAM_NAME).exe
endif

ifeq ($(TARGET_PLATFORM), linux)
	BUILD_DIR = bin/linux
	CXX = g++
	OBJ_DIR = obj/linux
	LIBRARIES_DIR = lib/linux
	EXECUTABLE = $(BUILD_DIR)/$(PROGRAM_NAME)
endif

ifeq ($(TARGET_PLATFORM), osx)
	BUILD_DIR = bin/osx
	CXX = clang++
	OBJ_DIR = obj/osx
	#LIBRARIES_DIR = lib/osx
	EXECUTABLE = $(BUILD_DIR)/$(PROGRAM_NAME)
endif

ifeq ($(TARGET_PLATFORM), web)
	BUILD_DIR = bin/web
	CXX = em++
	OBJ_DIR = obj/web
	LIBRARIES_DIR = lib/web
	EXECUTABLE = $(BUILD_DIR)/$(PROGRAM_NAME).html
	CXXFLAGS += -DPLATFORM_WEB -DGRAPHICS_API_OPENGL_ES2
	LDFLAGS += -s ASYNCIFY -s USE_GLFW=3 -s MIN_WEBGL_VERSION=2 -s MAX_WEBGL_VERSION=2 -s ENVIRONMENT=web --preload-file $(RESOURCES_DIR) -s TOTAL_MEMORY=64MB --shell-file raylib-shell.html
endif

ifeq ($(TARGET_LANGUAGE), c)
    FILE_FORMAT = .c
endif

ifeq ($(TARGET_LANGUAGE), c++)
    FILE_FORMAT = .cpp
endif

# Find all .cpp files in the src directory
SRC_FILES = $(shell find $(SRC_DIR) -name '*$(FILE_FORMAT)')
OBJ_FILES = $(patsubst $(SRC_DIR)/%,$(OBJ_DIR)/%,$(SRC_FILES:$(FILE_FORMAT)=.o))


# Targets
all: $(EXECUTABLE) copy-res

# Compile the program
$(EXECUTABLE): $(OBJ_FILES)
	@mkdir -p $(BUILD_DIR)
	$(CXX) $(OBJ_FILES) $(LIBRARY) -o $@ $(LDFLAGS)

# Compile each .cpp file into an object file
$(OBJ_DIR)/%.o: $(SRC_DIR)/%$(FILE_FORMAT)
	@mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Copy res folder to the build directory
copy-res:
	@mkdir -p $(BUILD_DIR)
	@cp -r $(RESOURCES_DIR) $(BUILD_DIR)

clean-this:
	rm -rf $(OBJ_DIR) $(BUILD_DIR)
	
clean:
	rm -rf obj bin
	
run:
	./$(EXECUTABLE)

# Phony targets
.PHONY: all clean copy-assets

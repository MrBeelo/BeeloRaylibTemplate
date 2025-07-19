Simple raylib template for raylib 5.5
To clone: git clone --recurse-submodules https://github.com/MrBeelo/BeeloRaylibTemplate.git


--HOW TO USE--

1) Install dependencies. You need to install the zig compiler (emscripten for web).
Optionally, I've provided a makefile which can make cross-compiling a bit easier. 

2) Add an SDK. If cross-compiling for linux, macos, or emscripten (experimental), you will need to
add their corresponding SDKs, which you will need for their libraries/headers.

3) Set settings for the makefile if you are using it. You will need to set 2 settings:
The target architecture (x86_64/x86/aarch64/i386/etc.)
The target platform (native/windows/macos/linux-gnu/etc.)
If cross-compiling to Mac or Linux, you should also set some more settings related to the SDKs.
You can also set whether or not to immediately run the project after exporting.

4) Run zig build or make (if you use it). An executable should pop up in the zig-out/(platform) directory
if you're using make, or just zig-out if you're using zig build.


--FILE STRUCTURE--

1) raylib: A full copy of the newest raylib source for raylib 5.5, which is used to compile raylib.

2) res: Everything in the resources directory will be copied over to the final build of the game. 
It is meant for various types of assets(like textures, sounds, shaders, etc.) 
or for data (like savefiles, settings, etc.). Note that the resource directory is set to "res", so to load
a texture located at "res/textures/texture.png", you would call LoadTexture("textures/texture.png").

3) src: Every source file in the sources directory will be compiled for the executable. 
It should also include raylib.h (and optionally resource_dir.h if you're using it)
for raylib use, and of course a file with the main() function.

4) zig-out: This is where you will find the executable along with all of the copied resources. 
If you used the makefile, the executable will be located in a subdirectory with 
the same name of the platform you're compiling to.

--MAKEFILE COMMANDS--

1) make: This will build the game with the set setting and export it to the bin folder.

2) make clean: Will delete the zig-out directory.

3) make clean-this: Will delete the zig-out/(platform) directory.
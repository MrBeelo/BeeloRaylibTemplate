Simple raylib template for raylib 5.5


--HOW TO USE--

1) Install dependencies. You need to install the zig compiler (emscripten for web), and make to build the project.

2) Compile raylib. I've already compiled to Windows, Linux, and HTML5, 
though if you're on MacOS or the library files don't work, I've provided the full
raylib source in the raylibsrc directory for you to compile (you can delete raylibsrc when done).

3) Add the compiled library file to the correct directory. It should be:
lib/win for Windows
lib/osx for MacOS
lib/linux for Linux
lib/web for HTML5
(do this if you compiled your own library; you might need to replace my library files with yours).

4) Set settings for the makefile. You will need to set 3 settings:
The target language (C/C++)
The target platform (Windows/MacOS/Linux/HTML5)
The target shell (raylib/blank, use if building for web, else this will be ignored)

5) Run make. An executable should pop up in the bin directory (which you
can test by running make run) Note that if you're building for a desktop platform (Windows,
MacOS, Linux), your machine will have to be the same platform type. You can fix this by either doing
this on another machine or setting up a VM.


--FILE STRUCTURE--

1) lib: In the library directory, you should include the library files for raylib. It has 4 subdirectories:
win, osx, linux, web. The library should be a static type (.a). If you wish to change this, modify LIBRARY in the makefile.

2) raylibsrc: A full copy of the newest raylib source for raylib 5.5, which you can use to compile raylib if none of the
precompiled libraries work.

3) res: Everything in the resources directory will be copied over to the final build of the game. It is meant for various types of assets
(like textures, sounds, shaders, etc.) or for data (like savefiles, settings, etc.). Note that the resource directory is set to "res", so to load
a texture located at "res/textures/texture.png", you would call LoadTexture("textures/texture.png").

4) src: Every source file in the sources directory will be compiled for the executable. It should also include raylib.h (and optionally resource_dir.h)
for raylib use, and of course a file with the main() function.

5) bin: This is where you will find the executable along with all of the copied resources. It has 4 subdirectories:
win, osx, linux, web. If built for a desktop platform, running the command "make run" will automatically run the executable.

6) obj: This is where all of the object files will be generated. This is only used for compiling the game. It has 
4 subdirectories: win, osx, linux, web.


--MAKEFILE COMMANDS--

1) make: This will build the game with the set setting and export it to the bin folder.

2) make clean: Will delete the bin and obj directories.

3) make clean-this: Will delete the directories that the makefile is configured to export to
(if target platform is win, it will delete bin/win and obj/win).

4) make run: Will run the executable that the makefile is configured to export to
(if target platform is win and program name is "Test", it will run ./bin/win/Test.exe).

5) make copy-res: Will copy all of the resources to the configured build directory
(not needed as this is done automatically when you build the game).
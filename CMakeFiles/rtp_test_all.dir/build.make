# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test

# Include any dependencies generated for this target.
include CMakeFiles/rtp_test_all.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/rtp_test_all.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/rtp_test_all.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/rtp_test_all.dir/flags.make

CMakeFiles/rtp_test_all.dir/src/test.cpp.o: CMakeFiles/rtp_test_all.dir/flags.make
CMakeFiles/rtp_test_all.dir/src/test.cpp.o: src/test.cpp
CMakeFiles/rtp_test_all.dir/src/test.cpp.o: CMakeFiles/rtp_test_all.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/rtp_test_all.dir/src/test.cpp.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/rtp_test_all.dir/src/test.cpp.o -MF CMakeFiles/rtp_test_all.dir/src/test.cpp.o.d -o CMakeFiles/rtp_test_all.dir/src/test.cpp.o -c /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test/src/test.cpp

CMakeFiles/rtp_test_all.dir/src/test.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/rtp_test_all.dir/src/test.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test/src/test.cpp > CMakeFiles/rtp_test_all.dir/src/test.cpp.i

CMakeFiles/rtp_test_all.dir/src/test.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/rtp_test_all.dir/src/test.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test/src/test.cpp -o CMakeFiles/rtp_test_all.dir/src/test.cpp.s

# Object files for target rtp_test_all
rtp_test_all_OBJECTS = \
"CMakeFiles/rtp_test_all.dir/src/test.cpp.o"

# External object files for target rtp_test_all
rtp_test_all_EXTERNAL_OBJECTS =

rtp_test_all: CMakeFiles/rtp_test_all.dir/src/test.cpp.o
rtp_test_all: CMakeFiles/rtp_test_all.dir/build.make
rtp_test_all: librtpsender.a
rtp_test_all: librtpreceiver.a
rtp_test_all: lib/libgtest_main.a
rtp_test_all: librtpall.a
rtp_test_all: lib/libgtest.a
rtp_test_all: CMakeFiles/rtp_test_all.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable rtp_test_all"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/rtp_test_all.dir/link.txt --verbose=$(VERBOSE)
	/usr/bin/cmake -D TEST_TARGET=rtp_test_all -D TEST_EXECUTABLE=/home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test/rtp_test_all -D TEST_EXECUTOR= -D TEST_WORKING_DIR=/home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test -D TEST_EXTRA_ARGS= -D TEST_PROPERTIES= -D TEST_PREFIX= -D TEST_SUFFIX= -D TEST_FILTER= -D NO_PRETTY_TYPES=FALSE -D NO_PRETTY_VALUES=FALSE -D TEST_LIST=rtp_test_all_TESTS -D CTEST_FILE=/home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test/rtp_test_all[1]_tests.cmake -D TEST_DISCOVERY_TIMEOUT=5 -D TEST_XML_OUTPUT_DIR= -P /usr/share/cmake-3.22/Modules/GoogleTestAddTests.cmake

# Rule to build all files generated by this target.
CMakeFiles/rtp_test_all.dir/build: rtp_test_all
.PHONY : CMakeFiles/rtp_test_all.dir/build

CMakeFiles/rtp_test_all.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/rtp_test_all.dir/cmake_clean.cmake
.PHONY : CMakeFiles/rtp_test_all.dir/clean

CMakeFiles/rtp_test_all.dir/depend:
	cd /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test/CMakeFiles/rtp_test_all.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/rtp_test_all.dir/depend

# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Default target executed when no arguments are given to make.
default_target: all
.PHONY : default_target

# Allow only one "make -f Makefile2" at a time, but pass parallelism.
.NOTPARALLEL:

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

#=============================================================================
# Targets provided globally by CMake.

# Special rule for the target test
test:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running tests..."
	/usr/bin/ctest --force-new-ctest-process $(ARGS)
.PHONY : test

# Special rule for the target test
test/fast: test
.PHONY : test/fast

# Special rule for the target edit_cache
edit_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "No interactive CMake dialog available..."
	/usr/bin/cmake -E echo No\ interactive\ CMake\ dialog\ available.
.PHONY : edit_cache

# Special rule for the target edit_cache
edit_cache/fast: edit_cache
.PHONY : edit_cache/fast

# Special rule for the target rebuild_cache
rebuild_cache:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Running CMake to regenerate build system..."
	/usr/bin/cmake --regenerate-during-build -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR)
.PHONY : rebuild_cache

# Special rule for the target rebuild_cache
rebuild_cache/fast: rebuild_cache
.PHONY : rebuild_cache/fast

# Special rule for the target list_install_components
list_install_components:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Available install components are: \"Unspecified\""
.PHONY : list_install_components

# Special rule for the target list_install_components
list_install_components/fast: list_install_components
.PHONY : list_install_components/fast

# Special rule for the target install
install: preinstall
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Install the project..."
	/usr/bin/cmake -P cmake_install.cmake
.PHONY : install

# Special rule for the target install
install/fast: preinstall/fast
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Install the project..."
	/usr/bin/cmake -P cmake_install.cmake
.PHONY : install/fast

# Special rule for the target install/local
install/local: preinstall
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Installing only the local directory..."
	/usr/bin/cmake -DCMAKE_INSTALL_LOCAL_ONLY=1 -P cmake_install.cmake
.PHONY : install/local

# Special rule for the target install/local
install/local/fast: preinstall/fast
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Installing only the local directory..."
	/usr/bin/cmake -DCMAKE_INSTALL_LOCAL_ONLY=1 -P cmake_install.cmake
.PHONY : install/local/fast

# Special rule for the target install/strip
install/strip: preinstall
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Installing the project stripped..."
	/usr/bin/cmake -DCMAKE_INSTALL_DO_STRIP=1 -P cmake_install.cmake
.PHONY : install/strip

# Special rule for the target install/strip
install/strip/fast: preinstall/fast
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --cyan "Installing the project stripped..."
	/usr/bin/cmake -DCMAKE_INSTALL_DO_STRIP=1 -P cmake_install.cmake
.PHONY : install/strip/fast

# The main all target
all: cmake_check_build_system
	$(CMAKE_COMMAND) -E cmake_progress_start /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test/CMakeFiles /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test//CMakeFiles/progress.marks
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 all
	$(CMAKE_COMMAND) -E cmake_progress_start /home/tzy/Desktop/lab2-rtp-gg-tzy/Lab2-RTP-Test/CMakeFiles 0
.PHONY : all

# The main clean target
clean:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 clean
.PHONY : clean

# The main clean target
clean/fast: clean
.PHONY : clean/fast

# Prepare targets for installation.
preinstall: all
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall

# Prepare targets for installation.
preinstall/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 preinstall
.PHONY : preinstall/fast

# clear depends
depend:
	$(CMAKE_COMMAND) -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 1
.PHONY : depend

#=============================================================================
# Target rules for targets named rtpall

# Build rule for target.
rtpall: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 rtpall
.PHONY : rtpall

# fast build rule for target.
rtpall/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/build
.PHONY : rtpall/fast

#=============================================================================
# Target rules for targets named rtpsender

# Build rule for target.
rtpsender: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 rtpsender
.PHONY : rtpsender

# fast build rule for target.
rtpsender/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpsender.dir/build.make CMakeFiles/rtpsender.dir/build
.PHONY : rtpsender/fast

#=============================================================================
# Target rules for targets named rtpreceiver

# Build rule for target.
rtpreceiver: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 rtpreceiver
.PHONY : rtpreceiver

# fast build rule for target.
rtpreceiver/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpreceiver.dir/build.make CMakeFiles/rtpreceiver.dir/build
.PHONY : rtpreceiver/fast

#=============================================================================
# Target rules for targets named rtp_test_all

# Build rule for target.
rtp_test_all: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 rtp_test_all
.PHONY : rtp_test_all

# fast build rule for target.
rtp_test_all/fast:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtp_test_all.dir/build.make CMakeFiles/rtp_test_all.dir/build
.PHONY : rtp_test_all/fast

#=============================================================================
# Target rules for targets named gmock

# Build rule for target.
gmock: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 gmock
.PHONY : gmock

# fast build rule for target.
gmock/fast:
	$(MAKE) $(MAKESILENT) -f third_party/googletest-release-1.12.1/googlemock/CMakeFiles/gmock.dir/build.make third_party/googletest-release-1.12.1/googlemock/CMakeFiles/gmock.dir/build
.PHONY : gmock/fast

#=============================================================================
# Target rules for targets named gmock_main

# Build rule for target.
gmock_main: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 gmock_main
.PHONY : gmock_main

# fast build rule for target.
gmock_main/fast:
	$(MAKE) $(MAKESILENT) -f third_party/googletest-release-1.12.1/googlemock/CMakeFiles/gmock_main.dir/build.make third_party/googletest-release-1.12.1/googlemock/CMakeFiles/gmock_main.dir/build
.PHONY : gmock_main/fast

#=============================================================================
# Target rules for targets named gtest

# Build rule for target.
gtest: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 gtest
.PHONY : gtest

# fast build rule for target.
gtest/fast:
	$(MAKE) $(MAKESILENT) -f third_party/googletest-release-1.12.1/googletest/CMakeFiles/gtest.dir/build.make third_party/googletest-release-1.12.1/googletest/CMakeFiles/gtest.dir/build
.PHONY : gtest/fast

#=============================================================================
# Target rules for targets named gtest_main

# Build rule for target.
gtest_main: cmake_check_build_system
	$(MAKE) $(MAKESILENT) -f CMakeFiles/Makefile2 gtest_main
.PHONY : gtest_main

# fast build rule for target.
gtest_main/fast:
	$(MAKE) $(MAKESILENT) -f third_party/googletest-release-1.12.1/googletest/CMakeFiles/gtest_main.dir/build.make third_party/googletest-release-1.12.1/googletest/CMakeFiles/gtest_main.dir/build
.PHONY : gtest_main/fast

src/receiver_def.o: src/receiver_def.c.o
.PHONY : src/receiver_def.o

# target to build an object file
src/receiver_def.c.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpreceiver.dir/build.make CMakeFiles/rtpreceiver.dir/src/receiver_def.c.o
.PHONY : src/receiver_def.c.o

src/receiver_def.i: src/receiver_def.c.i
.PHONY : src/receiver_def.i

# target to preprocess a source file
src/receiver_def.c.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpreceiver.dir/build.make CMakeFiles/rtpreceiver.dir/src/receiver_def.c.i
.PHONY : src/receiver_def.c.i

src/receiver_def.s: src/receiver_def.c.s
.PHONY : src/receiver_def.s

# target to generate assembly for a file
src/receiver_def.c.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpreceiver.dir/build.make CMakeFiles/rtpreceiver.dir/src/receiver_def.c.s
.PHONY : src/receiver_def.c.s

src/rtp.o: src/rtp.c.o
.PHONY : src/rtp.o

# target to build an object file
src/rtp.c.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/src/rtp.c.o
.PHONY : src/rtp.c.o

src/rtp.i: src/rtp.c.i
.PHONY : src/rtp.i

# target to preprocess a source file
src/rtp.c.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/src/rtp.c.i
.PHONY : src/rtp.c.i

src/rtp.s: src/rtp.c.s
.PHONY : src/rtp.s

# target to generate assembly for a file
src/rtp.c.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/src/rtp.c.s
.PHONY : src/rtp.c.s

src/rtp_more_file_1.o: src/rtp_more_file_1.c.o
.PHONY : src/rtp_more_file_1.o

# target to build an object file
src/rtp_more_file_1.c.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/src/rtp_more_file_1.c.o
.PHONY : src/rtp_more_file_1.c.o

src/rtp_more_file_1.i: src/rtp_more_file_1.c.i
.PHONY : src/rtp_more_file_1.i

# target to preprocess a source file
src/rtp_more_file_1.c.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/src/rtp_more_file_1.c.i
.PHONY : src/rtp_more_file_1.c.i

src/rtp_more_file_1.s: src/rtp_more_file_1.c.s
.PHONY : src/rtp_more_file_1.s

# target to generate assembly for a file
src/rtp_more_file_1.c.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/src/rtp_more_file_1.c.s
.PHONY : src/rtp_more_file_1.c.s

src/rtp_more_file_2.o: src/rtp_more_file_2.c.o
.PHONY : src/rtp_more_file_2.o

# target to build an object file
src/rtp_more_file_2.c.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/src/rtp_more_file_2.c.o
.PHONY : src/rtp_more_file_2.c.o

src/rtp_more_file_2.i: src/rtp_more_file_2.c.i
.PHONY : src/rtp_more_file_2.i

# target to preprocess a source file
src/rtp_more_file_2.c.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/src/rtp_more_file_2.c.i
.PHONY : src/rtp_more_file_2.c.i

src/rtp_more_file_2.s: src/rtp_more_file_2.c.s
.PHONY : src/rtp_more_file_2.s

# target to generate assembly for a file
src/rtp_more_file_2.c.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/src/rtp_more_file_2.c.s
.PHONY : src/rtp_more_file_2.c.s

src/sender_def.o: src/sender_def.c.o
.PHONY : src/sender_def.o

# target to build an object file
src/sender_def.c.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpsender.dir/build.make CMakeFiles/rtpsender.dir/src/sender_def.c.o
.PHONY : src/sender_def.c.o

src/sender_def.i: src/sender_def.c.i
.PHONY : src/sender_def.i

# target to preprocess a source file
src/sender_def.c.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpsender.dir/build.make CMakeFiles/rtpsender.dir/src/sender_def.c.i
.PHONY : src/sender_def.c.i

src/sender_def.s: src/sender_def.c.s
.PHONY : src/sender_def.s

# target to generate assembly for a file
src/sender_def.c.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpsender.dir/build.make CMakeFiles/rtpsender.dir/src/sender_def.c.s
.PHONY : src/sender_def.c.s

src/test.o: src/test.cpp.o
.PHONY : src/test.o

# target to build an object file
src/test.cpp.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtp_test_all.dir/build.make CMakeFiles/rtp_test_all.dir/src/test.cpp.o
.PHONY : src/test.cpp.o

src/test.i: src/test.cpp.i
.PHONY : src/test.i

# target to preprocess a source file
src/test.cpp.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtp_test_all.dir/build.make CMakeFiles/rtp_test_all.dir/src/test.cpp.i
.PHONY : src/test.cpp.i

src/test.s: src/test.cpp.s
.PHONY : src/test.s

# target to generate assembly for a file
src/test.cpp.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtp_test_all.dir/build.make CMakeFiles/rtp_test_all.dir/src/test.cpp.s
.PHONY : src/test.cpp.s

src/util.o: src/util.c.o
.PHONY : src/util.o

# target to build an object file
src/util.c.o:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/src/util.c.o
.PHONY : src/util.c.o

src/util.i: src/util.c.i
.PHONY : src/util.i

# target to preprocess a source file
src/util.c.i:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/src/util.c.i
.PHONY : src/util.c.i

src/util.s: src/util.c.s
.PHONY : src/util.s

# target to generate assembly for a file
src/util.c.s:
	$(MAKE) $(MAKESILENT) -f CMakeFiles/rtpall.dir/build.make CMakeFiles/rtpall.dir/src/util.c.s
.PHONY : src/util.c.s

# Help Target
help:
	@echo "The following are some of the valid targets for this Makefile:"
	@echo "... all (the default if no target is provided)"
	@echo "... clean"
	@echo "... depend"
	@echo "... edit_cache"
	@echo "... install"
	@echo "... install/local"
	@echo "... install/strip"
	@echo "... list_install_components"
	@echo "... rebuild_cache"
	@echo "... test"
	@echo "... gmock"
	@echo "... gmock_main"
	@echo "... gtest"
	@echo "... gtest_main"
	@echo "... rtp_test_all"
	@echo "... rtpall"
	@echo "... rtpreceiver"
	@echo "... rtpsender"
	@echo "... src/receiver_def.o"
	@echo "... src/receiver_def.i"
	@echo "... src/receiver_def.s"
	@echo "... src/rtp.o"
	@echo "... src/rtp.i"
	@echo "... src/rtp.s"
	@echo "... src/rtp_more_file_1.o"
	@echo "... src/rtp_more_file_1.i"
	@echo "... src/rtp_more_file_1.s"
	@echo "... src/rtp_more_file_2.o"
	@echo "... src/rtp_more_file_2.i"
	@echo "... src/rtp_more_file_2.s"
	@echo "... src/sender_def.o"
	@echo "... src/sender_def.i"
	@echo "... src/sender_def.s"
	@echo "... src/test.o"
	@echo "... src/test.i"
	@echo "... src/test.s"
	@echo "... src/util.o"
	@echo "... src/util.i"
	@echo "... src/util.s"
.PHONY : help



#=============================================================================
# Special targets to cleanup operation of make.

# Special rule to run CMake to check the build system integrity.
# No rule that depends on this can have commands that come from listfiles
# because they might be regenerated.
cmake_check_build_system:
	$(CMAKE_COMMAND) -S$(CMAKE_SOURCE_DIR) -B$(CMAKE_BINARY_DIR) --check-build-system CMakeFiles/Makefile.cmake 0
.PHONY : cmake_check_build_system

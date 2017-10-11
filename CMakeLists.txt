cmake_minimum_required(VERSION 3.9)

project(pypokerstove)
#
# set up boost
#
# The goal is to make this work for linux/win/osx
if (UNIX)
    message(status "building for unix")
    set(BOOST_LIBRARYDIR "/usr/local/lib/")
elseif(CMAKE_GENERATOR STREQUAL Xcode)
    message(status ": building for xcode")
    set(BOOST_ROOT "/opt/include/")
    set(BOOST_LIBRARYDIR "/opt/local/lib")
else()
    message(status ": building for non-unix -> windows")
    set(BOOST_ROOT "E:/code/ext/boost_1_53_0/")
    set(BOOST_LIBRARYDIR "E:/code/ext/boost_1_53_0/lib32-msvc-10.0/")
endif()
set(Boost_USE_STATIC_LIBS   OFF)
set(Boost_USE_MULTITHREADED      ON)
# find_package(Boost COMPONENTS program_options REQUIRED)
find_package(Boost)
include_directories(${Boost_INCLUDE_DIR})
link_directories(${Boost_LIBRARY_DIRS})
message(status "** Boost Include: ${Boost_INCLUDE_DIR}")
message(status "** Boost Libraries: ${Boost_LIBRARY_DIRS}")
message(status "** Boost Libraries: ${Boost_LIBRARIES}")


find_package(SWIG REQUIRED)
include(${SWIG_USE_FILE})
set(CMAKE_SWIG_FLAGS "")

find_package(PythonLibs)
include_directories(${PYTHON_INCLUDE_PATH})

include_directories(pokerstove/src/lib/pokerstove/peval)
# include_directories(${CMAKE_CURRENT_SOURCE_DIR})

# SET(CMAKE_SWIG_FLAGS "-fPIC")
# add_definitions ("-std=c++0x")

# set_source_files_properties(${PROJECT_NAME}.i PROPERTIES CPLUSPLUS ON)
set_source_files_properties(${PROJECT_NAME}.i PROPERTIES CPLUSPLUS ON)
set_source_files_properties(${swig_generated_file_filename}
                            PROPERTIES COMPILE_FLAGS "-fPIC")
# set(CMAKE_SWIG_OUTDIR ${PROJECT_NAME})
link_directories(pokerstove/build/lib/pokerstove/peval)
find_library(libpeval REQUIRED)
swig_add_library(${PROJECT_NAME}
                 LANGUAGE python
                 SOURCES ${PROJECT_NAME}.i)
swig_link_libraries(${PROJECT_NAME} peval ${PYTHON_LIBRARIES} ${Boost_LIBRARIES})

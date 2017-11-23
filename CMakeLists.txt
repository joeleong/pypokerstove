cmake_minimum_required(VERSION 3.0)

project(pypokerstove VERSION 0.0.0)

# Boost
find_package(Boost)
include_directories(${Boost_INCLUDE_DIR})
link_directories(${Boost_LIBRARY_DIRS})

# SWIG
find_package(SWIG REQUIRED)
include(${SWIG_USE_FILE})
set(CMAKE_SWIG_FLAGS "")

# python
find_package(PythonLibs)
include_directories(${PYTHON_INCLUDE_PATH})

include_directories(pokerstove/src/lib)
include_directories(pokerstove/src/lib/pokerstove/peval)
include_directories(pokerstove/src/lib/pokerstove/penum)
include_directories(pokerstove/src/lib/pokerstove/util)

# SET(CMAKE_SWIG_FLAGS "-fPIC")
# add_definitions ("-std=c++0x")

set_source_files_properties(${PROJECT_NAME}.i PROPERTIES CPLUSPLUS ON)
set_source_files_properties(${swig_generated_file_filename}
                            PROPERTIES COMPILE_FLAGS "-fPIC")
# set(CMAKE_SWIG_OUTDIR ${PROJECT_NAME})
link_directories(pokerstove/build/lib/pokerstove/peval)
link_directories(pokerstove/build/lib/pokerstove/penum)
link_directories(pokerstove/build/lib/pokerstove/util)
find_library(libpeval REQUIRED)
find_library(libpenum REQUIRED)
find_library(util REQUIRED)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_NAME})
set(CMAKE_SWIG_OUTDIR ${PROJECT_NAME})


if (${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION} GREATER 3.8)
  swig_add_library(${PROJECT_NAME}
                   LANGUAGE python
                   SOURCES ${PROJECT_NAME}.i)
else (${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION} GREATER 3.8)
  swig_add_module(${PROJECT_NAME} PYTHON ${PROJECT_NAME}.i)
endif (${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION} GREATER 3.8)
swig_link_libraries(${PROJECT_NAME} peval penum util ${PYTHON_LIBRARIES} ${Boost_LIBRARIES})

# install bindings
find_program(PYTHON "python")
if (PYTHON)
    set(SETUP_PY_IN "${CMAKE_CURRENT_SOURCE_DIR}/setup.py.in")
    set(SETUP_PY    "${CMAKE_CURRENT_BINARY_DIR}/setup.py")
    set(INIT_PY     "${CMAKE_CURRENT_SOURCE_DIR}/__init__.py")
    set(OUT_INIT_PY "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}/__init__.py")
    set(DEPS        "${INIT_PY}")
    set(OUTPUT      "${CMAKE_CURRENT_BINARY_DIR}/timestamp")

    configure_file(${SETUP_PY_IN} ${SETUP_PY})
    configure_file(${INIT_PY} ${OUT_INIT_PY} COPYONLY)

    add_custom_command(OUTPUT ${OUTPUT}
                       # COMMAND ${PYTHON} ${SETUP_PY} build
                       COMMAND ${CMAKE_COMMAND} -E touch ${OUTPUT}
                       DEPENDS ${DEPS})
    message(${DEPS})

    add_custom_target(target ALL DEPENDS ${OUTPUT})

    # install(CODE "execute_process(COMMAND ${PYTHON} ${SETUP_PY} install)")
endif()

cmake_minimum_required(VERSION 2.6)
project("IA41-Force3")

if( CMAKE_SIZEOF_VOID_P EQUAL 8 )
    MESSAGE( "64 bits compiler detected" )
    SET( EX_PLATFORM 64 )
    SET( EX_PLATFORM_NAME "x64" )
else( CMAKE_SIZEOF_VOID_P EQUAL 8 )
    MESSAGE( "32 bits compiler detected" )
    SET( EX_PLATFORM 32 )
    SET( EX_PLATFORM_NAME "x86" )
endif( CMAKE_SIZEOF_VOID_P EQUAL 8 )


add_definitions(-Wall -Wextra)
SET(CMAKE_CXX_FLAGS_DEBUG  "${CMAKE_CXX_FLAGS_DEBUG} -DDEBUG -g")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

if(${MINGW})
    SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -std=c++1y")
    SET(platform "mingw")
    if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.8)
        SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -DWINFOIREU")
    endif()
endif(${MINGW})

if(${UNIX})
    SET(CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} -std=c++14")
    SET(platform "gcc")
endif(${UNIX})

SET(BASEPATH "${CMAKE_SOURCE_DIR}")
INCLUDE_DIRECTORIES("${BASEPATH}")

SET(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -DDB -Wall -Wextra")
SET(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3 -Os -s")

find_package(GLEW)

find_package(SFML 2.1 COMPONENTS system window graphics audio REQUIRED)
if(NOT SFML_FOUND)
    message(FATAL_ERROR "SFML not found")
endif(NOT SFML_FOUND)

INCLUDE_DIRECTORIES(${SFML_INCLUDE_DIR})
INCLUDE_DIRECTORIES(${GLEW_INCLUDE_DIR})

file(
    GLOB_RECURSE
    files
    src/*.cpp
    include/*.hpp
)


find_package(Doxygen)
if(DOXYGEN_FOUND)
    add_custom_target(doc ${DOXYGEN_EXECUTABLE} doxygen.conf)
endif(DOXYGEN_FOUND)

if(WIN32)
    add_executable(${PROJECT_NAME} WIN32 ${files})
else(WIN32)
    add_executable(${PROJECT_NAME} ${files})
endif(WIN32)

target_link_libraries(${PROJECT_NAME} ${SFML_LIBRARIES} ${GLEW_LIBRARIES})

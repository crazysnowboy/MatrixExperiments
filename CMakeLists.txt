CMAKE_MINIMUM_REQUIRED(VERSION 2.8.11) #cmake 版本限定
PROJECT(ExperimentProject)  #工程名称


include(cmake/ConfigureOpenCV.cmake)
include(cmake/MyConfigure.cmake)
include(cmake/ConfigureOpengl.cmake)

#set(CMAKE_VERBOSE_MAKEFILE 1)
#set(CMAKE_BUILD_TYPE Release) # 等同于 cmake -DCMAKE_BUILD_TYPE=release

# ---[ Includes
set(INCLUDE_DIR ${PROJECT_SOURCE_DIR}/include
        ${PROJECT_SOURCE_DIR}/include/Graphics
        ${PROJECT_SOURCE_DIR}/include/Blendshape
        ${PROJECT_SOURCE_DIR}/include/libTracker
        ${PROJECT_SOURCE_DIR}/include/Deformation
        ${PROJECT_SOURCE_DIR}/include/3DMM
        ${PROJECT_SOURCE_DIR}/include/my
        ${PROJECT_SOURCE_DIR}/include/dt-corrstool
        ${PROJECT_SOURCE_DIR}/include/dt-dtrans
        ${PROJECT_SOURCE_DIR}/include/dt-common
        ${PROJECT_SOURCE_DIR}/include/dt-cholmod
        ${PROJECT_SOURCE_DIR}/include/dt-gl_util
        ${PROJECT_SOURCE_DIR}/include/dt-corres_resolve
        )
include_directories(${INCLUDE_DIR})

#message(STATUS "crazylog--------------LIBRARIES=" ${LIBRARIES} )
#include_directories(${PROJECT_SOURCE_DIR}/src)

add_subdirectory(${PROJECT_SOURCE_DIR}/src/c)
add_subdirectory(${PROJECT_SOURCE_DIR}/src/cpp)
add_subdirectory(${PROJECT_SOURCE_DIR}/main)




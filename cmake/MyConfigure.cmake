list(APPEND LIBRARIES -lpthread -ldl)
list(APPEND LIBRARIES -lopenblas -lcurl )
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")

find_package(Pangolin REQUIRED)
if(Pangolin_FOUND)
    message(STATUS "Pangolin found at ${Pangolin_INCLUDE_DIRS}")
    include_directories(${Pangolin_INCLUDE_DIRS})

    message(STATUS "Pangolin_LIBRARIES found at ${Pangolin_LIBRARIES}")


    list(APPEND LIBRARIES  ${Pangolin_LIBRARIES})
else(Pangolin_FOUND)
    message(FATAL_ERROR "Pangolin not found")
endif()


find_package(Boost 1.50.0 COMPONENTS system filesystem program_options REQUIRED)
if(Boost_FOUND)
    message(STATUS "Boost found at ${Boost_INCLUDE_DIRS}")
    list(APPEND LIBRARIES ${Boost_LIBRARIES})
else(Boost_FOUND)
    message(FATAL_ERROR "Boost not found")
endif()
list(APPEND LIBRARIES
        -lpthread
        -ldl
        -lm
        -lcholmod
        -lsuitesparseconfig
        -lcolamd
        -lccolamd
        -lcamd
        -lamd
        -lumfpack
        -lcholmod
        -lblas
        -llapack
        )
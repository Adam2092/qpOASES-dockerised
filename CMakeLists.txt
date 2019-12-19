cmake_minimum_required(VERSION 2.8)

project(test)

set(CMAKE_CXX_FLAGS "-std=c++11")

link_directories("/usr/local/lib")
include_directories("/usr/local/include")

add_executable(test ${PROJECT_SOURCE_DIR}/src/example.cpp)
target_link_libraries(test libqpOASES.a)

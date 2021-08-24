cmake_minimum_required(VERSION 3.20)

project(setup_eigen3)

find_package(Eigen3 REQUIRED)

set(CMAKE_CXX_STANDARD 14)

add_executable(${PROJECT_NAME} main.cpp)

target_link_libraries(${PROJECT_NAME} PRIVATE Eigen3::Eigen)

target_include_directories(${PROJECT_NAME} PRIVATE ${EIGEN3_INCLUDE_DIR})
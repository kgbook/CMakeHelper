cmake_minimum_required(VERSION 3.16)

project(ExternalGreeting LANGUAGES CXX)

add_library(external_greeting STATIC
    src/external_greeting.cpp)
target_include_directories(external_greeting
    PUBLIC
        include)

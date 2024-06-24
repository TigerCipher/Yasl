cmake_minimum_required(VERSION 3.28)
project(Interpreter)

set(CMAKE_CXX_STANDARD 20)

add_executable(Yasl src/lex.yy.c src/parser.tab.c
        src/main.cpp
        src/builtin_functions.h
        src/builtin_functions.cpp
)

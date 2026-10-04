cmake_minimum_required(VERSION 3.25)

# Frostfall.dll: the SKSE plugin behind Frostfall's HUD bars, start-up logo and SKSE Menu Framework page.
# src/ and include/ are CageTV's Frostfall 2026 plugin (MIT, github.com/CageTV/Frostfall-2026, plugin/), unchanged;
# only the build differs (README.md).
project(Frostfall VERSION 4.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(NOT WIN32 OR NOT MSVC OR NOT CMAKE_SIZEOF_VOID_P EQUAL 8)
	message(FATAL_ERROR "Frostfall.dll is an SKSE plugin: Windows x64 with MSVC only")
endif()

# alandtse CommonLibSSE-NG v9.1.0: runs 1.7.x as AE, reads the format-5 Address Library exactly and carries the
# 1.7.99 structure layouts. Upstream's manifest pins the colorglass vcpkg registry, whose CommonLibSSE-NG 3.7.0
# takes runtime 1.7.x for Skyrim SE and cannot read that library.
include(FetchContent)
set(BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(ENABLE_SKYRIM_SE ON CACHE BOOL "" FORCE)
set(ENABLE_SKYRIM_AE ON CACHE BOOL "" FORCE)
set(ENABLE_SKYRIM_VR OFF CACHE BOOL "" FORCE)
FetchContent_Declare(CommonLibSSE
	GIT_REPOSITORY https://github.com/alandtse/CommonLibSSE-NG.git
	GIT_TAG a898f469851c464d05137bb74b069dd234897643)
FetchContent_MakeAvailable(CommonLibSSE)
# add_commonlibsse_plugin() lives in a module the source tree includes only for its prebuilt branch
include(${commonlibsse_SOURCE_DIR}/cmake/CommonLibSSE.cmake)

# The ESL build is for an ESL-flagged Frostfall.esp (compacted FormIDs): it looks the globals up by their new ids.
option(FROSTFALL_ESL "Build for the ESL (compacted FormID) Frostfall.esp" OFF)

add_commonlibsse_plugin(${PROJECT_NAME} NAME "Frostfall" AUTHOR "CageTV" SOURCES
	src/main.cpp
	src/Settings.cpp
	src/Game.cpp
	src/Hud.cpp
	src/Menu.cpp
)

target_include_directories(${PROJECT_NAME} PRIVATE src include)
target_precompile_headers(${PROJECT_NAME} PRIVATE src/PCH.h)
target_compile_options(${PROJECT_NAME} PRIVATE /permissive- /Zc:preprocessor /utf-8 /W3)
target_compile_definitions(${PROJECT_NAME} PRIVATE NOMINMAX WIN32_LEAN_AND_MEAN UNICODE _UNICODE)
if(FROSTFALL_ESL)
	target_compile_definitions(${PROJECT_NAME} PRIVATE FROSTFALL_ESL)
endif()
# RelWithDebInfo links incrementally and keeps every CommonLib function of a used object file, Address Library ids
# included; drop what the plugin never calls, as a Release link does
target_link_options(${PROJECT_NAME} PRIVATE $<$<CONFIG:RelWithDebInfo>:/OPT:REF /OPT:ICF /INCREMENTAL:NO>)

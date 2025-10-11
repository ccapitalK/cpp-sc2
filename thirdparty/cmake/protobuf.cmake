message(STATUS "FetchContent: protobuf")

set(protobuf_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(protobuf_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)

# Do not build Protobuf compiler if using precompiled proto files
if (WSL2_CROSS_COMPILE)
    set(protobuf_BUILD_PROTOC_BINARIES OFF CACHE BOOL "" FORCE)
endif ()

FetchContent_Declare(
    protobuf
    GIT_REPOSITORY https://github.com/protocolbuffers/protobuf.git
    GIT_TAG v32.1
)
FetchContent_MakeAvailable(protobuf)

set(protobuf_targets libprotobuf libprotobuf-lite libprotoc protoc)

foreach (target IN LISTS protobuf_targets)
    if (TARGET ${target})
        set_target_properties(${target} PROPERTIES FOLDER contrib)
    endif ()

    if (MSVC)
        target_compile_options(${target} PRIVATE /W0)
    endif ()
endforeach ()

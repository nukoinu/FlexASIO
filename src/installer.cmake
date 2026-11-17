include("${CMAKE_CURRENT_LIST_DIR}/check_git_submodule.cmake")
check_git_submodule("${CMAKE_CURRENT_LIST_DIR}/dechamps_CMakeUtils")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/dechamps_CMakeUtils")
find_package(InnoSetup MODULE REQUIRED)

include(execute_process_or_die)
if(FLEXASIO_X64_BUILD_DIR)
    get_filename_component(FLEXASIO_X64_BUILD_DIR "${FLEXASIO_X64_BUILD_DIR}" ABSOLUTE)
    load_cache("${FLEXASIO_X64_BUILD_DIR}" READ_WITH_PREFIX BUILD_ CMAKE_INSTALL_PREFIX FLEXASIO_RELEASE_VERSION FLEXASIO_WASAPI_WDMKS_ONLY)
    if(NOT BUILD_FLEXASIO_RELEASE_VERSION OR NOT BUILD_FLEXASIO_WASAPI_WDMKS_ONLY)
        message(FATAL_ERROR "Build and stage the x64 WASAPI and WDM-KS release with FLEXASIO_RELEASE_VERSION first")
    endif()
    set(FLEXASIO_RELEASE_VERSION "${BUILD_FLEXASIO_RELEASE_VERSION}")
    include("${CMAKE_CURRENT_LIST_DIR}/release-version.cmake")
    set(ASIO_SDK_DIR "${FLEXASIO_X64_BUILD_DIR}/dechamps_ASIOUtil-prefix/src/dechamps_ASIOUtil-build/_deps/asiosdk-src")
    configure_file("${CMAKE_CURRENT_LIST_DIR}/README-x64.in.txt" "${CMAKE_CURRENT_LIST_DIR}/out/README-x64.txt" @ONLY)
    configure_file("${CMAKE_CURRENT_LIST_DIR}/installer-x64.in.iss" "${CMAKE_CURRENT_LIST_DIR}/out/installer-x64.iss" @ONLY)
    execute_process_or_die(
        COMMAND "${InnoSetup_iscc_EXECUTABLE}" "${CMAKE_CURRENT_LIST_DIR}/out/installer-x64.iss" "/O${CMAKE_CURRENT_LIST_DIR}/out/installer"
    )
    return()
endif()

find_package(Git MODULE REQUIRED)
set(DECHAMPS_CMAKEUTILS_GIT_DIR "${CMAKE_CURRENT_LIST_DIR}/flexasio")
include(version/version)
if(FLEXASIO_RELEASE_VERSION)
    set(FLEXASIO_VERSION "${FLEXASIO_RELEASE_VERSION}")
else()
    string(REGEX REPLACE "^flexasio-" "" FLEXASIO_VERSION "${DECHAMPS_CMAKEUTILS_GIT_DESCRIPTION_DIRTY}")
endif()

configure_file("${CMAKE_CURRENT_LIST_DIR}/installer.in.iss" "${CMAKE_CURRENT_LIST_DIR}/out/installer.iss" @ONLY)
execute_process_or_die(
    COMMAND "${InnoSetup_iscc_EXECUTABLE}" out/installer.iss /Oout/installer /FFlexASIO-${FLEXASIO_VERSION}
    WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}"
)

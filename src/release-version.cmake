# Windows binary version fields use four integers. Keep the release label as
# a separate string so suffixes such as the b in 1.10b are preserved.
if(NOT FLEXASIO_RELEASE_VERSION MATCHES "^([0-9]+)\\.([0-9]+)([A-Za-z][A-Za-z0-9.-]*)?$")
	message(FATAL_ERROR "Expected a FlexASIO release version such as 1.20 or 1.10b")
endif()
set(FLEXASIO_NUMERIC_VERSION "${CMAKE_MATCH_1}.${CMAKE_MATCH_2}.0.0")

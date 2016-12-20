
include(disable_warnings.cmake)

add_subdirectory(idl)

include(DdsDcps.cmake)

add_subdirectory(DCPS/RTPS)
add_subdirectory(DCPS/transport)
add_subdirectory(DCPS/InfoRepoDiscovery)
add_subdirectory(FACE)
add_subdirectory(InfoRepo)
add_subdirectory(monitor)
add_subdirectory(idl)
include(DdsDcps.cmake)
add_subdirectory(DCPS/RTPS)
add_subdirectory(DCPS/transport)
add_subdirectory(DCPS/InfoRepoDiscovery)
add_subdirectory(FACE)
add_subdirectory(InfoRepo)
add_subdirectory(monitor)

add_library(OpenDDS_Default_Discovery INTERFACE)
add_library(OpenDDS_Transports_For_Test INTERFACE)

if (NO_OPENDDS_SAFETY_PROFILE)
  target_link_libraries(OpenDDS_Default_Discovery INTERFACE
    OpenDDS_InfoRepoDiscovery
  )
  target_link_libraries(OpenDDS_Transports_For_Test INTERFACE
    OpenDDS_Tcp
    OpenDDS_Udp
    OpenDDS_Multicast
    OpenDDS_Rtps_Udp
    OpenDDS_Shmem
  )
else()
  target_link_libraries(OpenDDS_Transports_For_Test INTERFACE
    OpenDDS_Rtps_Udp
  )
  target_link_libraries(OpenDDS_Default_Discovery INTERFACE
    OpenDDS_Rtps
  )
endif()

install(TARGETS OpenDDS_Default_Discovery
                OpenDDS_Transports_For_Test
        EXPORT  OpenDDSTargets)
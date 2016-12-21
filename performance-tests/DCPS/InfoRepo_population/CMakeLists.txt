requires("NOT MINIMUM_CORBA" NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(InfoRepo_population_SyncServer
  OUTPUT_NAME syncServer
  SOURCE_FILES SyncServer.cpp
               SyncExt_i.cpp
  HEADER_FILES SyncExt_i.h
  FOLDER performance-tests/DCPS/InfoRepo_population
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../Sync
                      ${CMAKE_CURRENT_BINARY_DIR}/../Sync
  LINK_LIBRARIES Sync_ServerLib
                 TAO_PortableServer
                 TAO_IORTable
)


add_ace_exe(InfoRepo_population_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES SyncClientExt_i.cpp
               publisher.cpp
               Writer.cpp
  HEADER_FILES SyncClientExt_i.h
               Writer.h
  FOLDER performance-tests/DCPS/InfoRepo_population
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../Sync
                      ${CMAKE_CURRENT_BINARY_DIR}/../Sync
  LINK_LIBRARIES OpenDDS_Tcp
                 Sync_ClientLib
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

add_ace_exe(InfoRepo_population_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES SyncClientExt_i.cpp
               subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES SyncClientExt_i.h
               DataReaderListener.h
  FOLDER performance-tests/DCPS/InfoRepo_population
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../Sync
                      ${CMAKE_CURRENT_BINARY_DIR}/../Sync
  LINK_LIBRARIES OpenDDS_Tcp
                 Sync_ClientLib
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

tao_idl_sources(
  TARGETS InfoRepo_population_SyncServer
          InfoRepo_population_Publisher
          InfoRepo_population_Subscriber
  IDL_FLAGS -I../Sync
  IDL_FILES SyncExt.idl
)

dds_idl_sources(
  TARGETS InfoRepo_population_Publisher
          InfoRepo_population_Subscriber
  TAO_IDL_FLAGS -I../Sync
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("performance-tests/DCPS/InfoRepo_population/run_test.pl"
  COMMAND run_test.pl
)

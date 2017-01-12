ace_requires("NOT MINIMUM_CORBA" NO_OPENDDS_SAFETY_PROFILE)


ace_requires("NOT MINIMUM_CORBA" NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(InfoRepo_population_Syncserver
  OUTPUT_NAME syncServer

  FOLDER performance-tests/DCPS/InfoRepo_population
  ASPECTS TAO
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../Sync
                      ${CMAKE_CURRENT_BINARY_DIR}/../Sync
  LINK_LIBRARIES Sync_Serverlib
                 TAO_PortableServer
                 TAO_IORTable
)
ace_target_cxx_sources(InfoRepo_population_Syncserver
  SOURCE_FILES SyncExt_i.cpp
               SyncServer.cpp
  HEADER_FILES SyncExt_i.h
)

ace_add_exe(InfoRepo_population_Publisher
  OUTPUT_NAME publisher
  FOLDER performance-tests/DCPS/InfoRepo_population
  ASPECTS DCPS_DEFAULT_DISCOVERY
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../Sync
                      ${CMAKE_CURRENT_BINARY_DIR}/../Sync
  LINK_LIBRARIES OpenDDS_Tcp
                 Sync_Clientlib
)
ace_target_cxx_sources(InfoRepo_population_Publisher
  SOURCE_FILES SyncClientExt_i.cpp
               Writer.cpp
               publisher.cpp
  HEADER_FILES SyncClientExt_i.h
               Writer.h
)

ace_add_exe(InfoRepo_population_Subscriber
  OUTPUT_NAME subscriber
  FOLDER performance-tests/DCPS/InfoRepo_population
  ASPECTS DCPS_DEFAULT_DISCOVERY
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../Sync
                      ${CMAKE_CURRENT_BINARY_DIR}/../Sync
  LINK_LIBRARIES OpenDDS_Tcp
                 Sync_Clientlib
)
ace_target_cxx_sources(InfoRepo_population_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               SyncClientExt_i.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               SyncClientExt_i.h
)

tao_idl_sources(
  TARGETS InfoRepo_population_Syncserver
          InfoRepo_population_Publisher
          InfoRepo_population_Subscriber
  IDL_FLAGS -Sa -St -I../Sync
  IDL_FILES SyncExt.idl
)

dds_idl_sources(
  TARGETS InfoRepo_population_Publisher
          InfoRepo_population_Subscriber
  TAO_IDL_FLAGS -Sa -St -I../Sync
  DDS_IDL_FLAGS -Sa -St -I../Sync
  IDL_FILES Messenger.idl
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("performance-tests/DCPS/InfoRepo_population/run_test.pl"
  COMMAND run_test.pl
)

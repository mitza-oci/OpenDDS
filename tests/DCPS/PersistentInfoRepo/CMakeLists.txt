ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(PersistentInfoRepo_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/PersistentInfoRepo
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Model
                 TestUtils
                 DcpsFooType4
)
ace_target_cxx_sources(PersistentInfoRepo_Publisher
  SOURCE_FILES Publisher.cpp
)


ace_add_exe(PersistentInfoRepo_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/PersistentInfoRepo
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Model
                 TestUtils
                 DcpsFooType4
)
ace_target_cxx_sources(PersistentInfoRepo_Subscriber
  SOURCE_FILES Listener.cpp
               Subscriber.cpp
  HEADER_FILES Listener.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/PersistentInfoRepo/run_test.pl"
  COMMAND run_test.pl
)

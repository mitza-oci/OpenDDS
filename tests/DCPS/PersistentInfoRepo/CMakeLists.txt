ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(PersistentInfoRepo_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/PersistentInfoRepo
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 TestUtils
                 DcpsFooType4
                 OpenDDS_Model
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(PersistentInfoRepo_Publisher
  SOURCE_FILES Publisher.cpp
)


ace_add_exe(PersistentInfoRepo_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/PersistentInfoRepo
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 TestUtils
                 DcpsFooType4
                 OpenDDS_Model
                 OpenDDS_Default_Discovery
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

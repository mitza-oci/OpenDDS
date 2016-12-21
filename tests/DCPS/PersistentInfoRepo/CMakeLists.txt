requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(PersistentInfoRepo_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
  FOLDER tests/DCPS/PersistentInfoRepo
  LINK_LIBRARIES TestUtils
                 DcpsFooType4
                 ${DCPS_TRANSPORTS_FOR_TEST}
                 OpenDDS_Model
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

add_ace_exe(PersistentInfoRepo_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
               Listener.cpp
  HEADER_FILES Listener.h
  FOLDER tests/DCPS/PersistentInfoRepo
  LINK_LIBRARIES TestUtils
                 DcpsFooType4
                 ${DCPS_TRANSPORTS_FOR_TEST}
                 OpenDDS_Model
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/PersistentInfoRepo/run_test.pl"
  COMMAND run_test.pl
)

add_ace_exe(FooTest3_2_Publisher
  OUTPUT_NAME FooTest3_publisher
  SOURCE_FILES pub_main.cpp
               PubDriver.cpp
               InstanceDataMap.cpp
               Writer.cpp
  HEADER_FILES PubDriver.h
               InstanceDataMap.h
               Writer.h
  FOLDER tests/DCPS/FooTest3_2
  LINK_LIBRARIES DcpsFooType3Unbounded
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(FooTest3_2_Subscriber
  OUTPUT_NAME FooTest3_subscriber
  SOURCE_FILES sub_main.cpp
               SubDriver.cpp
               DataReaderListener.cpp
  HEADER_FILES SubDriver.h
               DataReaderListener.h
  FOLDER tests/DCPS/FooTest3_2
  LINK_LIBRARIES DcpsFooType3Unbounded
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/FooTest3_2/run_test.pl"
  COMMAND run_test.pl
  REQUIRES OWNERSHIP_PROFILE
  LABELS DCPS_MIN
)


add_dds_test("tests/DCPS/FooTest3_2/run_test.pl mi"
  COMMAND run_test.pl mi
  REQUIRES OWNERSHIP_PROFILE
)


add_dds_test("tests/DCPS/FooTest3_2/run_test.pl mw"
  COMMAND run_test.pl mw
  REQUIRES OWNERSHIP_PROFILE
)


add_dds_test("tests/DCPS/FooTest3_2/run_test.pl bp_remove"
  COMMAND run_test.pl bp_remove
)


add_dds_test("tests/DCPS/FooTest3_2/run_test.pl b"
  COMMAND run_test.pl b
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/FooTest3_2/run_test.pl rtps b"
  COMMAND run_test.pl rtps b
  REQUIRES OWNERSHIP_PROFILE BUILD_SHARED_LIBS
  LABELS RTPS
)

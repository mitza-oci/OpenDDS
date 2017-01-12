ace_add_exe(FooTest3_2_Publisher
  OUTPUT_NAME FooTest3_publisher
  FOLDER tests/DCPS/FooTest3_2
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType3Unbounded
                 OpenDDS_Dcps
)
ace_target_cxx_sources(FooTest3_2_Publisher
  SOURCE_FILES InstanceDataMap.cpp
               PubDriver.cpp
               Writer.cpp
               pub_main.cpp
  HEADER_FILES InstanceDataMap.h
               PubDriver.h
               Writer.h
)


ace_add_exe(FooTest3_2_Subscriber
  OUTPUT_NAME FooTest3_subscriber
  FOLDER tests/DCPS/FooTest3_2
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DcpsFooType3Unbounded
                 OpenDDS_Dcps
)
ace_target_cxx_sources(FooTest3_2_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               SubDriver.cpp
               sub_main.cpp
  HEADER_FILES DataReaderListener.h
               SubDriver.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/FooTest3_2/run_test.pl"
  COMMAND run_test.pl
  REQUIRES OWNERSHIP_PROFILE
  LABELS DCPS_MIN
)


dds_add_test("tests/DCPS/FooTest3_2/run_test.pl mi"
  COMMAND run_test.pl mi
  REQUIRES OWNERSHIP_PROFILE
)


dds_add_test("tests/DCPS/FooTest3_2/run_test.pl mw"
  COMMAND run_test.pl mw
  REQUIRES OWNERSHIP_PROFILE
)


dds_add_test("tests/DCPS/FooTest3_2/run_test.pl bp_remove"
  COMMAND run_test.pl bp_remove
)


dds_add_test("tests/DCPS/FooTest3_2/run_test.pl b"
  COMMAND run_test.pl b
  REQUIRES OWNERSHIP_PROFILE NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/FooTest3_2/run_test.pl rtps b"
  COMMAND run_test.pl rtps b
  REQUIRES OWNERSHIP_PROFILE BUILD_SHARED_LIBS
  LABELS RTPS
)

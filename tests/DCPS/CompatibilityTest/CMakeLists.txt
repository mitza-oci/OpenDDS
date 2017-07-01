ace_add_exe(CompatibilityTest_Publisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType4
                 common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(CompatibilityTest_Publisher
  SOURCE_FILES DataWriterListenerImpl.cpp
               Writer.cpp
               common.cpp
               publisher.cpp
  HEADER_FILES DataWriterListenerImpl.h
               Writer.h
               common.h
)


ace_add_exe(CompatibilityTest_Subscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType4
                 common
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(CompatibilityTest_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               common.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               common.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()

foreach(i RANGE 1 10)

  if ((${i} EQUAL 1) AND (NOT OPENDDS_HAS_PERSISTENCE_PROFILE))
    continue()
  endif()

  dds_add_test("tests/DCPS/CompatibilityTest/run_test.pl__-i__${i}"
    COMMAND run_test.pl -i ${i}
    REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
    NO_LOCK
  )

  dds_add_test("tests/DCPS/CompatibilityTest/run_test.pl__-i__${i}__rtps_disc"
    COMMAND run_test.pl -i ${i} rtps_disc
    LABELS RTPS
    NO_LOCK
  )

  dds_add_test("tests/DCPS/CompatibilityTest/run_test.pl__-i__${i}__rtps_disc_tcp"
    COMMAND run_test.pl -i ${i} rtps_disc_tcp
    REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
    LABELS RTPS
    NO_LOCK
  )

endforeach()




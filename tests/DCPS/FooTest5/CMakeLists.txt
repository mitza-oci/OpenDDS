ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE)

ace_add_exe(DcpsFooTest5Publisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Model
                 DcpsFooType5
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DcpsFooTest5Publisher
  SOURCE_FILES InstanceDataMap.cpp
               Writer.cpp
               common.cpp
               publisher.cpp
  HEADER_FILES InstanceDataMap.h
               Writer.h
               common.h
)


ace_add_exe(DcpsFooTest5Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DcpsFooType5
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DcpsFooTest5Subscriber
  SOURCE_FILES DataReaderListener.cpp
               InstanceDataMap.cpp
               common.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               InstanceDataMap.h
               common.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/FooTest5/run_test.pl"
  COMMAND run_test.pl
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl udp"
  COMMAND run_test.pl udp
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl multicast"
  COMMAND run_test.pl multicast
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS MCAST
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS RTPS
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl shmem"
  COMMAND run_test.pl shmem
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS SHMEM
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl mi"
  COMMAND run_test.pl mi
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl udp mi"
  COMMAND run_test.pl udp mi
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl rtps mi"
  COMMAND run_test.pl rtps mi
  LABELS RTPS
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl shmem mi"
  COMMAND run_test.pl shmem mi
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS SHMEM
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl nokey mi"
  COMMAND run_test.pl nokey mi
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl nokey udp mi"
  COMMAND run_test.pl nokey udp mi
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl nokey rtps mi"
  COMMAND run_test.pl nokey rtps mi
  LABELS RTPS
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl nokey shmem mi"
  COMMAND run_test.pl nokey shmem mi
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS SHMEM
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl blocking"
  COMMAND run_test.pl blocking
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl blocking_timeout"
  COMMAND run_test.pl blocking_timeout
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl mwmr"
  COMMAND run_test.pl mwmr
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl mr"
  COMMAND run_test.pl mr
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl multicast mr"
  COMMAND run_test.pl multicast mr
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/FooTest5/run_test.pl mixed_trans"
  COMMAND run_test.pl mixed_trans
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)

ace_requires(OWNERSHIP_PROFILE)

ace_add_exe(DDS_ManyToMany_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/ManyToMany
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_LargeSample_Idl
                 OpenDDS_Dcps
)
ace_target_cxx_sources(DDS_ManyToMany_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(DDS_ManyToMany_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/ManyToMany
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_LargeSample_Idl
                 OpenDDS_Dcps
)
ace_target_cxx_sources(DDS_ManyToMany_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/ManyToMany/run_test.pl tcp 12to12 small"
  COMMAND run_test.pl tcp 12to12 small
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl tcp 12to12 large"
  COMMAND run_test.pl tcp 12to12 large
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl multicast 1to1 small"
  COMMAND run_test.pl multicast 1to1 small
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl multicast 1to1 large"
  COMMAND run_test.pl multicast 1to1 large
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl multicast_async 1to1 small"
  COMMAND run_test.pl multicast_async 1to1 small
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl multicast_async 1to1 large"
  COMMAND run_test.pl multicast_async 1to1 large
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl udp 1to1 small"
  COMMAND run_test.pl udp 1to1 small
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl udp 1to1 large"
  COMMAND run_test.pl udp 1to1 large
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl rtps 1to1 small"
  COMMAND run_test.pl rtps 1to1 small
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS RTPS
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl rtps 1to1 large"
  COMMAND run_test.pl rtps 1to1 large
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS RTPS
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl rtps_disc 12to12 small"
  COMMAND run_test.pl rtps_disc 12to12 small
  LABELS RTPS
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl shmem 1to1 small"
  COMMAND run_test.pl shmem 1to1 small
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS SHMEM
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl shmem 1to1 large"
  COMMAND run_test.pl shmem 1to1 large
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS SHMEM
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl tcp 20to20 small orb_csdtp"
  COMMAND run_test.pl tcp 20to20 small orb_csdtp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)

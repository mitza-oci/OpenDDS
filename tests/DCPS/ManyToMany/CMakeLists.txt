ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE)

ace_add_exe(DDS_ManyToMany_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/ManyToMany
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_LargeSample_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_ManyToMany_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)
ace_target_cxx_sources(DDS_ManyToMany_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)



ace_add_exe(DDS_ManyToMany_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/ManyToMany
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_LargeSample_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_ManyToMany_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/ManyToMany/run_test.pl tcp 12to12 small"
  COMMAND run_test.pl tcp 12to12 small
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl tcp 12to12 large"
  COMMAND run_test.pl tcp 12to12 large
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl multicast 1to1 small"
  COMMAND run_test.pl multicast 1to1 small
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl multicast 1to1 large"
  COMMAND run_test.pl multicast 1to1 large
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl multicast_async 1to1 small"
  COMMAND run_test.pl multicast_async 1to1 small
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl multicast_async 1to1 large"
  COMMAND run_test.pl multicast_async 1to1 large
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl udp 1to1 small"
  COMMAND run_test.pl udp 1to1 small
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl udp 1to1 large"
  COMMAND run_test.pl udp 1to1 large
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl rtps 1to1 small"
  COMMAND run_test.pl rtps 1to1 small
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS RTPS
  RESOURCE_LOCK RTPS
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl rtps 1to1 large"
  COMMAND run_test.pl rtps 1to1 large
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS RTPS
  RESOURCE_LOCK RTPS
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl rtps_disc 12to12 small"
  COMMAND run_test.pl rtps_disc 12to12 small
  LABELS RTPS
  RESOURCE_LOCK RTPS
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl shmem 1to1 small"
  COMMAND run_test.pl shmem 1to1 small
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS SHMEM
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl shmem 1to1 large"
  COMMAND run_test.pl shmem 1to1 large
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS SHMEM
)


dds_add_test("tests/DCPS/ManyToMany/run_test.pl tcp 20to20 small orb_csdtp"
  COMMAND run_test.pl tcp 20to20 small orb_csdtp
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  RESOURCE_LOCK RTPS
)

requires(OWNERSHIP_PROFILE)

add_ace_exe(DDS_ManyToMany_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/ManyToMany
  LINK_LIBRARIES DDS_LargeSample_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_ManyToMany_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/ManyToMany
  LINK_LIBRARIES DDS_LargeSample_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/ManyToMany/run_test.pl tcp 12to12 small"
  COMMAND run_test.pl tcp 12to12 small
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl tcp 12to12 large"
  COMMAND run_test.pl tcp 12to12 large
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl multicast 1to1 small"
  COMMAND run_test.pl multicast 1to1 small
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl multicast 1to1 large"
  COMMAND run_test.pl multicast 1to1 large
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl multicast_async 1to1 small"
  COMMAND run_test.pl multicast_async 1to1 small
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl multicast_async 1to1 large"
  COMMAND run_test.pl multicast_async 1to1 large
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl udp 1to1 small"
  COMMAND run_test.pl udp 1to1 small
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl udp 1to1 large"
  COMMAND run_test.pl udp 1to1 large
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl rtps 1to1 small"
  COMMAND run_test.pl rtps 1to1 small
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS RTPS
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl rtps 1to1 large"
  COMMAND run_test.pl rtps 1to1 large
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS RTPS
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl rtps_disc 12to12 small"
  COMMAND run_test.pl rtps_disc 12to12 small
  LABELS RTPS
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl shmem 1to1 small"
  COMMAND run_test.pl shmem 1to1 small
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS SHMEM
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl shmem 1to1 large"
  COMMAND run_test.pl shmem 1to1 large
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS SHMEM
)


add_dds_test("tests/DCPS/ManyToMany/run_test.pl tcp 20to20 small orb_csdtp"
  COMMAND run_test.pl tcp 20to20 small orb_csdtp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)

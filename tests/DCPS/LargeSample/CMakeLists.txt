requires(OWNERSHIP_PROFILE)

add_ace_lib(DDS_LargeSample_idl
  OUTPUT_NAME DDS_LargeSample_idl
  FOLDER tests/DCPS/LargeSample
  DEFINE_SYMBOL LARGESAMPLE_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_LargeSample_idl
  DDS_IDL_FLAGS -Wb,export_macro=LargeSample_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=LargeSample_export.h
                -Wb,stub_export_macro=LargeSample_Export
                -SS
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_LargeSample_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  FOLDER tests/DCPS/LargeSample
  LINK_LIBRARIES DDS_LargeSample_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(DDS_LargeSample_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  FOLDER tests/DCPS/LargeSample
  LINK_LIBRARIES DDS_LargeSample_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


add_dds_test("tests/DCPS/LargeSample/run_test.pl"
  COMMAND run_test.pl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/LargeSample/run_test.pl udp"
  COMMAND run_test.pl udp
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
)


add_dds_test("tests/DCPS/LargeSample/run_test.pl multicast"
  COMMAND run_test.pl multicast
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST
)


add_dds_test("tests/DCPS/LargeSample/run_test.pl multicast_async"
  COMMAND run_test.pl multicast_async
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS MCAST
)


add_dds_test("tests/DCPS/LargeSample/run_test.pl shmem"
  COMMAND run_test.pl shmem
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  LABELS SHMEM
)


add_dds_test("tests/DCPS/LargeSample/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS RTPS HOST
)

requires(OWNERSHIP_PROFILE)

add_ace_lib(DDS_LargeSample_Idl
  OUTPUT_NAME DDS_LargeSample_Idl
  FOLDER tests/DCPS/LargeSample
  DEFINE_SYMBOL LARGESAMPLE_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_LargeSample_Idl
  DDS_IDL_FLAGS -Wb,export_macro=LargeSample_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=LargeSample_export.h
                -Wb,stub_export_macro=LargeSample_Export
                -SS
  IDL_FILES Messenger.idl
)


add_ace_exe(DDS_LargeSample_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/LargeSample
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_LargeSample_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_LargeSample_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


add_ace_exe(DDS_LargeSample_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/LargeSample
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES DDS_LargeSample_Idl
                 OpenDDS_Dcps
)
target_cxx_sources(DDS_LargeSample_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


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

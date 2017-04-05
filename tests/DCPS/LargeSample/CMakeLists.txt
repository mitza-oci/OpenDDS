ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE)

ace_add_lib(DDS_LargeSample_Idl
  OUTPUT_NAME DDS_LargeSample_Idl

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


ace_add_exe(DDS_LargeSample_Publisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_LargeSample_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_LargeSample_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(DDS_LargeSample_Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 DDS_LargeSample_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_LargeSample_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/LargeSample/run_test.pl"
  COMMAND run_test.pl
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/LargeSample/run_test.pl udp"
  COMMAND run_test.pl udp
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
)


dds_add_test("tests/DCPS/LargeSample/run_test.pl multicast"
  COMMAND run_test.pl multicast
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS MCAST
)


dds_add_test("tests/DCPS/LargeSample/run_test.pl multicast_async"
  COMMAND run_test.pl multicast_async
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS MCAST
)


dds_add_test("tests/DCPS/LargeSample/run_test.pl shmem"
  COMMAND run_test.pl shmem
  REQUIRES "NOT OPENDDS_SAFETY_PROFILE"
  LABELS SHMEM
)


dds_add_test("tests/DCPS/LargeSample/run_test.pl rtps"
  COMMAND run_test.pl rtps
  LABELS RTPS HOST
)

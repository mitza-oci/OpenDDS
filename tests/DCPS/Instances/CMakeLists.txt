project(Instances CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(OPENDDS_HAS_OWNERSHIP_PROFILE)

ace_add_lib(DDS_Instances_Idl
  OUTPUT_NAME DDS_Instances_Idl
  DEFINE_SYMBOL INSTANCESLIB_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Instances_Idl
  DDS_IDL_FLAGS -Wb,export_macro=InstancesLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=InstancesLib_Export
                -Wb,export_include=instanceslib_export.h
                -SS
  IDL_FILES KeyedData.idl
            NoKeyData.idl
)


ace_add_exe(Instances_Publisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 TestUtils
                 DDS_Instances_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Instances_Publisher
  SOURCE_FILES Publisher.cpp
)


ace_add_exe(Instances_Subscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 TestUtils
                 DDS_Instances_Idl
                 OpenDDS_Model
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Instances_Subscriber
  SOURCE_FILES Subscriber.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Instances/run_test.pl single_instance single_datawriter keyed"
  COMMAND run_test.pl single_instance single_datawriter keyed
  LABELS DCPS_MIN
)


dds_add_test("tests/DCPS/Instances/run_test.pl single_instance single_datawriter nokey"
  COMMAND run_test.pl single_instance single_datawriter nokey
  LABELS DCPS_MIN
)


dds_add_test("tests/DCPS/Instances/run_test.pl multiple_instance single_datawriter keyed"
  COMMAND run_test.pl multiple_instance single_datawriter keyed
)


dds_add_test("tests/DCPS/Instances/run_test.pl multiple_instance single_datawriter nokey"
  COMMAND run_test.pl multiple_instance single_datawriter nokey
)


dds_add_test("tests/DCPS/Instances/run_test.pl single_instance multiple_datawriter keyed"
  COMMAND run_test.pl single_instance multiple_datawriter keyed
)


dds_add_test("tests/DCPS/Instances/run_test.pl single_instance multiple_datawriter nokey"
  COMMAND run_test.pl single_instance multiple_datawriter nokey
)


dds_add_test("tests/DCPS/Instances/run_test.pl multiple_instance multiple_datawriter keyed"
  COMMAND run_test.pl multiple_instance multiple_datawriter keyed
)


dds_add_test("tests/DCPS/Instances/run_test.pl multiple_instance multiple_datawriter nokey"
  COMMAND run_test.pl multiple_instance multiple_datawriter nokey
)

project(Instances CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE)

add_ace_lib(DDS_Instances_Idl
  OUTPUT_NAME DDS_Instances_Idl
  FOLDER tests/DCPS/Instances
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


add_ace_exe(Instances_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Instances
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES TestUtils
                 OpenDDS_Dcps
                 DDS_Instances_Idl
)
target_cxx_sources(Instances_Publisher
  SOURCE_FILES Publisher.cpp
)


add_ace_exe(Instances_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Instances
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Model
                 TestUtils
                 DDS_Instances_Idl
)
target_cxx_sources(Instances_Subscriber
  SOURCE_FILES Subscriber.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Instances/run_test.pl single_instance single_datawriter keyed"
  COMMAND run_test.pl single_instance single_datawriter keyed
  LABELS DCPS_MIN
)


add_dds_test("tests/DCPS/Instances/run_test.pl single_instance single_datawriter nokey"
  COMMAND run_test.pl single_instance single_datawriter nokey
  LABELS DCPS_MIN
)


add_dds_test("tests/DCPS/Instances/run_test.pl multiple_instance single_datawriter keyed"
  COMMAND run_test.pl multiple_instance single_datawriter keyed
)


add_dds_test("tests/DCPS/Instances/run_test.pl multiple_instance single_datawriter nokey"
  COMMAND run_test.pl multiple_instance single_datawriter nokey
)


add_dds_test("tests/DCPS/Instances/run_test.pl single_instance multiple_datawriter keyed"
  COMMAND run_test.pl single_instance multiple_datawriter keyed
)


add_dds_test("tests/DCPS/Instances/run_test.pl single_instance multiple_datawriter nokey"
  COMMAND run_test.pl single_instance multiple_datawriter nokey
)


add_dds_test("tests/DCPS/Instances/run_test.pl multiple_instance multiple_datawriter keyed"
  COMMAND run_test.pl multiple_instance multiple_datawriter keyed
)


add_dds_test("tests/DCPS/Instances/run_test.pl multiple_instance multiple_datawriter nokey"
  COMMAND run_test.pl multiple_instance multiple_datawriter nokey
)

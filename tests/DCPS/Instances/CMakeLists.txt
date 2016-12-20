project(Instances CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(OWNERSHIP_PROFILE)

add_ace_lib(DDS_Instances_idl
  OUTPUT_NAME DDS_Instances_idl
  FOLDER tests/DCPS/Instances
  DEFINE_SYMBOL INSTANCESLIB_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_Instances_idl
  DDS_IDL_FLAGS -Wb,export_macro=InstancesLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=InstancesLib_Export
                -Wb,export_include=instanceslib_export.h
                -SS
  IDL_FILES KeyedData.idl
            NoKeyData.idl
)

add_ace_exe(Instances_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
  FOLDER tests/DCPS/Instances
  LINK_LIBRARIES TestUtils
                 DDS_Instances_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(Instances_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES Subscriber.cpp
  FOLDER tests/DCPS/Instances
  LINK_LIBRARIES TestUtils
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ${DCPS_TRANSPORTS_FOR_TEST}
                 DDS_Instances_idl
                 OpenDDS_Model
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
link_test_files_to_build_tree()


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

project(Messenger_Imr CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(
         "TARGET TAO_Svc_Utils"
         "TARGET ImR_Locator_Service"
         "TARGET ImR_Activator_Service"
         "TARGET tao_imr"
         "NOT OPENDDS_SAFETY_PROFILE"
)


ace_add_lib(DDS_Messenger_Imr_Idl
  OUTPUT_NAME DDS_Messenger_Imr_Idl
  DEFINE_SYMBOL MESSENGER_IMR_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Messenger_Imr_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_Imr_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_Imr_export.h
                -Wb,stub_export_macro=Messenger_Imr_Export
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_Messenger_Imr_Publisher
  OUTPUT_NAME publisher

  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_Messenger_Imr_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Messenger_Imr_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(DDS_Messenger_Imr_Subscriber
  OUTPUT_NAME subscriber

  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_Messenger_Imr_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Messenger_Imr_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)


if (TAO_INSTALL_DIR)
  ## we use TAO_INSTALL_DIR to check if tao_nsadd is imported or not;
  ## TAO_INSTALL_DIR is only defined when TAO is not imported
  set(replace_tao_imr "\$ENV{ACE_ROOT}/bin/tao_imr" "$<TARGET_PROPERTY:tao_imr,RUNTIME_OUTPUT_DIRECTORY>/$<TARGET_PROPERTY:tao_imr,OUTPUT_NAME>")
else()
  set(replace_tao_imr "\$ENV{ACE_ROOT}/bin/tao_imr" "$<TARGET_PROPERTY:tao_imr,LOCATION>")
endif()

set(replacement_list replace_tao_imr)

if (CMAKE_CONFIGURATION_TYPES AND TAO_INSTALL_DIR)
  # we cannot ignore subdir when the IMR executable are built with DDS
  set(shoudnt_ignore_exesubdir "\$imr_util->IgnoreExeSubDir(1)\;" " ")
  list(APPEND replacement_list shoudnt_ignore_exesubdir)
endif()

dds_configure_test_files(${replacement_list})

dds_add_test("examples/DCPS/Messenger_Imr/run_test.pl"
  COMMAND run_test.pl
)

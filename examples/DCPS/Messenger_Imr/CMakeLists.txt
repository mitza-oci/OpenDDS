project(Messenger_Imr CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires("NOT MINIMUM_CORBA"
         "NOT CORBA_E_MICRO"
         "NOT CORBA_E_COMPACT"
         "TARGET TAO_Svc_Utils"
         "TARGET tao_imr_locator"
         "TARGET tao_imr_activator"
         "TARGET tao_imr"
         NO_OPENDDS_SAFETY_PROFILE
)

ace_add_lib(DDS_Messenger_Imr_Idl
  OUTPUT_NAME DDS_Messenger_Imr_Idl
  FOLDER examples/DCPS/Messenger_Imr
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
  FOLDER examples/DCPS/Messenger_Imr
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_Messenger_Imr_Idl
)
ace_target_cxx_sources(DDS_Messenger_Imr_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)


ace_add_exe(DDS_Messenger_Imr_Subscriber
  OUTPUT_NAME subscriber
  FOLDER examples/DCPS/Messenger_Imr
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 DDS_Messenger_Imr_Idl
)
ace_target_cxx_sources(DDS_Messenger_Imr_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)


include(${DDS_ROOT}/cmake/dds_add_test.cmake)
file(READ "run_test.pl" RUN_TEST_CONTENT)
string(REPLACE "\$orbsvcs{'ImplRepo_Service'}" "\"$<TARGET_FILE:tao_imr_locator>\"" RUN_TEST_CONTENT ${RUN_TEST_CONTENT})
string(REPLACE "\$orbsvcs{'ImR_Activator'}" "\"$<TARGET_FILE:tao_imr_activator>\"" RUN_TEST_CONTENT ${RUN_TEST_CONTENT})
string(REPLACE "\$ENV{ACE_ROOT}/bin/tao_imr" "$<TARGET_FILE:tao_imr>" RUN_TEST_CONTENT ${RUN_TEST_CONTENT})
file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/run_test.pl CONTENT ${RUN_TEST_CONTENT})

file(COPY pub.ini sub.ini
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

dds_add_test("examples/DCPS/Messenger_Imr/run_test.pl"
  COMMAND run_test.pl
)

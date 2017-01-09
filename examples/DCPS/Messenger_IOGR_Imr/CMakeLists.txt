
project(Messenger_IOGR_Imr CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_requires("TARGET ImR_Locator_Service"
             "TARGET ImR_Activator_Service"
             "TARGET tao_imr"
             NO_OPENDDS_SAFETY_PROFILE
)

ace_add_lib(DDS_Messenger_IOGR_Imr_Idl
  OUTPUT_NAME DDS_Messenger_IOGR_Imr_Idl
  FOLDER examples/DCPS/Messenger_IOGR_Imr
  DEFINE_SYMBOL MESSENGER_IOGR_IMR_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_Messenger_IOGR_Imr_Idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_IOGR_Imr_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_IOGR_Imr_export.h
                -Wb,stub_export_macro=Messenger_IOGR_Imr_Export
  IDL_FILES Messenger.idl
)


ace_add_exe(DDS_Messenger_IOGR_Imr_Aggregator
  OUTPUT_NAME Aggregator
  FOLDER examples/DCPS/Messenger_IOGR_Imr
  ASPECTS NEGOTIATE_CODESETS
          TAO
  LINK_LIBRARIES TAO_FT_ServerORB
                 TAO_AnyTypeCode
                 TAO_FT_ClientORB
                 TAO_Valuetype
                 TAO_IORManip
                 TAO_PortableServer
)
ace_target_cxx_sources(DDS_Messenger_IOGR_Imr_Aggregator
  SOURCE_FILES Aggregator.cpp
  HEADER_FILES Aggregator.h
)


ace_add_exe(DDS_Messenger_IOGR_Imr_Publisher
  OUTPUT_NAME publisher
  FOLDER examples/DCPS/Messenger_IOGR_Imr
  LINK_LIBRARIES DDS_Messenger_IOGR_Imr_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Messenger_IOGR_Imr_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)
target_cxx_sources(DDS_Messenger_IOGR_Imr_Publisher
  SOURCE_FILES Writer.cpp
               publisher.cpp
  HEADER_FILES Writer.h
)



ace_add_exe(DDS_Messenger_IOGR_Imr_Subscriber
  OUTPUT_NAME subscriber
  FOLDER examples/DCPS/Messenger_IOGR_Imr
  LINK_LIBRARIES DDS_Messenger_IOGR_Imr_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_Messenger_IOGR_Imr_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
)

file(READ "run_test.pl" RUN_TEST_CONTENT)
string(REPLACE "\$orbsvcs{'ImplRepo_Service'}" "\"$<TARGET_FILE:ImR_Locator_Service>\"" RUN_TEST_CONTENT ${RUN_TEST_CONTENT})
string(REPLACE "\$orbsvcs{'ImR_Activator'}" "\"$<TARGET_FILE:ImR_Activator_Service>\"" RUN_TEST_CONTENT ${RUN_TEST_CONTENT})
string(REPLACE "\$ENV{ACE_ROOT}/bin/tao_imr" "$<TARGET_FILE:tao_imr>" RUN_TEST_CONTENT ${RUN_TEST_CONTENT})
file(GENERATE OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/run_test.pl CONTENT ${RUN_TEST_CONTENT})

file(COPY pub.ini sub.ini
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

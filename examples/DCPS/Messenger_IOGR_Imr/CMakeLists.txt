
project(Messenger_IOGR_Imr CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()

find_package(TAO_orbsvcs REQUIRED CONFIG)

add_ace_lib(DDS_Messenger_IOGR_Imr_idl
  OUTPUT_NAME DDS_Messenger_IOGR_Imr_idl
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  FOLDER examples/DCPS/Messenger_IOGR_Imr
  DEFINE_SYMBOL MESSENGER_IOGR_IMR_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
add_dds_idl_files(
  TARGETS DDS_Messenger_IOGR_Imr_idl
  DDS_IDL_FLAGS -Wb,export_macro=Messenger_IOGR_Imr_Export
  TAO_IDL_FLAGS -Wb,stub_export_include=Messenger_IOGR_Imr_export.h
                -Wb,stub_export_macro=Messenger_IOGR_Imr_Export
  IDL_FILES Messenger.idl
)

add_ace_exe(DDS_Messenger_IOGR_Imr_Aggregator
  OUTPUT_NAME Aggregator
  SOURCE_FILES Aggregator.cpp
  COMPILE_DEFINITIONS TAO_EXPLICIT_NEGOTIATE_CODESETS
  HEADER_FILES Aggregator.h
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  FOLDER examples/DCPS/Messenger_IOGR_Imr
  LINK_LIBRARIES TAO_FT_ServerORB
                 TAO_FT_ClientORB
                 TAO_Codeset
                 TAO_IORManip
                 TAO
                 TAO_PortableServer
)

add_ace_exe(DDS_Messenger_IOGR_Imr_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               Writer.cpp
  HEADER_FILES Writer.h
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  FOLDER examples/DCPS/Messenger_IOGR_Imr
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_Messenger_IOGR_Imr_idl
                 OpenDDS_Dcps
)

add_ace_exe(DDS_Messenger_IOGR_Imr_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
  HEADER_FILES DataReaderListener.h
  REQUIRES NO_OPENDDS_SAFETY_PROFILE
  FOLDER examples/DCPS/Messenger_IOGR_Imr
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DDS_Messenger_IOGR_Imr_idl
                 OpenDDS_Dcps
)
#####################################
link_test_files_to_build_tree()
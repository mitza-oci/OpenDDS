
project(PubScalability CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(PubScalability_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES pub_main.cpp
               PubDriver.cpp
               InstanceDataMap.cpp
               Writer.cpp
  HEADER_FILES PubDriver.h
               InstanceDataMap.h
               Writer.h
  FOLDER tests/DCPS/PubScalability
  LINK_LIBRARIES PubScalability_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_exe(PubScalability_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES sub_main.cpp
               SubDriver.cpp
               DataReaderListener.cpp
  HEADER_FILES SubDriver.h
               DataReaderListener.h
  FOLDER tests/DCPS/PubScalability
  LINK_LIBRARIES PubScalability_idl
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

add_ace_lib(PubScalability_idl
  OUTPUT_NAME PubScalability_idl
  FOLDER tests/DCPS/PubScalability
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS PubScalability_idl
  DDS_IDL_FLAGS -Wb,export_macro=SampleTypeLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=SampleTypeLib_Export
                -Wb,export_include=sampletypelib_export.h
                -SS
  IDL_FILES SampleType.idl
)

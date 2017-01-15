
project(PubScalability CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(PubScalability_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/PubScalability
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 PubScalability_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(PubScalability_Publisher
  SOURCE_FILES InstanceDataMap.cpp
               PubDriver.cpp
               Writer.cpp
               pub_main.cpp
  HEADER_FILES InstanceDataMap.h
               PubDriver.h
               Writer.h
)


ace_add_exe(PubScalability_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/PubScalability
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 PubScalability_Idl
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(PubScalability_Subscriber
  SOURCE_FILES DataReaderListener.cpp
               SubDriver.cpp
               sub_main.cpp
  HEADER_FILES DataReaderListener.h
               SubDriver.h
)


ace_add_lib(PubScalability_Idl
  OUTPUT_NAME PubScalability_Idl
  FOLDER tests/DCPS/PubScalability
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS PubScalability_Idl
  DDS_IDL_FLAGS -Wb,export_macro=SampleTypeLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=SampleTypeLib_Export
                -Wb,export_include=sampletypelib_export.h
                -SS
  IDL_FILES SampleType.idl
)


ace_add_lib(DDS_ManyTopicMultiProcess_Idl
  OUTPUT_NAME DDS_ManyTopicMultiProcess_Idl
  DEFINE_SYMBOL MANYFOOLIB_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_ManyTopicMultiProcess_Idl
  DDS_IDL_FLAGS -Wb,export_macro=ManyFooLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=ManyFooLib_Export
                -Wb,export_include=manyfoolib_export.h
                -SS
  IDL_FILES Foo1Def.idl
            Foo4Def.idl
)


ace_add_exe(ManyTopicMultiProcessPublisher
  OUTPUT_NAME publisher
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 common
                 DDS_ManyTopicMultiProcess_Idl
                 OpenDDS_Model
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(ManyTopicMultiProcessPublisher
  SOURCE_FILES DataReaderListener.cpp
               DataReaderListener1.cpp
               Writer.cpp
               publisher.cpp
  HEADER_FILES DataReaderListener.h
               DataReaderListener1.h
               Writer.h
               common.h
)


ace_add_exe(ManyTopicMultiProcessSubscriber
  OUTPUT_NAME subscriber
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 common
                 DDS_ManyTopicMultiProcess_Idl
                 OpenDDS_Model
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(ManyTopicMultiProcessSubscriber
  SOURCE_FILES DataReaderListener.cpp
               DataReaderListener1.cpp
               DataReaderListener4.cpp
               Writer.cpp
               subscriber.cpp
  HEADER_FILES DataReaderListener.h
               DataReaderListener1.h
               DataReaderListener4.h
               Writer.h
               common.h
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/ManyTopicMultiProcess/run_test.pl"
  COMMAND run_test.pl
)

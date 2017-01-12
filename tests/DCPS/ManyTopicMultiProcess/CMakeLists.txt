ace_add_lib(DDS_ManyTopicMultiProcess_Idl
  OUTPUT_NAME DDS_ManyTopicMultiProcess_Idl
  FOLDER tests/DCPS/ManyTopicMultiProcess
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
  FOLDER tests/DCPS/ManyTopicMultiProcess
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Model
                 common
                 DDS_ManyTopicMultiProcess_Idl
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
  FOLDER tests/DCPS/ManyTopicMultiProcess
  ASPECTS DCPS_DEFAULT_DISCOVERY
          DCPS_TRANSPORTS_FOR_TEST
  LINK_LIBRARIES OpenDDS_Model
                 common
                 DDS_ManyTopicMultiProcess_Idl
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

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/ManyTopicMultiProcess/run_test.pl"
  COMMAND run_test.pl
)

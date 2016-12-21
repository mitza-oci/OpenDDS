add_ace_lib(DDS_ManyTopicMultiProcess_idl
  OUTPUT_NAME DDS_ManyTopicMultiProcess_idl
  FOLDER tests/DCPS/ManyTopicMultiProcess
  DEFINE_SYMBOL MANYFOOLIB_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DDS_ManyTopicMultiProcess_idl
  DDS_IDL_FLAGS -Wb,export_macro=ManyFooLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=ManyFooLib_Export
                -Wb,export_include=manyfoolib_export.h
                -SS
  IDL_FILES Foo1Def.idl
            Foo4Def.idl
)

add_ace_exe(ManyTopicMultiProcessPublisher
  OUTPUT_NAME publisher
  SOURCE_FILES publisher.cpp
               DataReaderListener.cpp
               DataReaderListener1.cpp
               Writer.cpp
  HEADER_FILES common.h
               DataReaderListener.h
               DataReaderListener1.h
               Writer.h
  FOLDER tests/DCPS/ManyTopicMultiProcess
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ${DCPS_TRANSPORTS_FOR_TEST}
                 common
                 DDS_ManyTopicMultiProcess_idl
                 OpenDDS_Model
)

add_ace_exe(ManyTopicMultiProcessSubscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES subscriber.cpp
               DataReaderListener.cpp
               DataReaderListener1.cpp
               DataReaderListener4.cpp
               Writer.cpp
  HEADER_FILES common.h
               DataReaderListener.h
               DataReaderListener1.h
               DataReaderListener4.h
               Writer.h
  FOLDER tests/DCPS/ManyTopicMultiProcess
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ${DCPS_TRANSPORTS_FOR_TEST}
                 common
                 DDS_ManyTopicMultiProcess_idl
                 OpenDDS_Model
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/ManyTopicMultiProcess/run_test.pl"
  COMMAND run_test.pl
)

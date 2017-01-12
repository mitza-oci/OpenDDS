
ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_lib(OpenDDS_InfoRepoDiscovery
  PACKAGE OpenDDS
  FOLDER dds/DCPS
  DEFINE_SYMBOL OPENDDS_INFOREPODISCOVERY_BUILD_DLL
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR} ${DDS_ROOT}/dds
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps OpenDDS_Tcp
)

ace_target_cxx_sources(OpenDDS_InfoRepoDiscovery
  SOURCE_FILES DataReaderRemoteImpl.cpp
               DataWriterRemoteImpl.cpp
               FailoverListener.cpp
               InfoRepoDiscovery.cpp
  HEADER_FILES DataReaderRemoteImpl.h
               DataWriterRemoteImpl.h
               FailoverListener.h
               InfoRepoDiscovery.h
               InfoRepoDiscovery_Export.h
)


tao_idl_sources(
  TARGETS OpenDDS_InfoRepoDiscovery
  IDL_FLAGS -Wb,export_macro=OpenDDS_InfoRepoDiscovery_Export -Wb,export_include=dds/DCPS/InfoRepoDiscovery/InfoRepoDiscovery_Export.h
  IDL_FILES Info.idl
            DataReaderRemote.idl
            DataWriterRemote.idl
)



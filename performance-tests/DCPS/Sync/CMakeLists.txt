

ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_lib(Sync_Serverlib
  OUTPUT_NAME SyncServer
  REQUIRES "NOT TAO_HAS_MINIMUM_CORBA"

  PUBLIC_INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}
                             ${CMAKE_CURRENT_BINARY_DIR}
  PUBLIC_LINK_LIBRARIES TAO_PortableServer
                        TAO_IORTable
)
ace_target_cxx_sources(Sync_Serverlib
  SOURCE_FILES SyncServer_i.cpp
  HEADER_FILES SyncServer_i.h
)


ace_add_lib(Sync_Clientlib
  OUTPUT_NAME SyncClient

  PUBLIC_INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}
                             ${CMAKE_CURRENT_BINARY_DIR}
  PUBLIC_LINK_LIBRARIES TAO_PortableServer
)
ace_target_cxx_sources(Sync_Clientlib
  SOURCE_FILES SyncClient_i.cpp
  HEADER_FILES SyncClient_i.h
)


ace_add_exe(Sync_Server
  OUTPUT_NAME syncServer
  REQUIRES "NOT TAO_HAS_MINIMUM_CORBA"

  LINK_LIBRARIES Sync_Serverlib
                 TAO_PortableServer
                 TAO_IORTable
)
ace_target_cxx_sources(Sync_Server
  SOURCE_FILES SyncServer.cpp
)


tao_idl_sources(
  TARGETS Sync_Clientlib
          Sync_Serverlib
  IDL_FLAGS -Sa -St
            -Wb,export_macro=Sync_Export
            -Wb,export_include=Sync_export.h
  IDL_FILES Sync.idl
)


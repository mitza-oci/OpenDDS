

requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_lib(Sync_ServerLib
  OUTPUT_NAME SyncServer
  SOURCE_FILES SyncS.cpp
               SyncServer_i.cpp
  HEADER_FILES SyncServer_i.h
  REQUIRES "NOT MINIMUM_CORBA"
  FOLDER performance-tests/DCPS/Sync
  PUBLIC_INCLUDE_DIRECTORIES ${CMAKE_CURRENT_BINARY_DIR}
  PUBLIC_LINK_LIBRARIES TAO_PortableServer
                        TAO_IORTable
)

add_ace_lib(Sync_ClientLib
  OUTPUT_NAME SyncClient
  SOURCE_FILES SyncS.cpp
               SyncClient_i.cpp
  HEADER_FILES SyncClient_i.h
  FOLDER performance-tests/DCPS/Sync
  PUBLIC_INCLUDE_DIRECTORIES ${CMAKE_CURRENT_BINARY_DIR}
  PUBLIC_LINK_LIBRARIES TAO_PortableServer
)

add_ace_exe(Sync_Server
  OUTPUT_NAME syncServer
  SOURCE_FILES SyncServer.cpp
  REQUIRES "NOT MINIMUM_CORBA"
  FOLDER performance-tests/DCPS/Sync
  LINK_LIBRARIES Sync_ServerLib
                 TAO_PortableServer
                 TAO_IORTable
)

add_tao_idl_files(
  TARGETS Sync_ServerLib
          Sync_ClientLib
  IDL_FLAGS -Wb,export_macro=Sync_Export
            -Wb,export_include=Sync_export.h
  IDL_FILES Sync.idl
)

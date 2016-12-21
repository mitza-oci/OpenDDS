
if (NO_OPENDDS_SAFETY_PROFILE)

  if (BUILD_IN_TOPIC)
    set(optional_build_in_topic_library OpenDDS_Tcp)
  endif()

  find_package(TAO_orbsvcs)

  add_package_lib(OpenDDS_InfoRepoLib
    PACKAGE OpenDDS
    DEFINE_SYMBOL OPENDDS_INFOREPOLIB_BUILD_DLL
    PUBLIC_INCLUDE_DIRECTORIES $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    PUBLIC_LINK_LIBRARIES TAO_IORTable OpenDDS_InfoRepoDiscovery TAO_ImR_Client TAO_Svc_Utils ${optional_build_in_topic_library}
  )

  target_cxx_sources(OpenDDS_InfoRepoLib
    SOURCE_FILES  DCPSInfo_i.cpp
                  DcpsInfo_pch.cpp
                  DCPS_IR_Domain.cpp
                  DCPS_IR_Participant.cpp
                  DCPS_IR_Publication.cpp
                  DCPS_IR_Subscription.cpp
                  DCPS_IR_Topic.cpp
                  DCPS_IR_Topic_Description.cpp
                  DomainParticipantListener_i.cpp
                  FederationId.cpp
                  PersistenceUpdater.cpp
                  UpdateManager.cpp
    HEADER_FILES  DCPSInfo_i.h
                  DcpsInfo_pch.h
                  DCPS_IR_Domain.h
                  DCPS_IR_Participant.h
                  DCPS_IR_Publication.h
                  DCPS_IR_Subscription.h
                  DCPS_IR_Topic.h
                  DCPS_IR_Topic_Description.h
                  DomainParticipantListener_i.h
                  FederationId.h
                  PersistenceUpdater.h
                  UpdateManager.h
    TEMPLATE_FILES UpdateManager_T.cpp
  )

  #############################################
  add_package_lib(OpenDDS_Federator
    PACKAGE OpenDDS
    DEFINE_SYMBOL OPENDDS_FEDERATOR_BUILD_DLL
    PUBLIC_INCLUDE_DIRECTORIES $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    PUBLIC_LINK_LIBRARIES OpenDDS_InfoRepoLib
  )

  target_cxx_sources(OpenDDS_Federator
    SOURCE_FILES  FederatorConfig.cpp
                  FederatorManagerImpl.cpp
                  FederatorManagerImpl_updates.cpp
                  InfoRepoMulticastResponder.cpp
    HEADER_FILES  federator_export.h
                  FederatorConfig.h
                  FederatorManagerImpl.h
                  InfoRepoMulticastResponder.h
                  UpdateListener_T.h
                  UpdateReceiver_T.h
                  UpdateProcessor_T.h
   INLINE_FILES   FederatorConfig.inl
                  FederatorManagerImpl.inl
   TEMPLATE_FILES UpdateListener_T.cpp
                  UpdateReceiver_T.cpp
                  UpdateProcessor_T.cpp
  )

  dds_idl_sources(
    TARGETS OpenDDS_Federator
    DDS_IDL_FLAGS -Wb,export_macro=OpenDDS_Federator_Export -Wb,export_include=federator_export.h -Wb,pch_include=DcpsInfo_pch.h
    TAO_IDL_FLAGS -Wb,export_macro=OpenDDS_Federator_Export -Wb,export_include=federator_export.h -Wb,pch_include=DcpsInfo_pch.h
    IDL_FILES Federator.idl
  )

  ###################################################
  add_package_lib(OpenDDS_InfoRepoServ
    PACKAGE OpenDDS
    DEFINE_SYMBOL OPENDDS_INFOREPOSERV_BUILD_DLL
    PUBLIC_LINK_LIBRARIES OpenDDS_Federator
  )

  target_cxx_sources(OpenDDS_InfoRepoServ
    SOURCE_FILES DCPSInfoRepoServ.cpp
    HEADER_FILES DCPSInfoRepoServ.h
  )

  #####################################################
  add_package_exe(DCPSInfoRepo
    PACKAGE OpenDDS
    LINK_LIBRARIES OpenDDS_InfoRepoServ
  )

  target_cxx_sources(DCPSInfoRepo
    SOURCE_FILES DCPSInfoRepo.cpp
  )

endif()

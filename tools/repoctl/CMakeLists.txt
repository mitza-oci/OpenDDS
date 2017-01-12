ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(repoctl
  PACKAGE OpenDDS
  FOLDER tool
  ASPECT DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES TAO_IORTable TAO_Svc_Utils TAO_ImR_Client TAO_IORManip OpenDDS_InfoRepoLib OpenDDS_Federator OpenDDS_Tcp
)

target_sources(repoctl
  PRIVATE repoctl.cpp
)
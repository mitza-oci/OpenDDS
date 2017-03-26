ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(repoctl
  PACKAGE OpenDDS
  FOLDER tool
  LINK_LIBRARIES TAO_IORTable
                 TAO_Svc_Utils
                 TAO_ImR_Client
                 TAO_IORManip
                 OpenDDS_InfoRepoLib
                 OpenDDS_Federator
                 OpenDDS_Tcp
                 OpenDDS_Default_Discovery
)

ace_target_cxx_sources(repoctl
  SOURCE_FILES repoctl.cpp
)
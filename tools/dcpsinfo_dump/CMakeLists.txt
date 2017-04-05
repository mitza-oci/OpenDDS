
ace_requires("NOT OPENDDS_SAFETY_PROFILE")

ace_add_exe(dcpsinfo_dump
  FOLDER OpenDDS/tools
  PACKAGE OpenDDS
  LINK_LIBRARIES OpenDDS_Default_Discovery
)

ace_target_cxx_sources(dcpsinfo_dump
  SOURCE_FILES dump.cpp
)

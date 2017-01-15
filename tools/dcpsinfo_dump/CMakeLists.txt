
ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(dcpsinfo_dump
  FOLDER tools
  PACKAGE OpenDDS
  LINK_LIBRARIES OpenDDS_Default_Discovery
)

ace_target_cxx_sources(dcpsinfo_dump
  SOURCE_FILES dump.cpp
)

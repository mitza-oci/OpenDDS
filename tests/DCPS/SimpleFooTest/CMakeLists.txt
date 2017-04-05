

ace_add_exe(DcpsSimpleFooTest
  OUTPUT_NAME SimpleFooTest

  LINK_LIBRARIES DcpsFooType
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DcpsSimpleFooTest
  SOURCE_FILES main.cpp
)


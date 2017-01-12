

ace_add_exe(DcpsSimpleFooTest
  OUTPUT_NAME SimpleFooTest
  FOLDER tests/DCPS/SimpleFooTest
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
                 DcpsFooType
)
ace_target_cxx_sources(DcpsSimpleFooTest
  SOURCE_FILES main.cpp
)




add_ace_exe(DcpsSimpleFooTest
  OUTPUT_NAME SimpleFooTest
  SOURCE_FILES main.cpp
  FOLDER tests/DCPS/SimpleFooTest
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
                 DcpsFooType
)

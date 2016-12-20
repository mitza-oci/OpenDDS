

add_ace_exe(Reliability_Publisher
  OUTPUT_NAME publisher
  SOURCE_FILES Publisher.cpp
               ../Boilerplate.cpp
  FOLDER tests/DCPS/Reliability/pub
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../IDL
                      ${CMAKE_CURRENT_BINARY_DIR}/../IDL
                      ${CMAKE_CURRENT_SOURCE_DIR}/..
                      ${CMAKE_CURRENT_BINARY_DIR}/..
  LINK_LIBRARIES OpenDDS_Model
                 Reliability
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

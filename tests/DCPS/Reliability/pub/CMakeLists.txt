

ace_add_exe(Reliability_Publisher
  OUTPUT_NAME publisher
  FOLDER tests/DCPS/Reliability/pub
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../IDL
                      ${CMAKE_CURRENT_BINARY_DIR}/../IDL
                      ${CMAKE_CURRENT_SOURCE_DIR}/..
                      ${CMAKE_CURRENT_BINARY_DIR}/..
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Model
                 Reliability
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Reliability_Publisher
  SOURCE_FILES ../Boilerplate.cpp
               Publisher.cpp
)


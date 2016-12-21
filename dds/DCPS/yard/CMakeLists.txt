file(GLOB headers ${CMAKE_CURRENT_LIST_DIR}/*.hpp)

target_cxx_sources(OpenDDS_Dcps
  SUBGROUP "\\yard"
  HEADER_FILES ${headers}
)
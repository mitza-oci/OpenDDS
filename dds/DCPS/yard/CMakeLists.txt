file(GLOB headers ${CMAKE_CURRENT_LIST_DIR}/*.hpp)

add_target_files(OpenDDS_Dcps
  SUBGROUP "\\yard"
  HEADER_FILES ${headers}
)
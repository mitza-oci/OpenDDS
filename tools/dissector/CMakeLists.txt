
find_package(Wireshark CONFIG)

ace_requires(Wireshark_FOUND BUILD_SHARED_LIBS)

ace_add_lib(OpenDDS_Dissector
  DEFINE_SYMBOL DISSECTOR_BUILD_DLL
  FOLDER OpenDDS/tools
  COMPILE_DEFINITIONS NOMINMAX
  PUBLIC_INCLUDE_LIBRARIES ${Wireshark_INCLUDE_DIR}
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps ${Wireshark_LIBRARY}
  PACKAGE OpenDDS
)

ace_target_cxx_sources(OpenDDS_Dissector
  SOURCE_FILES giop_base.cpp
               packet-opendds.cpp
               packet-datawriter.cpp
               packet-repo.cpp
               plugin.cpp
               sample_dissector.cpp
               sample_manager.cpp
  HEADER_FILES dissector_export.h
               giop_base.h
               packet-opendds.h
               packet-datawriter.h
               packet-repo.h
               sample_dissector.h
               sample_manager.h
               ws_common.h
)

option(NO_ITL "" ON)
if (NO_ITL)
  target_compile_definitions(OpenDDS_Dissector PRIVATE NO_ITL)
else()
  target_include_directories(OpenDDS_Dissector PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/../IntermediateTypeLang/cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/../IntermediateTypeLang/cpp/rapidjson/include
  )
endif()
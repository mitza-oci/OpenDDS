
ace_requires(BUILT_IN_TOPICS)

ace_add_lib(OpenDDS_FACE
  PACKAGE OpenDDS
  FOLDER dds
  DEFINE_SYMBOL OPENDDS_FACE_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)

ace_target_cxx_sources(OpenDDS_FACE
  SOURCE_FILES FaceTSS.cpp
               StringManager.cpp
  HEADER_FILES FaceTSS.h
)

include(config/CMakeLists.txt)

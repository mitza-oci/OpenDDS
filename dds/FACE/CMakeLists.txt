
if (BUILT_IN_TOPICS)
  file(GLOB sources *.cpp config/*.cpp)

  add_package_lib(OpenDDS_FACE
    PACKAGE OpenDDS
    DEFINE_SYMBOL OPENDDS_FACE_BUILD_DLL
    PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
  )

  target_cxx_sources(OpenDDS_FACE
    SOURCE_FILES FaceTSS.cpp
                 StringManager.cpp
    HEADER_FILES FaceTSS.h
  )

  add_subdirectory(config)
endif()
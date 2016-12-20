if (NOT NO_OPENDDS_SAFETY_PROFILE)

  add_package_lib(OpenDDS_Corba
    PACKAGE OpenDDS
    DEFINE_SYMBOL TAO_BUILD_DLL
    INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/..
    PUBLIC_INCLUDE_DIRECTORIES ${TAO_ROOT}
    PUBLIC_LINK_LIBRARIES ACE
  )

  add_target_sources(OpenDDS_Corba
    SOURCE_FILES  Exception.cpp
                  Inlines.cpp
                  LocalObject.cpp
                  ORB_Misc.cpp
                  Object.cpp
                  String_Alloc.cpp
                  SystemException.cpp
    HEADER_FILES  Allocation_Macros.h
                  PolicyS.h
  )

endif()
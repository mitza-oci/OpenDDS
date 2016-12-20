if (NO_OPENDDS_SAFETY_PROFILE)
  set(dcps_link_libraries TAO_PortableServer TAO_BiDirGIOP)
else()
  set(dcps_link_libraries OpenDDS_Corba)
endif()

add_package_lib(OpenDDS_Dcps
  PACKAGE OpenDDS
  DEFINE_SYMBOL OPENDDS_DCPS_BUILD_DLL
  PUBLIC_COMPILE_DEFINITIONS "${DCPS_COMPILE_DEFINITIONS}"
  INCLUDE_DIRECTORIES "${CMAKE_CURRENT_SOURCE_DIR};${CMAKE_CURRENT_BINARY_DIR}"
  PUBLIC_INCLUDE_DIRECTORIES "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/..>;$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/..>"
  PUBLIC_LINK_LIBRARIES "${dcps_link_libraries}"
)


## set MSVC precompiled headers
if (MSVC)
   set_target_properties(OpenDDS_Dcps PROPERTIES COMPILE_FLAGS "/YuDCPS\\DdsDcps_pch.h")
   set_source_files_properties(DCPS/DdsDcps_pch.cpp PROPERTIES COMPILE_FLAGS "/YcDCPS\\DdsDcps_pch.h")
   list(APPEND dcps_compile_definitions NOMINMAX)
endif(MSVC)


# flags used by all directories under $DDS_ROOT/dds
list(APPEND TAO_BASE_IDL_FLAGS
  -Wb,versioning_begin=OPENDDS_BEGIN_VERSIONED_NAMESPACE_DECL
  -Wb,versioning_end=OPENDDS_END_VERSIONED_NAMESPACE_DECL
  -Wb,versioning_include=dds/Versioned_Namespace.h
)

list(APPEND DDS_BASE_IDL_FLAGS
  -Wb,versioning_begin=OPENDDS_BEGIN_VERSIONED_NAMESPACE_DECL
  -Wb,versioning_end=OPENDDS_END_VERSIONED_NAMESPACE_DECL
  -Wb,versioning_name=OPENDDS_VERSIONED_NAMESPACE_NAME
)

include(dcps_optional_safety.cmake)
include(CorbaSeq/CMakeLists.txt)
include(CORBA/tao/CMakeLists.txt)
include(DCPS/CMakeLists.txt)
include(DCPS/transport/framework/CMakeLists.txt)
include(DCPS/yard/CMakeLists.txt)

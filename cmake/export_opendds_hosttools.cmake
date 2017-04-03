
if (OPENDDS_SAFETY_PROFILE OR CMAKE_CROSSCOMPILING)
  return()
endif()

set(tools opendds_idl)
if (TARGET idl2jni)
  list(APPEND tools idl2jni)
endif()

get_target_property(IsTaoidlImported TAO_IDL_EXE IMPORTED)

if (IsTaoidlImported)
  file(GENERATE
       OUTPUT TAO_IDL_Targets.cmake
       INPUT ${CMAKE_CURRENT_LIST_DIR}/TAO_IDL_Targets.cmake.in)
else()
  list(APPEND tools TAO_IDL_EXE ace_gperf)
endif()

export(TARGETS ${tools}
       FILE OpenDDS_HostTools_Targets.cmake)


export(PACKAGE OpenDDS_HostTools)

write_basic_package_version_file(
  "OpenDDS_HostToolsConfigVersion.cmake"
  VERSION ${OpenDDS_PACKAGE_VERSION}
  COMPATIBILITY ExactVersion
)

configure_file(${CMAKE_CURRENT_LIST_DIR}/OpenDDS_HostToolsConfig.cmake.in OpenDDS_HostToolsConfig.cmake COPYONLY)
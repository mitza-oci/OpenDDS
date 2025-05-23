if(_OPENDDS_BUILD_HELPERS_CMAKE)
  return()
endif()
set(_OPENDDS_BUILD_HELPERS_CMAKE TRUE)

include(GNUInstallDirs)

include("${CMAKE_CURRENT_LIST_DIR}/opendds_utils.cmake")

set(_opendds_exec_perms
  OWNER_READ OWNER_WRITE OWNER_EXECUTE
  GROUP_READ GROUP_WRITE GROUP_EXECUTE
  WORLD_READ WORLD_EXECUTE)

# Load in build settings.
_opendds_read_ini("${OPENDDS_SOURCE_DIR}/build.ini" PREFIX _OPENDDS_BUILD)

function(_opendds_target target)
  # This is the name the target should be exported from CMake-build OpenDDS as
  # or imported in the MPC-built OpenDDS CMake package. For consistency and
  # convenience, alias it so we can use it within the OpenDDS CMake build.
  string(REPLACE "OpenDDS_" "" name "${target}")
  set(name "OpenDDS::${name}")
  get_target_property(target_type ${target} TYPE)
  if(target_type MATCHES "LIBRARY")
    add_library("${name}" ALIAS "${target}")
  else()
    add_executable("${name}" ALIAS "${target}")
  endif()
  set_target_properties(${target} PROPERTIES EXPORT_NAME "${name}")

  if(OPENDDS_COMPILE_WARNINGS STREQUAL "WARNING" OR OPENDDS_COMPILE_WARNINGS STREQUAL "ERROR")
    set(prefix "_OPENDDS_BUILD_${CMAKE_CXX_COMPILER_ID}_")
    string(REPLACE " " ";" outvar "${${prefix}warning}")
    target_compile_options(${target} PRIVATE ${outvar})
    if(OPENDDS_COMPILE_WARNINGS STREQUAL "ERROR")
      string(REPLACE " " ";" outvar "${${prefix}error}")
      target_compile_options(${target} PRIVATE ${outvar})
    endif()
  endif()
endfunction()

function(_opendds_library target)
  set(no_value_options BIGOBJ NO_INSTALL)
  set(single_value_options EXPORT_MACRO_PREFIX)
  set(multi_value_options)
  cmake_parse_arguments(arg
    "${no_value_options}" "${single_value_options}" "${multi_value_options}" ${ARGN})

  _opendds_target(${target})
  _opendds_cxx_std(${target} PUBLIC)
  target_link_libraries(${target} PUBLIC OpenDDS_Config)

  # Put library in BINARY_DIR/lib
  set_target_properties(${target} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${OPENDDS_LIB_DIR}"
    LIBRARY_OUTPUT_DIRECTORY "${OPENDDS_LIB_DIR}"
    ARCHIVE_OUTPUT_DIRECTORY "${OPENDDS_LIB_DIR}"
    POSITION_INDEPENDENT_CODE TRUE
    BUILD_RPATH "${OPENDDS_LIB_DIR}"
  )

  set(export_args)
  if(DEFINED arg_EXPORT_MACRO_PREFIX)
    list(APPEND export_args MACRO_PREFIX "${arg_EXPORT_MACRO_PREFIX}")
  endif()
  opendds_export_header(${target} EXISTING ${export_args})

  if(arg_BIGOBJ)
    opendds_bigobj(${target})
  endif()

  if(NOT arg_NO_INSTALL)
    install(TARGETS ${target}
      EXPORT opendds_targets
      LIBRARY
        DESTINATION ${CMAKE_INSTALL_LIBDIR}
        PERMISSIONS ${_opendds_exec_perms}
      RUNTIME
        DESTINATION ${CMAKE_INSTALL_LIBDIR}
        PERMISSIONS ${_opendds_exec_perms}
      FILE_SET HEADERS
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
      ARCHIVE DESTINATION lib
    )
  endif()
endfunction()

function(_opendds_executable target)
  set(no_value_options NO_INSTALL)
  set(single_value_options)
  set(multi_value_options)
  cmake_parse_arguments(arg
    "${no_value_options}" "${single_value_options}" "${multi_value_options}" ${ARGN})

  _opendds_target(${target})
  _opendds_cxx_std(${target} PRIVATE)
  target_link_libraries(${target} PRIVATE OpenDDS_Config)
  set_target_properties(${target} PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${OPENDDS_BIN_DIR}")

  if(NOT arg_NO_INSTALL)
    install(TARGETS ${target}
      EXPORT opendds_targets
      RUNTIME
        DESTINATION ${CMAKE_INSTALL_BINDIR}
        PERMISSIONS ${_opendds_exec_perms}
    )
  endif()
endfunction()

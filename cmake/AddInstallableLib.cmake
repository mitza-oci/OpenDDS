include(CMakeParseArguments)
include(CMakePackageConfigHelpers)

if (POLICY CMP0063)
  cmake_policy(SET CMP0063 NEW)
endif()

set(ADD_INSTALLABLE_LIB_MODULE_DIR ${CMAKE_CURRENT_LIST_DIR})


function(add_installable_lib target)
  set(oneValueArgs OUTPUT_NAME DEFINE_SYMBOL PACKAGE WHEN VERSION HEADER_ROOT)
  set(multiValueArgs SOURCES PUBLIC_HEADER
                     PUBLIC_HEADER_DIRS PUBLIC_LINK_LIBRARIES INCLUDE_DIRECTORIES PUBLIC_INCLUDE_DIRECTORIES
                     PUBLIC_COMPILE_DEFINITIONS HEADERS_INSTALL_DESTINATION)
  cmake_parse_arguments(_arg "SKIP_ON_MISSING_LINK_LIBS" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})


  if (_arg_SKIP_ON_MISSING_LINK_LIBS)
    foreach(DEP ${_arg_PUBLIC_LINK_LIBRARIES})
      if ((NOT TARGET ${DEP}) AND (NOT EXISTS ${DEP}))
        message("Skipping ${target} because it requires ${DEP}")
        return()
      endif()
    endforeach()
  endif()

  if ((NOT _arg_WHEN) OR (${${_arg_WHEN}}))

    add_library(${target} ${_arg_SOURCES})

    if (NOT _arg_OUTPUT_NAME)
      set(_arg_OUTPUT_NAME} ${target})
    endif()

    if (_arg_PACKAGE AND _arg_HEADERS_INSTALL_DESTINATION)
      if (NOT _arg_PUBLIC_HEADER)
        file(GLOB _arg_PUBLIC_HEADER *.h *.inl)
      endif(NOT _arg_PUBLIC_HEADER)
    endif(_arg_PACKAGE AND _arg_HEADERS_INSTALL_DESTINATION)

    set(myincludedir ${_arg_INCLUDE_DIRECTORIES} ${_arg_PUBLIC_INCLUDE_DIRECTORIES})

    set_target_properties(${target} PROPERTIES
                          OUTPUT_NAME "${_arg_OUTPUT_NAME}"
                          VERSION "${_arg_VERSION}"
                          SOVERSION "${_arg_VERSION}"
                          DEFINE_SYMBOL "${_arg_DEFINE_SYMBOL}"
                          PUBLIC_HEADER "${_arg_PUBLIC_HEADER}"
                          COMPILE_DEFINTTIONS "${_arg_PUBLIC_COMPILE_DEFINTTIONS}"
                          INTERFACE_COMPILE_DEFINITIONS "${_arg_PUBLIC_COMPILE_DEFINITIONS}"
                          INCLUDE_DIRECTORIES "${myincludedir}"
                          INTERFACE_INCLUDE_DIRECTORIES "${_arg_PUBLIC_INCLUDE_DIRECTORIES}"
                          LINK_LIBRARIES "${_arg_PUBLIC_LINK_LIBRARIES}"
                          INTERFACE_LINK_LIBRARIES "${_arg_PUBLIC_LINK_LIBRARIES}"
                        )

    if (_arg_PACKAGE)
      if (_arg_HEADER_ROOT)
        file(RELATIVE_PATH HEADERS_INSTALL_DESTINATION ${_arg_HEADER_ROOT} ${CMAKE_CURRENT_SOURCE_DIR})
      else(_arg_HEADER_ROOT)
        set(HEADERS_INSTALL_DESTINATION ${_arg_HEADERS_INSTALL_DESTINATION})
      endif(_arg_HEADER_ROOT)

      install(TARGETS ${target}
              EXPORT  "${_arg_PACKAGE}Targets"
              LIBRARY DESTINATION lib
              ARCHIVE DESTINATION lib
              PUBLIC_HEADER DESTINATION "$[INCLUDE_INSTALL_DIR]/${HEADERS_INSTALL_DESTINATION}")

      if (_arg_PUBLIC_HEADER_DIRS)
        install(DIRECTORY ${_arg_PUBLIC_HEADER_DIRS}
                DESTINATION "$[INCLUDE_INSTALL_DIR]/${HEADERS_INSTALL_DESTINATION}")
      endif(_arg_PUBLIC_HEADER_DIRS)
    endif(_arg_PACKAGE)
  else()
    message("${target} is disabled because ${_arg_WHEN} not satisfied")
  endif ((NOT _arg_WHEN) OR (${${_arg_WHEN}}))
endfunction()

function(export_package package_name)

  cmake_parse_arguments(_arg "" "VERSION" "CONFIG_OPTIONS;PREREQUISITE;EXTRA_CMAKE_FILES" ${ARGN} )

  write_basic_package_version_file(
    "${package_name}ConfigVersion.cmake"
    VERSION ${_arg_VERSION}
    COMPATIBILITY ExactVersion
  )

  export(EXPORT ${package_name}Targets
    FILE "${CMAKE_CURRENT_BINARY_DIR}/${package_name}Targets.cmake"
  )

  set(PREREQUISITE_PACKAGES ${_arg_PREREQUISITE})

  foreach(option_name ${_arg_CONFIG_OPTIONS})
    set(EXTRA_CONFIG_OPTIONS "${EXTRA_CONFIG_OPTIONS}set(${option_name} ${${option_name}})\n")
  endforeach()

  set(ConfigPackageLocation ${LIB_INSTALL_DIR}/cmake/${package_name})

  if (_arg_EXTRA_CMAKE_FILES)
    install(
      FILES
        ${_arg_EXTRA_CMAKE_FILES}
      DESTINATION
        ${ConfigPackageLocation}
      COMPONENT
        Devel
    )

    foreach(_cmake_file ${_arg_EXTRA_CMAKE_FILES})
      file(COPY ${_cmake_file} DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
      get_filename_component(_cmake_file_name ${_cmake_file} NAME)
      list(APPEND EXTRA_CMAKE_FILES ${_cmake_file_name})
    endforeach()

  endif()

  configure_file(${ADD_INSTALLABLE_LIB_MODULE_DIR}/PackageConfig.cmake.in
                 ${CMAKE_CURRENT_BINARY_DIR}/${package_name}Config.cmake
                 @ONLY)

  install(EXPORT ${package_name}Targets
    FILE
      ${package_name}Targets.cmake
    DESTINATION
      ${ConfigPackageLocation}
  )

  install(
    FILES
      "${CMAKE_CURRENT_BINARY_DIR}/${package_name}Config.cmake"
      "${CMAKE_CURRENT_BINARY_DIR}/${package_name}ConfigVersion.cmake"
    DESTINATION
      ${ConfigPackageLocation}
    COMPONENT
      Devel
  )

  # This makes the project importable from the build directory
  export(PACKAGE "${package_name}")

endfunction(export_package package_name)

set(PERLACE_DIR ${ACE_INCLUDE_DIR}/bin)
set(PERLDDS_DIR ${OpenDDS_BINARY_DIR}/bin)


macro(replace_ace_bin_location target)
  if (TARGET ${target})
    get_target_property(is_imported ${target} IMPORTED)
    if (${is_imported})
      string(REGEX REPLACE "[$]ENV{ACE_ROOT}/bin/${target}" "$<TARGET_PROPERTY:${target},LOCATION>\"" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    else()
      string(REGEX REPLACE "[$]ENV{ACE_ROOT}/bin/${target}" "$<TARGET_PROPERTY:${target},RUNTIME_OUTPUT_DIRECTORY>/$<TARGET_PROPERTY:${target},OUTPUT_NAME>\"" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    endif()
  endif(TARGET ${target})
endmacro()


function(dds_configure_test_files)
  file(GLOB files *.ini *.conf *.xml)
  file(COPY ${files}
       DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

  file(GLOB test_scripts RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.pl)
  foreach(script ${test_scripts})
    file(READ ${script} RUN_TEST_CONTENT)

    replace_ace_bin_location(tao_nsadd)
    replace_ace_bin_location(tao_imr)

    string(REPLACE "$TAO_ROOT/tests/Hello/server" "${Hello_Server_LOCATION}" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "\$ENV{DDS_ROOT}/bin" "${PERLDDS_DIR}" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "\$ENV{ACE_ROOT}/bin" "${PERLACE_DIR}" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "$DDS_ROOT/bin" "${PERLDDS_DIR}" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "$ACE_ROOT/bin" "${PERLACE_DIR}" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "use PerlDDS::Process_Java;" "use PerlDDS::Process_Java;\nPerlACE::add_lib_path(\"$DDS_ROOT/lib\");" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "use PerlACE::TestTarget;" "use PerlACE::TestTarget;\n\$ENV{ACE_ROOT}=\"${ACE_INCLUDE_DIR}\";" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${script}" CONTENT "${RUN_TEST_CONTENT}")
  endforeach()
endfunction()

function(dds_add_test name)
  set(multiValueArgs COMMAND REQUIRES LABELS RESOURCE_LOCK)
  cmake_parse_arguments(_arg "" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if (_arg_REQUIRES)
    foreach(cond ${_arg_REQUIRES})
      string(REPLACE " " ";" cond ${cond})
      if (${cond})
      else()
        return()
      endif()
    endforeach()
  endif(_arg_REQUIRES)

  foreach(label ${_arg_LABELS})
    if (";${TEST_EXCLUDE_LABELS};" MATCHES ";${label};")
      message("excluding test: ${name}")
      return()
    endif()
  endforeach()

  if (CMAKE_CONFIGURATION_TYPES)
    set(ctest_config_setting "CTEST_CONFIG=$<CONFIG>")
  endif(CMAKE_CONFIGURATION_TYPES)

  string(REPLACE " " "__" name "${name}")
  add_test(NAME "${name}"
           COMMAND ${CMAKE_COMMAND} -E env "${ctest_config_setting}" perl ${_arg_COMMAND}
  )
  list(APPEND _arg_RESOURCE_LOCK "${CMAKE_CURRENT_LIST_FILE}")
  # if (RTPS IN_LIST _arg_LABELS)
  #   list(APPEND _arg_RESOURCE_LOCK RTPS)
  # endif()
  set_tests_properties("${name}" PROPERTIES
    LABELS "${_arg_LABELS}"
    RESOURCE_LOCK "${_arg_RESOURCE_LOCK}"
  )
endfunction()

set(PERLACE_DIR ${ACE_INCLUDE_DIR}/bin)
set(PERLDDS_DIR ${OpenDDS_BINARY_DIR}/bin)

get_property(opendds_test_count GLOBAL PROPERTY opendds_test_count)
if (NOT opendds_test_count)
  set_property(GLOBAL PROPERTY opendds_test_count "230")
endif()

function(dds_configure_test_files)
  file(GLOB files *.ini *.conf *.xml)
  file(COPY ${files}
       DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

  file(GLOB test_scripts RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.pl)
  foreach(script ${test_scripts})
    file(READ ${script} RUN_TEST_CONTENT)

    foreach(replace_tuple ${ARGN})
      if (${replace_tuple})
        string(REPLACE ${${replace_tuple}} RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
      endif()
    endforeach()

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
    list(LENGTH _arg_COMMAND command_len)
    if (command_len EQUAL 1)
      list(APPEND _arg_COMMAND -ExeSubDir "$<CONFIG>")
    else()
      list(INSERT _arg_COMMAND 1 -ExeSubDir "$<CONFIG>")
    endif()
  endif(CMAKE_CONFIGURATION_TYPES)

  if ((RTPS IN_LIST _arg_LABELS) OR (MCAST IN_LIST _arg_LABELS))
    get_property(old_count GLOBAL PROPERTY opendds_test_count)
    math( EXPR new_count "${old_count}+1" )
    set_property(GLOBAL PROPERTY opendds_test_count "${new_count}")
    set(port_setting "OPENDDS_RTPS_DEFAULT_D0=${new_count}")
  endif()

  string(REPLACE " " "__" name "${name}")
  add_test(NAME "${name}"
           COMMAND ${CMAKE_COMMAND} -E env ${port_setting} perl ${_arg_COMMAND}
  )
  list(APPEND _arg_RESOURCE_LOCK "${CMAKE_CURRENT_LIST_FILE}")


  set_tests_properties("${name}" PROPERTIES
    LABELS "${_arg_LABELS}"
    RESOURCE_LOCK "${_arg_RESOURCE_LOCK}"
  )
endfunction()
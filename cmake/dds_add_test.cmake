

find_file(PERLACE_LOCATION Run_Test.pm
          PATHS ${ACE_ROOT}/bin/PerlACE ${TAO_ROOT}/../ACE/bin/PerlACE ${TAO_ROOT}/../bin/PerlACE
          NO_DEFAULT_PATH)

if (PERLACE_LOCATION)
  get_filename_component(PERLACE_LOCATION_DIR ${PERLACE_LOCATION} DIRECTORY)
  get_filename_component(ACE_ROOT ${PERLACE_LOCATION_DIR}/../.. ABSOLUTE)
  enable_testing()
else()
  message(WARNING "Cannot find PerlACE, no tests will be added")
endif()

function(dds_configure_test_files)
  file(GLOB files *.ini *.conf *.xml)
  file(COPY ${files}
       DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

  file(GLOB test_scripts RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.pl)
  foreach(script ${test_scripts})
    file(READ ${script} RUN_TEST_CONTENT)

    string(REPLACE "\$orbsvcs{'ImplRepo_Service'}" "\"$<TARGET_FILE:ImR_Locator_Service>\"" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "\$orbsvcs{'ImR_Activator'}" "\"$<TARGET_FILE:ImR_Activator_Service>\"" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "\$orbsvcs{'Naming_Service'}" "\"$<TARGET_FILE:Naming_Service>\"" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "\$ENV{ACE_ROOT}/bin/tao_nsadd" "$<TARGET_FILE:tao_nsadd>" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "\$ENV{ACE_ROOT}/bin/tao_imr" "$<TARGET_FILE:tao_imr>" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "\$ENV{DDS_ROOT}/bin" "${DDS_BINARY_DIR}/bin" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "\$ENV{ACE_ROOT}/bin" "${ACE_ROOT}/bin" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "$TAO_ROOT" "${TAO_DIR}/.." RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "$DDS_ROOT/bin" "${DDS_BINARY_DIR}/bin" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "$ACE_ROOT/bin" "${ACE_ROOT}/bin" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "use PerlDDS::Process_Java;" "use PerlDDS::Process_Java;\nPerlACE::add_lib_path(\"$DDS_ROOT/lib\");" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")
    string(REPLACE "# -*- perl -*-" "# -*- perl -*-\n\$ENV{'DDS_ROOT'}=\"${DDS_BINARY_DIR}\";\n\$ENV{'ACE_ROOT'}=\"$<TARGET_FILE_DIR:ACE>/..\";" RUN_TEST_CONTENT "${RUN_TEST_CONTENT}")

    file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${script}" CONTENT "${RUN_TEST_CONTENT}")
  endforeach()
endfunction()

function(dds_add_test name)
  set(multiValueArgs COMMAND REQUIRES LABELS)
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
    #message("TEST_EXCLUDE_LABELS=${TEST_EXCLUDE_LABELS}")
    if (";${TEST_EXCLUDE_LABELS};" MATCHES ";${label};")
      message("excluding test: ${name}")
      return()
    endif()
  endforeach()

  string(REPLACE " " "__" name "${name}")
  add_test(NAME "${name}"
           COMMAND ${CMAKE_COMMAND} -E env perl ${_arg_COMMAND}
  )

  set_tests_properties("${name}" PROPERTIES
    LABELS "${_arg_LABELS}"
  )
endfunction()
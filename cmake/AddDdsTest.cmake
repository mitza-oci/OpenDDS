

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


function(configure_dds_test_files)
  file(GLOB files *.ini *.pl)
  file(COPY ${files}
       DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
endfunction()

function(add_dds_test name)
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
           COMMAND ${CMAKE_COMMAND} -E env "DDS_ROOT=$<TARGET_FILE_DIR:DCPSInfoRepo>/.." env "ACE_ROOT=${ACE_ROOT}" perl ${_arg_COMMAND}
  )

  set_tests_properties("${name}" PROPERTIES
    LABELS "${_arg_LABELS}"
  )
endfunction()
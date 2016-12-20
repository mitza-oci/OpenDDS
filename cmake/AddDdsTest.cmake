



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

  add_test(
    NAME "${name}"
    COMMAND ${CMAKE_COMMAND} -E env "DDS_ROOT=${DDS_ROOT}" env "ACE_ROOT=${ACE_ROOT}" ${_arg_COMMAND}
  )

  set_tests_properties("${name}" PROPERTIES
    LABELS "${_arg_LABELS}"
  )
endfunction()
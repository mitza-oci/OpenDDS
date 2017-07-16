
set(PERLACE_DIR ${ACE_INCLUDE_DIR}/bin)

set(files
  Cross_Sync_Common.pm
  Cross_Sync.pm
  Process.pm
  ProcessFactory.pm
  Run_Test.pm
)

if (TARGET tao_imr)
  if (TAO_INSTALL_DIR)
    ## we use TAO_INSTALL_DIR to check if tao_nsadd is imported or not;
    ## TAO_INSTALL_DIR is only defined when TAO is not imported
    set(tao_imr_location  "$<TARGET_PROPERTY:tao_imr,RUNTIME_OUTPUT_DIRECTORY>/$<TARGET_PROPERTY:tao_imr,OUTPUT_NAME>")
  else()
    set(tao_imr_location "$<TARGET_PROPERTY:tao_imr,LOCATION>")
  endif()

  set(sub_tao_imr
    "sub tao_imr {\n  return '${tao_imr_location}';\n}\n\n"
  )
endif()


if (TARGET tao_nsadd)
  if (TAO_INSTALL_DIR)
    ## we use TAO_INSTALL_DIR to check if tao_nsadd is imported or not;
    ## TAO_INSTALL_DIR is only defined when TAO is not imported
    set(tao_nsadd_location  "$<TARGET_PROPERTY:tao_nsadd,RUNTIME_OUTPUT_DIRECTORY>/$<TARGET_PROPERTY:tao_nsadd,OUTPUT_NAME>")
  else()
    set(tao_nsadd_location "$<TARGET_PROPERTY:tao_nsadd,LOCATION>")
  endif()

  set(sub_tao_nsadd
    "sub tao_nsadd {\n  return '${tao_nsadd_location}';\n}\n\n"
  )
endif()


if (TARGET Hello_Server)
  ## TAO is part of our source tree
  set(hello_server_location ${TAO_BINARY_DIR}/tests/Hello/$<TARGET_PROPERTY:Hello_Server,OUTPUT_NAME>)
else(TARGET Hello_Server)
  find_file(hello_server_location server${CMAKE_EXECUTABLE_SUFFIX}
            PATHS ${TAO_DIR}/tests/Hello ${TAO_BINARY_DIR}/tests/Hello
            NO_DEFAULT_PATH)
endif(TARGET Hello_Server)

if (hello_server_location)
  set(sub_hello_server
    "sub hello_server {\n  return '${hello_server_location}';\n}\n\n"
  )
endif(hello_server_location)

set(sub_opendds_idl
  "sub opendds_idl {\n  return '$<TARGET_PROPERTY:opendds_idl,RUNTIME_OUTPUT_DIRECTORY>/$<TARGET_PROPERTY:opendds_idl,OUTPUT_NAME>';\n}\n\n"
)


function(replace_orb_service service_string target_name)
  if (TARGET ${target_name})
    if (TAO_INSTALL_DIR)
      string(REGEX REPLACE "${service_string}' => [^,]+" "${service_string}' => \"${TAO_BIN_DIR}/$<TARGET_PROPERTY:${target_name},OUTPUT_NAME>\"" PM_CONTENT "${PM_CONTENT}")
    else()
      string(REGEX REPLACE "${service_string}' => [^,]+" "${service_string}' => \"$<TARGET_PROPERTY:${target_name},LOCATION>\"" PM_CONTENT "${PM_CONTENT}")
    endif()
    set(PM_CONTENT ${PM_CONTENT} PARENT_SCOPE)
  endif()
endfunction()

file(COPY ${files}
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

file(READ Run_Test.pm PM_CONTENT)

string(REPLACE "package PerlDDS;" "package PerlDDS;\n${sub_tao_nsadd}${sub_tao_imr}${sub_hello_server}${sub_opendds_idl}" PM_CONTENT "${PM_CONTENT}")

if (TARGET DCPSInfoRepo)
  string(REPLACE "\$ENV{DDS_ROOT}/bin/DCPSInfoRepo" "${OpenDDS_BIN_DIR}/DCPSInfoRepo" PM_CONTENT "${PM_CONTENT}")
endif(TARGET DCPSInfoRepo)

replace_orb_service(Naming_Service Naming_Service)
replace_orb_service(ImplRepo_Service ImR_Locator_Service)
replace_orb_service(ImR_Activator ImR_Activator_Service)

set(config_options)
if (OPENDDS_SAFETY_PROFILE)
  list(APPEND config_options OPENDDS_SAFETY_PROFILE RTPS)
  if (${OPENDDS_SAFETY_PROFILE} STREQUAL "BASE")
    list(APPEND config_options SAFETY_BASE)
  endif()
endif()

if (NOT BUILD_SHARED_LIBS)
  list(APPEND config_options STATIC)
endif()

if (ACE_HAS_IPV6)
  list(APPEND config_options IPV6)
endif()

if (NOT OPENDDS_HAS_PERSISTENCE_PROFILE)
  list(APPEND config_options OPENDDS_NO_PERSISTENCE_PROFILE)
endif()

if (NOT OPENDDS_HAS_BUILD_IN_TOPICS)
  list(APPEND config_options NO_BUILD_IN_TOPICS)
endif()

set(add_one_config_statements)
foreach(opt ${config_options})
  set(add_one_config_statements "${add_one_config_statements}$config->add_one_config('${opt}');\n")
endforeach()

string(REPLACE "PerlACE::ConfigList;" "PerlACE::ConfigList;\n${add_one_config_statements}" PM_CONTENT "${PM_CONTENT}")

if(ACE_MULTI_CONFIGURATION_GENERATOR)
  set(set_default_exesubdir_stmt "$PerlACE::Process::ExeSubDir ||= 'Debug';\n")
endif(ACE_MULTI_CONFIGURATION_GENERATOR)

if (WIN32)
  set(libpaths ${OpenDDS_BIN_DIR} ${ACE_BIN_DIR} ${TAO_BIN_DIR})
  list(REMOVE_DUPLICATES libpaths)
  foreach(libpath ${libpaths})
    set(quoted_libpath "\"${libpath}/\"")
    if (ACE_MULTI_CONFIGURATION_GENERATOR)
      set(quoted_libpath "${quoted_libpath} . $PerlACE::Process::ExeSubDir")
    endif()
    list(APPEND add_libpath_stmt "PerlACE::add_lib_path(${quoted_libpath});\n")
  endforeach()
endif(WIN32)

string(REPLACE "use File::Spec;" "use File::Spec;\n\$ENV{'ACE_ROOT'}=\"${ACE_INCLUDE_DIR}\";\n$ACE_ROOT=\"${ACE_INCLUDE_DIR}\";\n$DDS_ROOT=\"${OpenDDS_BINARY_DIR}\";\n${set_default_exesubdir_stmt}${add_libpath_stmt}" PM_CONTENT "${PM_CONTENT}")
file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/Run_Test.pm" CONTENT "${PM_CONTENT}")

file(READ Process_Java.pm PM_CONTENT)
string(REPLACE "$JAVA_HOME/bin/java" "${Java_JAVA_EXECUTABLE}" PM_CONTENT "${PM_CONTENT}")
string(REPLACE "$ACE_ROOT/bin" "${PERLACE_DIR}" PM_CONTENT "${PM_CONTENT}")

if (CMAKE_CONFIGURATION_TYPES AND NOT WIN32)
  # only used by XCode for now
  set(extra_lib_path  "\nPerlACE::add_lib_path(\"${OpenDDS_LIB_DIR}/\" . $PerlACE::Process::ExeSubDir);\nPerlACE::add_lib_path($PerlACE::Process::ExeSubDir);\n")
endif(CMAKE_CONFIGURATION_TYPES AND NOT WIN32)

## Assigning ACE_ROOT inside Process_java.pm is necessary for the tests to work in MacOS
string(REPLACE "use Cwd qw();" "use Cwd qw();\n\$ENV{'ACE_ROOT'}=\"${ACE_INCLUDE_DIR}\";${extra_lib_path}" PM_CONTENT "${PM_CONTENT}")

file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/Process_Java.pm" CONTENT "${PM_CONTENT}")
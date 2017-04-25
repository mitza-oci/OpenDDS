
set(PERLACE_DIR ${ACE_INCLUDE_DIR}/bin)

set(files
  Cross_Sync_Common.pm
  Cross_Sync.pm
  Process.pm
  ProcessFactory.pm
  Run_Test.pm
)

function(replace_orb_service service_string target_name)
  if (TAO_INSTALL_DIR)
    string(REGEX REPLACE "${service_string}' => [^,]+" "${service_string}' => \"${TAO_BIN_DIR}/$<TARGET_PROPERTY:${target_name},OUTPUT_NAME>\"" PM_CONTENT "${PM_CONTENT}")
  else()
    string(REGEX REPLACE "${service_string}' => [^,]+" "${service_string}' => \"$<TARGET_PROPERTY:${target_name},LOCATION>\"" PM_CONTENT "${PM_CONTENT}")
  endif()
  set(PM_CONTENT ${PM_CONTENT} PARENT_SCOPE)
endfunction()

file(COPY ${files}
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

file(READ Run_Test.pm PM_CONTENT)

if (TARGET DCPSInfoRepo)
  string(REPLACE "\$ENV{DDS_ROOT}/bin/DCPSInfoRepo" "${OpenDDS_BIN_DIR}/DCPSInfoRepo" PM_CONTENT "${PM_CONTENT}")
endif(TARGET DCPSInfoRepo)

replace_orb_service(Naming_Service Naming_Service)
replace_orb_service(ImplRepo_Service ImR_Locator_Service)
replace_orb_service(ImR_Activator ImR_Activator_Service)

if(CMAKE_CONFIGURATION_TYPES)
  set(set_default_exesubdir_stmt "$PerlACE::Process::ExeSubDir ||= 'Debug';\n")
endif(CMAKE_CONFIGURATION_TYPES)

if (WIN32)
  set(libpaths ${OpenDDS_BIN_DIR} ${ACE_BIN_DIR} ${TAO_BIN_DIR})
  list(REMOVE_DUPLICATES libpaths)
  foreach(libpath ${libpaths})
    set(quoted_libpath "\"${libpath}/\"")
    if (CMAKE_CONFIGURATION_TYPES)
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

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
    string(REGEX REPLACE "${service_string}' => [^,]+" "${service_string}' => \"$<TARGET_PROPERTY:${target_name},RUNTIME_OUTPUT_DIRECTORY>/$<TARGET_PROPERTY:${target_name},OUTPUT_NAME>\"" PM_CONTENT "${PM_CONTENT}")
  else()
    string(REGEX REPLACE "${service_string}' => [^,]+" "${service_string}' => \"$<TARGET_PROPERTY:${target_name},LOCATION>\"" PM_CONTENT "${PM_CONTENT}")
  endif()
  set(PM_CONTENT ${PM_CONTENT} PARENT_SCOPE)
endfunction()

file(COPY ${files}
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})

file(READ Run_Test.pm PM_CONTENT)

if (TARGET DCPSInfoRepo)
  if (CMAKE_CONFIGURATION_TYPES)
    string(REPLACE "\$ENV{DDS_ROOT}/bin/DCPSInfoRepo" "$<TARGET_PROPERTY:DCPSInfoRepo,RUNTIME_OUTPUT_DIRECTORY>/\$ENV{'CTEST_CONFIG'}/DCPSInfoRepo" PM_CONTENT "${PM_CONTENT}")
  else(CMAKE_CONFIGURATION_TYPES)
    string(REPLACE "\$ENV{DDS_ROOT}/bin/DCPSInfoRepo" "$<TARGET_FILE:DCPSInfoRepo>" PM_CONTENT "${PM_CONTENT}")
  endif(CMAKE_CONFIGURATION_TYPES)
endif(TARGET DCPSInfoRepo)

replace_orb_service(Naming_Service Naming_Service)
replace_orb_service(ImplRepo_Service ImR_Locator_Service)
replace_orb_service(ImR_Activator ImR_Activator_Service)

string(REPLACE "use File::Spec;" "use File::Spec;\n\$ENV{'ACE_ROOT'}=\"${ACE_INCLUDE_DIR}\";\n$ACE_ROOT=\"${ACE_INCLUDE_DIR}\";\n$DDS_ROOT=\"${OpenDDS_BINARY_DIR}\";" PM_CONTENT "${PM_CONTENT}")
file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/Run_Test.pm" CONTENT "${PM_CONTENT}")

file(READ Process_Java.pm PM_CONTENT)
string(REPLACE "$JAVA_HOME/bin/java" "${Java_JAVA_EXECUTABLE}" PM_CONTENT "${PM_CONTENT}")
string(REPLACE "$ACE_ROOT/bin" "${PERLACE_DIR}" PM_CONTENT "${PM_CONTENT}")
## Assigning ACE_ROOT inside Process_java.pm is necessary for the tests to work in MacOS
string(REPLACE "use Cwd qw();" "use Cwd qw();\n\$ENV{'ACE_ROOT'}=\"${ACE_INCLUDE_DIR}\";" PM_CONTENT "${PM_CONTENT}")

file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/Process_Java.pm" CONTENT "${PM_CONTENT}")
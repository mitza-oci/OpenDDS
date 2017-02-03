set(files
  Cross_Sync_Common.pm
  Cross_Sync.pm
  Process.pm
  ProcessFactory.pm
  Run_Test.pm
)

file(COPY ${files}
     DESTINATION ${CMAKE_CURRENT_BINARY_DIR})


file(READ Run_Test.pm PM_CONTENT)
string(REPLACE "use File::Spec;" "use File::Spec;\n$ACE_ROOT=\"$<TARGET_FILE_DIR:ACE>/..\";\n$DDS_ROOT=\"$<TARGET_FILE_DIR:OpenDDS_Dcps>/..\";" PM_CONTENT "${PM_CONTENT}")
file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/Run_Test.pm" CONTENT "${PM_CONTENT}")

file(READ Process_Java.pm PM_CONTENT)
string(REPLACE "$JAVA_HOME/bin/java" "${Java_JAVA_EXECUTABLE}" PM_CONTENT "${PM_CONTENT}")
## Assigning ACE_ROOT inside Process_java.pm is necessary for the tests to work in MacOS
string(REPLACE "use Cwd qw();" "use Cwd qw();\n\$ENV{'ACE_ROOT'}=\"$<TARGET_FILE_DIR:ACE>/..\";" PM_CONTENT "${PM_CONTENT}")
file(GENERATE OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/Process_Java.pm" CONTENT "${PM_CONTENT}")
set(files
  Cross_Sync_Common.pm
  Cross_Sync.pm
  Process_Java.pm
  Process.pm
  ProcessFactory.pm
  Run_Test.pm
)

foreach(f ${files})
  configure_file(${f} ${f} COPYONLY)
endforeach()
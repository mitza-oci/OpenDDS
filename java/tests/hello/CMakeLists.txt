if (DDS_SUPPRESS_ANYS)
  set(FLAGS -SS)
endif()

ace_add_lib(hello_java_client
  FOLDER java/tests/hello
)

dds_add_taoidl_jar(hello_java_client_jar
  OUTPUT_NAME hello_java_client
  LIB hello_java_client
  FOLDER java/tests/hello
  TAO_IDL_FLAGS ${FLAGS}
  IDL2JNI_FLAGS -SS
  IDL_FILES Test.idl
  SOURCES Client.java
)


## Hello_Server is a target from $TAO_ROOT/tests/Hello which may not be built.
## We need check whether the target is available before we can enable the test.

if (TARGET Hello_Server)
  ## TAO is part of our source tree
  set(Hello_Server_LOCATION $<TARGET_FILE:Hello_Server>)
else(TARGET Hello_Server)
  find_file(Hello_Server_LOCATION tests/tests/Hello/server${CMAKE_EXECUTABLE_SUFFIX}
            PATHS ${TAO_DIR} ${TAO_BINARY_DIR}
            NO_DEFAULT_PATH)

  if (NOT Hello_Server_LOCATION)
    return()
  endif()
endif(TARGET Hello_Server)


include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()

dds_add_test("java/tests/hello/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN JAVA
)


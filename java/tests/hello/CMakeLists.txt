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

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()

if(EXISTS "${TAO_ROOT}/tests/Hello/server")
dds_add_test("java/tests/hello/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN JAVA
)
endif()


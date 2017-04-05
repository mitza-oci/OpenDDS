file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/idl2jni_test_simple_jar.dir)

ace_add_lib(idl2jni_test_simple

  REQUIRES "TARGET idl2jni"
)

dds_add_taoidl_jar(idl2jni_test_simple_jar
  OUTPUT_NAME simple

  LIB idl2jni_test_simple
  TAO_IDL_FLAGS -DUSE_LOCAL
  IDL2JNI_FLAGS -DUSE_LOCAL
  IDL_FILES simple.idl
)


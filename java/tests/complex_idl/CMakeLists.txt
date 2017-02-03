ace_add_lib(complex_idl_test
  OUTPUT_NAME complex_idl_test
  DEFINE_SYMBOL COMPLEX_IDL_TEST_BUILD_DLL
)

dds_add_ddsidl_jar(complex_idl_test_jar
  OUTPUT_NAME complex_idl_test
  LIB complex_idl_test
  TAO_IDL_FLAGS -Wb,stub_export_include=complex_idl_test_Export.h
                -Wb,stub_export_macro=complex_idl_test_Export
  DDS_IDL_FLAGS -Wb,export_macro=complex_idl_test_Export
  IDL2JNI_FLAGS -Wb,stub_export_include=complex_idl_test_Export.h
                -Wb,stub_export_macro=complex_idl_test_Export
  IDL_FILES Complex_Idl.idl
  SOURCES ComplexIDLTest.java
          QuoteSupport.java
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("java/tests/complex_idl/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN JAVA
)

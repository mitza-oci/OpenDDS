

ace_add_lib(two_idl_test
  DEFINE_SYMBOL TWO_IDL_TEST_BUILD_DLL
  REQUIRES OpenDDS_DCPS_Java
  FOLDER java/tests/two_idl
)

dds_add_ddsidl_jar(two_idl_test_jar
  OUTPUT_NAME two_idl_test
  FOLDER java/tests/two_idl
  LIB two_idl_test
  TAO_IDL_FLAGS -Wb,stub_export_include=two_idl_test_Export.h
                -Wb,stub_export_macro=two_idl_test_Export
  DDS_IDL_FLAGS -Wb,export_macro=two_idl_test_Export
  IDL2JNI_FLAGS -Wb,stub_export_include=two_idl_test_Export.h
                -Wb,stub_export_macro=two_idl_test_Export
  IDL_FILES Common.idl
            Message.idl
)


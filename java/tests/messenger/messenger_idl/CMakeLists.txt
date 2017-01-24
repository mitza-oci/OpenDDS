
ace_add_lib(messenger_idl
  DEFINE_SYMBOL MESSENGER_IDL_TEST_BUILD_DLL
)

dds_add_ddsidl_jar(messenger_idl_jar
  LIB messenger_idl
  OUTPUT_NAME messenger_idl_test
  TAO_IDL_FLAGS -Wb,stub_export_include=messenger_idl_test_Export.h
                -Wb,stub_export_macro=messenger_idl_test_Export
  DDS_IDL_FLAGS -Wb,export_macro=messenger_idl_test_Export
  IDL2JNI_FLAGS -Wb,stub_export_include=messenger_idl_test_Export.h
                -Wb,stub_export_macro=messenger_idl_test_Export
  IDL_FILES Messenger.idl
)
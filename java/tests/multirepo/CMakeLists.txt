

ace_add_lib(multirepo_test
  DEFINE_SYMBOL MULTIREPO_TEST_BUILD_DLL
)

dds_add_ddsidl_jar(multirepo_test_jar
  OUTPUT_NAME multirepo_test
  LIB multirepo_test
  TAO_IDL_FLAGS -Wb,stub_export_include=multirepo_test_Export.h
                -Wb,stub_export_macro=multirepo_test_Export
  DDS_IDL_FLAGS -Wb,export_macro=multirepo_test_Export
  IDL2JNI_FLAGS -Wb,stub_export_include=multirepo_test_Export.h
                -Wb,stub_export_macro=multirepo_test_Export
  IDL_FILES MultiRepo.idl
)
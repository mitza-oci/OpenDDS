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
  SOURCES MultiRepoBase.java
          MultiRepoMaster.java
          MultiRepoSlave.java
          MultiRepoWorker.java
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("java/tests/multirepo/run_test.pl"
  COMMAND run_test.pl
  LABELS DCPS_MIN JAVA
)

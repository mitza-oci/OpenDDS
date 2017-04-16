
set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)
ace_add_lib(idl_test1_lib
  OUTPUT_NAME idl_test1_lib
  DEFINE_SYMBOL FOOLIB_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS idl_test1_lib
  DDS_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
  TAO_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -SS
  IDL_FILES FooDef.idl
)


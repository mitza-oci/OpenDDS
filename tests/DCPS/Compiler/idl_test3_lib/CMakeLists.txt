

add_ace_lib(idl_test3_lib
  OUTPUT_NAME idl_test3_lib
  FOLDER tests/DCPS/Compiler/idl_test3_lib
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS idl_test3_lib
  DDS_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
  TAO_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -SS
  IDL_FILES FooDef.idl
            FooDef2.idl
            FooDef3.idl
            SharedTypes.idl
)

if (MSVC)
  target_compile_options(idl_test3_lib /bigobj)
endif()


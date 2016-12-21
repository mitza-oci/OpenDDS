
project(idl_test2_lib CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(idl_test2_lib
  OUTPUT_NAME idl_test2_lib
  FOLDER tests/DCPS/Compiler/idl_test2_lib
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS idl_test2_lib
  DDS_IDL_FLAGS -Wb,export_macro=FooLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -SS
  IDL_FILES FooDef.idl
            BazDef.idl
)

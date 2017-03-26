
project(FACE_idl_test2_lib CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(FACE_idl_test2_lib
  OUTPUT_NAME FACE_idl_test2_lib
  FOLDER tests/FACE/Compiler/idl_test2_lib
  DEFINE_SYMBOL FOOLIB_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)
dds_idl_sources(
  TARGETS FACE_idl_test2_lib
  DDS_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -I../../../DCPS/Compiler/idl_test2_lib
  TAO_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -I../../../DCPS/Compiler/idl_test2_lib
  IDL_FILES ../../../DCPS/Compiler/idl_test2_lib/FooDef.idl
            ../../../DCPS/Compiler/idl_test2_lib/BazDef.idl
)


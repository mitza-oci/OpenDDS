
project(FACE_idl_test2_lib CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(FACE_idl_test2_lib
  OUTPUT_NAME FACE_idl_test2_lib
  FOLDER tests/FACE/Compiler/idl_test2_lib
  ASPECTS FACE
  DEFINE_SYMBOL FOOLIB_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS FACE_idl_test2_lib
  ASPECTS FACE
  DDS_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -I../../../DCPS/Compiler/idl_test2_lib
  TAO_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -I../../../DCPS/Compiler/idl_test2_lib
  IDL_FILES ../../../DCPS/Compiler/idl_test2_lib/FooDef.idl
            ../../../DCPS/Compiler/idl_test2_lib/BazDef.idl
)


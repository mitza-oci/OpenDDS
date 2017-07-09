
set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)
ace_add_lib(FACE_idl_test3_lib
  OUTPUT_NAME FACE_idl_test3_lib
  DEFINE_SYMBOL FOOLIB_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
  NO_UNITY_BUILD
)
dds_idl_sources(
  TARGETS FACE_idl_test3_lib
  DDS_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -I../../../DCPS/Compiler/idl_test3_lib
  TAO_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -I../../../DCPS/Compiler/idl_test3_lib
  IDL_FILES ../../../DCPS/Compiler/idl_test3_lib/FooDef.idl
            ../../../DCPS/Compiler/idl_test3_lib/FooDef2.idl
            ../../../DCPS/Compiler/idl_test3_lib/FooDef3.idl
            ../../../DCPS/Compiler/idl_test3_lib/SharedTypes.idl
)

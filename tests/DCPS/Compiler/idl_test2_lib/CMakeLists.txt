
project(idl_test2_lib CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()

set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON)
ace_add_lib(idl_test2_lib
  OUTPUT_NAME idl_test2_lib
  DEFINE_SYMBOL FOOLIB_BUILD_DLL
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


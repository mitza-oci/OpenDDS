
project(DcpsFooType3NoKey CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(DcpsFooType3NoKey
  OUTPUT_NAME DcpsFooType3NoKey

  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DcpsFooType3NoKey
  DDS_IDL_FLAGS -Wb,export_macro=FooLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -SS
  IDL_FILES FooDef.idl
)


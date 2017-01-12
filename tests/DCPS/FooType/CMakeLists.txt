

ace_add_lib(DcpsFooType
  OUTPUT_NAME DcpsFooType
  FOLDER tests/DCPS/FooType
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
ace_target_cxx_sources(DcpsFooType
  SOURCE_FILES Foo_Singleton_Transport.cpp
  HEADER_FILES Foo_Singleton_Transport.h
)

dds_idl_sources(
  TARGETS DcpsFooType
  DDS_IDL_FLAGS -Wb,export_macro=FooType_Export
  TAO_IDL_FLAGS -Wb,export_macro=FooType_Export
                -Wb,export_include=footype_export.h
                -SS
  IDL_FILES FooType.idl
)


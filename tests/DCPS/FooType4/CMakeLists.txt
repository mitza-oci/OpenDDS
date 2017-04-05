

ace_add_lib(DcpsFooType4
  OUTPUT_NAME DcpsFooType4

  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DcpsFooType4
  DDS_IDL_FLAGS -Wb,export_macro=FooLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -SS
  IDL_FILES FooDef.idl
)


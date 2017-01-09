

add_ace_lib(DcpsFooType3Unbounded
  OUTPUT_NAME DcpsFooType3Unbounded
  FOLDER tests/DCPS/FooType3Unbounded
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS DcpsFooType3Unbounded
  DDS_IDL_FLAGS -Wb,export_macro=FooLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -SS
  IDL_FILES FooDef.idl
)


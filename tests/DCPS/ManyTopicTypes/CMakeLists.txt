

add_ace_lib(ManyTopicTypes
  OUTPUT_NAME ManyTopicTypes
  FOLDER tests/DCPS/ManyTopicTypes
  PUBLIC_LINK_LIBRARIES OpenDDS_Dcps
)
dds_idl_sources(
  TARGETS ManyTopicTypes
  DDS_IDL_FLAGS -Wb,export_macro=FooLib_Export
  TAO_IDL_FLAGS -Wb,export_macro=FooLib_Export
                -Wb,export_include=foolib_export.h
                -SS
  IDL_FILES Foo1Def.idl
            Foo2Def.idl
            Foo3Def.idl
)


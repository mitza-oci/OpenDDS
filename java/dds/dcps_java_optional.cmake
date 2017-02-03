
if (BUILT_IN_TOPICS)

  dds_idl2jni_command(OpenDDS_Dcps_Java_idl
    FLAGS -Wb,native_lib_name=OpenDDS_DCPS_Java
          -SS -I${TAO_ROOT}
          -I${CMAKE_CURRENT_SOURCE_DIR}/../..
          -I${CMAKE_CURRENT_SOURCE_DIR}/../../dds
          -Wb,stub_export_include=dcps_java_export.h
          -Wb,stub_export_macro=dcps_java_Export
    IDL_FILES ${CMAKE_CURRENT_BINARY_DIR}/../../dds/DdsDcpsCoreTypeSupport.idl
  )

  add_custom_command(
    OUTPUT BitsJC.cpp DdsDcpsCore.idl.TypeSupportImpl.java.list
    COMMAND ${CMAKE_COMMAND} -E env "DDS_ROOT=${DDS_ROOT}" env "TAO_ROOT=${TAO_ROOT}" $<TARGET_FILE:opendds_idl>
              -j ${DDS_BASE_IDL_FLAGS} -Wb,java=BitsJC.cpp ${CMAKE_CURRENT_SOURCE_DIR}/../../dds/DdsDcpsCore.idl
    DEPENDS opendds_idl ../../dds/DdsDcpsCore.idl
  )

  list(APPEND OpenDDS_Dcps_Java_idl_CXX_OUTPUTS ${CMAKE_CURRENT_BINARY_DIR}/BitsJC.cpp)
  list(APPEND OpenDDS_Dcps_Java_idl_JAVA_OUTPUTS
    OpenDDS/DCPS/BuiltinTopicUtils.java
    @${CMAKE_CURRENT_BINARY_DIR}/DdsDcpsCore.idl.TypeSupportImpl.java.list
  )
endif()
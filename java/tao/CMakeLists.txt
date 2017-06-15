ace_requires("TARGET TAO")

dds_idl2jni_command(tao_java_idl
  FLAGS -SS -Wb,stub_export_include=tao_java_export.h
        -Wb,stub_export_macro=tao_java_Export
        -Wb,tao_include_prefix=tao/
  IDL_FILES ${TAO_INCLUDE_DIR}/tao/BooleanSeq.pidl
            ${TAO_INCLUDE_DIR}/tao/CharSeq.pidl
            ${TAO_INCLUDE_DIR}/tao/DoubleSeq.pidl
            ${TAO_INCLUDE_DIR}/tao/FloatSeq.pidl
            ${TAO_INCLUDE_DIR}/tao/LongLongSeq.pidl
            ${TAO_INCLUDE_DIR}/tao/LongSeq.pidl
            ${TAO_INCLUDE_DIR}/tao/OctetSeq.pidl
            ${TAO_INCLUDE_DIR}/tao/ShortSeq.pidl
            ${TAO_INCLUDE_DIR}/tao/StringSeq.pidl
            ${TAO_INCLUDE_DIR}/tao/ULongLongSeq.pidl
            ${TAO_INCLUDE_DIR}/tao/ULongSeq.pidl
            ${TAO_INCLUDE_DIR}/tao/UShortSeq.pidl
)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

ace_add_lib(tao_java
  DEFINE_SYMBOL TAO_JAVA_BUILD_DLL
  PACKAGE OpenDDS

  PUBLIC_INCLUDE_DIRECTORIES $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                             $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/..>
                             $<INSTALL_INTERFACE:${OpenDDS_INSTALL_DIR}/java>
  PUBLIC_LINK_LIBRARIES TAO idl2jni_runtime
)

target_sources(tao_java PRIVATE
  ${tao_java_idl_CXX_OUTPUTS}
)

dds_add_jar(tao_java_jar
  OUTPUT_NAME tao_jar
  OUTPUT_DIR ${PROJECT_BINARY_DIR}/lib
  INCLUDE_JARS i2jrt
  VERSION ${OpenDDS_VERSION}
  SOURCES ${tao_java_idl_JAVA_OUTPUTS}
)


install_jar(tao_java_jar
            DESTINATION ${OpenDDS_INSTALL_DIR}/lib
            COMPONENT OpenDDS_devel)


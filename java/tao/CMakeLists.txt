
dds_idl2jni_command(tao_java_idl
  FLAGS -SS -Wb,stub_export_include=tao_java_export.h
        -Wb,stub_export_macro=tao_java_Export
        -Wb,tao_include_prefix=tao/
  IDL_FILES ${TAO_ROOT}/tao/BooleanSeq.pidl
            ${TAO_ROOT}/tao/CharSeq.pidl
            ${TAO_ROOT}/tao/DoubleSeq.pidl
            ${TAO_ROOT}/tao/FloatSeq.pidl
            ${TAO_ROOT}/tao/LongLongSeq.pidl
            ${TAO_ROOT}/tao/LongSeq.pidl
            ${TAO_ROOT}/tao/OctetSeq.pidl
            ${TAO_ROOT}/tao/ShortSeq.pidl
            ${TAO_ROOT}/tao/StringSeq.pidl
            ${TAO_ROOT}/tao/ULongLongSeq.pidl
            ${TAO_ROOT}/tao/ULongSeq.pidl
            ${TAO_ROOT}/tao/UShortSeq.pidl
)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

ace_add_lib(tao_java
  DEFINE_SYMBOL TAO_JAVA_BUILD_DLL
  PACKAGE OpenDDS
  FOLDER java/tao
  PUBLIC_INCLUDE_DIRECTORIES $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                             $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/..>
                             $<INSTALL_INTERFACE:${OpenDDS_INSTALL_DIR}/java>
  PUBLIC_LINK_LIBRARIES TAO idl2jni_runtime
)

target_sources(tao_java PRIVATE
  ${tao_java_idl_CXX_OUTPUTS}
)

add_jar(tao_java_jar
  OUTPUT_NAME tao_jar
  OUTPUT_DIR ${PROJECT_BINARY_DIR}/lib
  INCLUDE_JARS i2jrt
  VERSION ${OpenDDS_VERSION}
  SOURCES ${tao_java_idl_JAVA_OUTPUTS}
)

set_target_properties(tao_java_jar PROPERTIES
  FOLDER java/tao
)

install_jar(tao_java_jar DESTINATION ${OpenDDS_INSTALL_DIR}/lib)


include(dcps_java_optional.cmake)

list(APPEND BASE_IDL2JNI_FLAGS
   -SS -I${TAO_ROOT} -I..
   -I../.. -I${CMAKE_CURRENT_SOURCE_DIR}/../..
   -Wb,stub_export_include=dcps_java_export.h
   -Wb,stub_export_macro=dcps_java_Export
)

dds_idl2jni_command(OpenDDS_Dcps_Java_idl
  FLAGS ${BASE_IDL2JNI_FLAGS}
  IDL_FILES ../../dds/DdsDcpsCore.idl
            ../../dds/DdsDcpsInfrastructure.idl
            ../../dds/DdsDcpsDomain.idl
            ../../dds/DdsDcpsGuid.idl
)

dds_idl2jni_command(OpenDDS_Dcps_Java_idl
  FLAGS ${BASE_IDL2JNI_FLAGS}
        -Wb,stub_extra_include=dds/DdsDcpsInfrastructureC.h
  IDL_FILES ../../dds/DdsDcpsConditionSeq.idl
)

dds_idl2jni_command(OpenDDS_Dcps_Java_idl
  FLAGS ${BASE_IDL2JNI_FLAGS}
        -Wb,stub_extra_include=dds/DdsDcpsDomainC.h
  IDL_FILES ../../dds/DdsDcpsTypeSupportExt.idl
            ../../dds/DdsDcpsDataReaderSeq.idl
)

dds_idl2jni_command(OpenDDS_Dcps_Java_idl
  FLAGS ${BASE_IDL2JNI_FLAGS}
        -Wb,stub_extra_include=dds/DdsDcpsDomainC.h
  IDL_FILES ../../dds/DdsDcpsTopic.idl
)

dds_idl2jni_command(OpenDDS_Dcps_Java_idl
  FLAGS ${BASE_IDL2JNI_FLAGS}
        -Wb,stub_extra_include=dds/DdsDcpsTopicC.h
  IDL_FILES ../../dds/DdsDcpsPublication.idl
            ../../dds/DdsDcpsSubscription.idl
            ../../dds/DdsDcpsSubscriptionExt.idl
)

add_jar(OpenDDS_Dcps_jar
  OUTPUT_NAME OpenDDS_Dcps
  OUTPUT_DIR ${PROJECT_BINARY_DIR}/lib
  INCLUDE_JARS i2jrt
  SOURCES OpenDDS/DCPS/TheParticipantFactory.java
          OpenDDS/DCPS/TheServiceParticipant.java
          DDS/PARTICIPANT_QOS_DEFAULT.java
          DDS/TOPIC_QOS_DEFAULT.java
          DDS/PUBLISHER_QOS_DEFAULT.java
          DDS/DATAWRITER_QOS_DEFAULT.java
          DDS/SUBSCRIBER_QOS_DEFAULT.java
          DDS/DATAREADER_QOS_DEFAULT.java
          DDS/DATAWRITER_QOS_USE_TOPIC_QOS.java
          DDS/DATAREADER_QOS_USE_TOPIC_QOS.java
          DDS/WaitSet.java
          DDS/GuardCondition.java
          OpenDDS/DCPS/transport/TheTransportRegistry.java
          OpenDDS/DCPS/transport/ConfigurationConflictException.java
          OpenDDS/DCPS/transport/DuplicateException.java
          OpenDDS/DCPS/transport/MiscProblemException.java
          OpenDDS/DCPS/transport/NotConfiguredException.java
          OpenDDS/DCPS/transport/NotFoundException.java
          OpenDDS/DCPS/transport/TcpInst.java
          OpenDDS/DCPS/transport/UdpInst.java
          OpenDDS/DCPS/transport/MulticastInst.java
          OpenDDS/DCPS/transport/RtpsUdpInst.java
          OpenDDS/DCPS/transport/TransportInst.java
          OpenDDS/DCPS/transport/TransportConfig.java
          OpenDDS/DCPS/transport/TransportException.java
          OpenDDS/DCPS/transport/UnableToCreateException.java
          ${OpenDDS_Dcps_Java_idl_JAVA_OUTPUTS}
)

create_javah(GENERATED_FILES OpenDDS_Dcps_jar_headers
  CLASSES OpenDDS.DCPS.TheParticipantFactory
          OpenDDS.DCPS.TheServiceParticipant
          DDS.PARTICIPANT_QOS_DEFAULT
          DDS.TOPIC_QOS_DEFAULT
          DDS.PUBLISHER_QOS_DEFAULT
          DDS.DATAWRITER_QOS_DEFAULT
          DDS.SUBSCRIBER_QOS_DEFAULT
          DDS.DATAREADER_QOS_DEFAULT
          DDS.DATAWRITER_QOS_USE_TOPIC_QOS
          DDS.DATAREADER_QOS_USE_TOPIC_QOS
          DDS.WaitSet
          DDS.GuardCondition
          OpenDDS.DCPS.transport.TheTransportRegistry
          OpenDDS.DCPS.transport.TcpInst
          OpenDDS.DCPS.transport.UdpInst
          OpenDDS.DCPS.transport.MulticastInst
          OpenDDS.DCPS.transport.RtpsUdpInst
          OpenDDS.DCPS.transport.TransportInst
          OpenDDS.DCPS.transport.TransportConfig
  CLASSPATH "${OPENDDS_JARS}"
)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
ace_add_lib(OpenDDS_DCPS_Java
  OUTPUT_NAME OpenDDS_DCPS_Java
  DEFINE_SYMBOL DCPS_JAVA_BUILD_DLL
  PACKAGE OpenDDS
  PUBLIC_INCLUDE_DIRECTORIES $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                             $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/..>
                             $<INSTALL_INTERFACE:${OpenDDS_INSTALL_DIR}/java>
  PUBLIC_LINK_LIBRARIES idl2jni_runtime
                        OpenDDS_Tcp
                        OpenDDS_Udp
                        OpenDDS_Rtps_Udp
                        tao_java
)

target_sources(OpenDDS_DCPS_Java PRIVATE
  ${OpenDDS_Dcps_Java_idl_CXX_OUTPUTS}
  ${OpenDDS_Dcps_jar_headers}
)
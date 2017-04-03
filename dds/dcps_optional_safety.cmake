

set(dcps_flags
  -Wb,pch_include=DCPS/DdsDcps_pch.h
  -Wb,export_macro=OpenDDS_Dcps_Export
  -Wb,export_include=dds/DCPS/dcps_export.h
)

set(dcps_tao_flags -I${CMAKE_CURRENT_SOURCE_DIR}/.. ${dcps_flags} -SS)

tao_idl_sources(
  TARGETS OpenDDS_Dcps
  IDL_FLAGS ${dcps_tao_flags}
  IDL_FILES   DdsDcps.idl
              DdsDcpsDomain.idl
              DdsDcpsPublication.idl
              DdsDcpsSubscription.idl
              DdsDcpsSubscriptionExt.idl
              DdsDcpsTopic.idl
              DdsDcpsTypeSupportExt.idl
)

if (OPENDDS_SAFETY_PROFILE)

  tao_idl_sources(
    TARGETS OpenDDS_Dcps
    IDL_FLAGS ${dcps_tao_flags}
    IDL_FILES DdsDcpsInfrastructure.idl
  )

  dds_idl_sources(
    NO_TAO_IDL
    TARGETS OpenDDS_Dcps
    DDS_IDL_FLAGS ${dcps_flags} -SI -Lspcpp
    IDL_FILES DdsDcpsGuid.idl
              DdsDcpsInfoUtils.idl
  )

  dds_idl_sources(
    NO_TAO_IDL
    TARGETS OpenDDS_Dcps
    DDS_IDL_FLAGS ${dcps_flags} -SI -Lspcpp -ZC DdsDcpsInfrastructureC.h
    IDL_FILES DdsDcpsConditionSeq.idl
  )

  dds_idl_sources(
    NO_TAO_IDL
    TARGETS OpenDDS_Dcps
    DDS_IDL_FLAGS ${dcps_flags} -SI -Lspcpp -ZC DdsDcpsSubscriptionC.h
    IDL_FILES DdsDcpsDataReaderSeq.idl
  )

  dds_idl_sources(
    NO_TAO_IDL
    TARGETS OpenDDS_Dcps
    DDS_IDL_FLAGS ${dcps_flags} -Lspcpp
    IDL_FILES DdsDcpsCore.idl
  )

  tao_idl_sources(
    TARGETS OpenDDS_Dcps
    IDL_FLAGS ${dcps_tao_flags}
    IDL_FILES ${CMAKE_CURRENT_BINARY_DIR}/DdsDcpsCoreTypeSupport.idl
  )

else(OPENDDS_SAFETY_PROFILE)
  if (OPENDDS_HAS_BUILT_IN_TOPICS)
    dds_idl_sources(
      TARGETS OpenDDS_Dcps
      DDS_IDL_FLAGS ${dcps_flags}
      TAO_IDL_FLAGS ${dcps_tao_flags}
      IDL_FILES  DdsDcpsGuid.idl
                 DdsDcpsCore.idl
                 DdsDcpsInfrastructure.idl
    )
    dds_idl_sources(
      TARGETS OpenDDS_Dcps
      DDS_IDL_FLAGS -SI ${dcps_flags}
      TAO_IDL_FLAGS ${dcps_tao_flags}
      IDL_FILES DdsDcpsInfoUtils.idl
    )
  else(OPENDDS_HAS_BUILT_IN_TOPICS)
    dds_idl_sources(
      TARGETS OpenDDS_Dcps
      DDS_IDL_FLAGS ${dcps_flags} -SI
      TAO_IDL_FLAGS ${dcps_tao_flags}
      IDL_FILES DdsDcpsGuid.idl
                DdsDcpsCore.idl
                DdsDcpsInfoUtils.idl
    )

   dds_idl_sources(
      TARGETS OpenDDS_Dcps
      DDS_IDL_FLAGS ${dcps_flags}
      TAO_IDL_FLAGS ${dcps_tao_flags}
      IDL_FILES DdsDcpsInfrastructure.idl
    )
  endif(OPENDDS_HAS_BUILT_IN_TOPICS)

  tao_idl_sources(
    TARGETS OpenDDS_Dcps
    IDL_FLAGS -I${CMAKE_CUR} ${dcps_flags}
    IDL_FILES  DdsDcpsConditionSeq.idl
               DdsDcpsDataReaderSeq.idl
  )

endif(OPENDDS_SAFETY_PROFILE)
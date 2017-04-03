## This is the initial cache file for build ACE_TAO with targets only used by OpenDDS
## Usage:
## cmake -C path_to/ACE_TAO_for_DDS.cmake path_to/ACE_TAO


if (HOSTTOOLS_ONLY)
  set(ACE_SUBDIRS ace apps CACHE STRING "" FORCE)
  set(ACE_WHITELIST_TARGETS ACE ace_gperf CACHE STRING "" FORCE)
  set(TAO_SUBDIRS TAO_IDL CACHE STRING "" FORCE)
else()
  if (NOT (CMAKE_CROSSCOMPILING OR OPENDDS_SAFETY_PROFILE))
    set(ACE_HOST_TOOLS ace_gperf)
    set(TAO_HOST_TOOLS TAO_IDL_FE TAO_IDL_BE TAO_IDL_EXE)
  endif(NOT (CMAKE_CROSSCOMPILING OR OPENDDS_SAFETY_PROFILE))

  if (OPENDDS_SAFETY_PROFILE)
    set(ACE_FACE_SAFETY ${OPENDDS_SAFETY_PROFILE} CACHE STRING "" FORCE)
    set(ACE_SUBDIRS ace CACHE STRING "" FORCE)
    set(ACE_WHITELIST_TARGETS ACE CACHE STRING "" FORCE)
    set(TAO_SUBDIRS CACHE STRING "" FORCE)
  else(OPENDDS_SAFETY_PROFILE)
    set(ACE_SUBDIRS ace apps ACEXML CACHE STRING "" FORCE)
    set(ACE_WHITELIST_TARGETS
      ACE ACE_XML_Utils ACEXML ACEXML_Parser ${ACE_HOST_TOOLS}
      CACHE STRING "" FORCE
    )

    set(TAO_WHITELIST_TARGETS
      ${TAO_HOST_TOOLS}
      TAO TAO_AnyTypeCode TAO_CodecFactory TAO_BiDirGIOP TAO_CSD_Framework TAO_CSD_ThreadPool
      TAO_Codeset TAO_DynamicInterface TAO_ImR_Client TAO_IORManip TAO_IORTable TAO_Messaging
      TAO_PI TAO_PI_Server TAO_PortableServer TAO_Valuetype TAO_Async_IORTable TAO_Svc_Utils
      TAO_Async_ImR_Client_IDL TAO_ImR_Activator_IDL TAO_ImR_Locator_IDL TAO_ImR_Activator
      TAO_ImR_Locator ImR_Locator_Service ImR_Activator_Service tao_imr
      TAO_CosNaming_Skel TAO_CosNaming TAO_CosNaming_Serv Naming_Service Hello_Server tao_nsadd
      CACHE STRING "" FORCE
    )
  endif()
endif()


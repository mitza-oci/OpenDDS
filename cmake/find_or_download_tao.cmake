
if (NOT TARGET TAO)
  find_package(TAO CONFIG)

  if (NOT TAO_FOUND)
    include(cmake/DownloadProject.cmake)

    set(WHITELIST_TARGETS "" CACHE STRING "")

    download_project(PROJ                ACE_TAO
                     GIT_REPOSITORY      https://github.com/huangminghuang/ACE_TAO.git
                     GIT_SHALLOW 1
                     GIT_TAG             cmake
                     UPDATE_DISCONNECTED 1
    )

    set(DDS_WHITELIST_TARGETS ${WHITELIST_TARGETS})
    set(ACE_TAO_WHITELIST_TARGETS
      ACE ACE_XML_Utils ace_gperf
      TAO_IDL_FE TAO_IDL_BE TAO_IDL_EXE
      TAO TAO_AnyTypeCode TAO_CodecFactory TAO_BiDirGIOP TAO_CSD_Framework TAO_CSD_ThreadPool
      TAO_Codeset TAO_DynamicInterface TAO_ImR_Client TAO_IORManip TAO_IORTable TAO_Messaging
      TAO_PI TAO_PortableServer TAO_Valuetype TAO_Svc_Utils
      TAO_Async_ImR_Client_IDL TAO_ImR_Activator_IDL TAO_ImR_Locator_IDL TAO_ImR_Activator
      TAO_ImR_Locator ImR_Locator_Service ImR_Activator_Service tao_imr
      Naming_Service Hello_Server tao_nsadd
    )

    set(WHITELIST_TARGETS "${ACE_TAO_WHITELIST_TARGETS}" CACHE STRING "" FORCE)
    add_subdirectory(${ACE_TAO_SOURCE_DIR} ${ACE_TAO_BINARY_DIR})
    set(WHITELIST_TARGETS "${DDS_WHITELIST_TARGETS}" CACHE STRING "" FORCE)
  endif()
endif()

## This is the initial cache file for build ACE_TAO with targets only used by OpenDDS
## Usage:
## cmake -C path_to/ACE_TAO_for_DDS.cmake path_to/ACE_TAO

set(WHITELIST_TARGETS
  ACE ACE_XML_Utils ace_gperf ACEXML ACEXML_Parser
  TAO_IDL_FE TAO_IDL_BE TAO_IDL_EXE
  TAO TAO_AnyTypeCode TAO_CodecFactory TAO_BiDirGIOP TAO_CSD_Framework TAO_CSD_ThreadPool
  TAO_Codeset TAO_DynamicInterface TAO_ImR_Client TAO_IORManip TAO_IORTable TAO_Messaging
  TAO_PI TAO_PI_Server TAO_PortableServer TAO_Valuetype TAO_Async_IORTable TAO_Svc_Utils
  TAO_Async_ImR_Client_IDL TAO_ImR_Activator_IDL TAO_ImR_Locator_IDL TAO_ImR_Activator
  TAO_ImR_Locator ImR_Locator_Service ImR_Activator_Service tao_imr
  TAO_CosNaming_Skel TAO_CosNaming TAO_CosNaming_Serv Naming_Service Hello_Server tao_nsadd
  CACHE STRING ""
)

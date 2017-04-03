ace_requires (OPENDDS_SAFETY_PROFILE)

ace_add_lib(OpenDDS_Corba
  PACKAGE OpenDDS
  FOLDER dds/CORBA/tao
  DEFINE_SYMBOL TAO_BUILD_DLL
  PUBLIC_INCLUDE_DIRECTORIES ${ACE_TAO_SOURCE_DIR}/TAO
                             $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/..>
                             $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/..>
                             $<INSTALL_INTERFACE:${OpenDDS_INSTALL_DIR}>
  PUBLIC_LINK_LIBRARIES ACE
)

set(TAO_Core_idl_FLAGS ${TAO_VERSIONING_IDL_FLAGS}
            -GA -Gp -Gd -SS -Sorb -Sci
            -Wb,export_macro=TAO_Export
            -Wb,export_include=tao/TAO_Export.h
)

tao_idl_command(IDL_GEN
  IDL_FLAGS ${TAO_Core_idl_FLAGS}
  IDL_FILES ${ACE_TAO_SOURCE_DIR}/TAO/tao/CONV_FRAME.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/Current.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/IIOP.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/IIOP_Endpoints.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/IOP.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/Messaging_PolicyValue.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/Messaging_SyncScope.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/ObjectIdList.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/orb_types.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/Policy_Manager.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/Policy_Current.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/PI_Forward.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/PortableInterceptor.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/Services.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/TAO.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/TimeBase.pidl
)

tao_idl_command(IDL_GEN
  IDL_FLAGS ${TAO_Core_idl_FLAGS} -Sa
  IDL_FILES ${ACE_TAO_SOURCE_DIR}/TAO/tao/Policy_Forward.pidl
)

tao_idl_command(IDL_GEN
  IDL_FLAGS ${TAO_Core_idl_FLAGS} -Sat
  IDL_FILES ${ACE_TAO_SOURCE_DIR}/TAO/tao/ParameterMode.pidl
)

tao_idl_command(IDL_GEN
  IDL_FLAGS ${TAO_Core_idl_FLAGS} -Gse -Gata
  IDL_FILES ${ACE_TAO_SOURCE_DIR}/TAO/tao/BooleanSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/CharSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/DoubleSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/FloatSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/LongDoubleSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/LongLongSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/LongSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/OctetSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/ShortSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/StringSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/ULongLongSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/ULongSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/UShortSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/WCharSeq.pidl
            ${ACE_TAO_SOURCE_DIR}/TAO/tao/WStringSeq.pidl
)

tao_idl_command(IDL_GEN
  IDL_FLAGS ${TAO_VERSIONING_IDL_FLAGS}
            -GA -Gp -Gd
            -Wb,export_macro=TAO_Export
            -Wb,export_include=tao/TAO_Export.h -GT
            -oS PortableServer -Gd
            -Wb,safe_include=tao/PolicyC.h
            -Wb,skel_export_macro=TAO_PortableServer_Export
            -Wb,skel_export_include=tao/PortableServer/portableserver_export.h
  IDL_FILES ${ACE_TAO_SOURCE_DIR}/TAO/tao/Policy.pidl
)



ace_target_cxx_sources(OpenDDS_Corba
  SOURCE_FILES  Exception.cpp
                Inlines.cpp
                LocalObject.cpp
                ORB_Misc.cpp
                Object.cpp
                String_Alloc.cpp
                SystemException.cpp
  HEADER_FILES  Allocation_Macros.h
                PolicyS.h
                ${IDL_GEN_HEADER_FILES}
)


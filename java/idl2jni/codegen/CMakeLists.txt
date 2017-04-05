
if (OPENDDS_SAFETY_PROFILE OR CMAKE_CROSSCOMPILING)
  ## Happens when cross compiling
  message("OPENDDS_SAFETY_PROFILE OR CMAKE_CROSSCOMPILING")
  return()
endif()


ace_add_exe(idl2jni
  PACKAGE OpenDDS

  LINK_LIBRARIES TAO_IDL_FE
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}
  COMPILE_DEFINITIONS TAO_IDL_PREPROCESSOR=\"${CMAKE_CXX_COMPILER}\"
)

ace_target_cxx_sources(idl2jni
  SOURCE_FILES be_global.cpp
               be_init.cpp
               be_produce.cpp
               be_util.cpp
               drv_args.cpp
               drv_preproc.cpp
               idl2jni.cpp
               idl2jni_visitor.cpp
               idl_mapping.cpp
               im_java.cpp
               im_jni.cpp
  HEADER_FILES be_extern.h
               be_global.h
               be_util.h
               idl2jni_visitor.h
               idl_mapping.h
)
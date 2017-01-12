
ace_add_exe(opendds_idl
  PACKAGE OpenDDS
  FOLDER dds
  LINK_LIBRARIES TAO_IDL_FE
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}
  COMPILE_DEFINITIONS TAO_IDL_PREPROCESSOR=\"${CMAKE_CXX_COMPILER}\"
)

ace_target_cxx_sources(opendds_idl
  SOURCE_FILES  be_global.cpp
                be_init.cpp
                be_produce.cpp
                be_util.cpp
                dds_generator.cpp
                dds_visitor.cpp
                drv_args.cpp
                drv_preproc.cpp
                itl_generator.cpp
                keys_generator.cpp
                langmap_generator.cpp
                marshal_generator.cpp
                metaclass_generator.cpp
                opendds_idl.cpp
                ts_generator.cpp
                v8_generator.cpp
                wireshark_generator.cpp
  HEADER_FILES  be_extern.h
                be_global.h
                be_util.h
                dds_generator.h
                dds_visitor.h
                itl_generator.h
                keys_generator.h
                langmap_generator.h
                marshal_generator.h
                metaclass_generator.h
                ts_generator.h
                v8_generator.h
                wireshark_generator.h
)
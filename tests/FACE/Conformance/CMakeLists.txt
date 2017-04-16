
project(FaceConformanceIdl CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_lib(FaceConformanceIdl
  OUTPUT_NAME FaceConformanceIdl
  DEFINE_SYMBOL SAMPLEMODEL_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)
dds_idl_sources(
  TARGETS FaceConformanceIdl
  DDS_IDL_FLAGS -Wb,export_include=SampleModel_Export.h
                -Wb,export_macro=SampleModel_Export
  TAO_IDL_FLAGS -Wb,export_include=SampleModel_Export.h
                -Wb,export_macro=SampleModel_Export
  IDL_FILES SampleModel.idl
)


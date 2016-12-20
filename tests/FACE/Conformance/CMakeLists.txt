
project(FaceConformanceIdl CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_lib(FaceConformanceIdl
  OUTPUT_NAME FaceConformanceIdl
  FOLDER tests/FACE/Conformance
  DEFINE_SYMBOL SAMPLEMODEL_BUILD_DLL
  PUBLIC_LINK_LIBRARIES OpenDDS_FACE
)
add_face_idl_files(
  TARGETS FaceConformanceIdl
  DDS_IDL_FLAGS -Wb,export_include=SampleModel_Export.h
                -Wb,export_macro=SampleModel_Export
  TAO_IDL_FLAGS -Wb,export_include=SampleModel_Export.h
                -Wb,export_macro=SampleModel_Export
  IDL_FILES SampleModel.idl
)

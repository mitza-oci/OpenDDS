ace_requires(OPENDDS_HAS_OBJECT_MODEL_PROFILE)

ace_add_exe(Presentation
  OUTPUT_NAME tester
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Tcp
                 DcpsFooType
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Presentation
  SOURCE_FILES main.cpp
)
ace_target_cxx_sources(Presentation
  SOURCE_FILES main.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Presentation/run_test.pl"
  COMMAND run_test.pl
)

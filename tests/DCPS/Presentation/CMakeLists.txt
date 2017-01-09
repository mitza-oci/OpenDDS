ace_requires(OBJECT_MODEL_PROFILE)

ace_add_exe(Presentation
  OUTPUT_NAME tester
  FOLDER tests/DCPS/Presentation
  ASPECTS DCPS_DEFAULT_DISCOVERY
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Tcp
                 DcpsFooType
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Presentation
  SOURCE_FILES main.cpp
)
target_cxx_sources(Presentation
  SOURCE_FILES main.cpp
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/Presentation/run_test.pl"
  COMMAND run_test.pl
)

requires(OBJECT_MODEL_PROFILE)

add_ace_exe(Presentation
  OUTPUT_NAME tester
  FOLDER tests/DCPS/Presentation
  ASPECTS DCPS_DEFAULT_DISCOVERY
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Tcp
                 DcpsFooType
)
target_cxx_sources(Presentation
  SOURCE_FILES main.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Presentation/run_test.pl"
  COMMAND run_test.pl
)

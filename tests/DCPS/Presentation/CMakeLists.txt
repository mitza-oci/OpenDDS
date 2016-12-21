requires(OBJECT_MODEL_PROFILE)

add_ace_exe(Presentation
  OUTPUT_NAME tester
  SOURCE_FILES main.cpp
  FOLDER tests/DCPS/Presentation
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../FooType
                      ${CMAKE_CURRENT_BINARY_DIR}/../FooType
  LINK_LIBRARIES OpenDDS_Tcp
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 DcpsFooType
)

add_custom_command(TARGET Presentation
                   POST_BUILD
                   COMMAND ${CMAKE_COMMAND} -E create_symlink tester test
                   WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/Presentation/run_test.pl"
  COMMAND run_test.pl
)

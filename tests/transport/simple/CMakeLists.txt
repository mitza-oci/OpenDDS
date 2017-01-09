project(DDS_transport_simple CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_requires(NO_OPENDDS_SAFETY_PROFILE)

ace_add_exe(DDS_transport_simple_Publisher
  OUTPUT_NAME simple_publisher
  FOLDER tests/transport/simple
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_Shmem
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_transport_simple_Publisher
  SOURCE_FILES PubDriver.cpp
               SimpleDataWriter.cpp
               pub_main.cpp
  HEADER_FILES PubDriver.h
               SimpleDataWriter.h
)


ace_add_exe(DDS_transport_simple_Subscriber
  OUTPUT_NAME simple_subscriber
  FOLDER tests/transport/simple
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_Shmem
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(DDS_transport_simple_Subscriber
  SOURCE_FILES SimpleDataReader.cpp
               SubDriver.cpp
               sub_main.cpp
  HEADER_FILES SimpleDataReader.h
               SubDriver.h
)

include(${DDS_ROOT}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/transport/simple/run_test.pl bp"
  COMMAND run_test.pl bp
  LABELS DDS_TRANSPORT
)


dds_add_test("tests/transport/simple/run_test.pl n"
  COMMAND run_test.pl n
  LABELS DDS_TRANSPORT
)


dds_add_test("tests/transport/simple/run_test.pl"
  COMMAND run_test.pl
  LABELS DDS_TRANSPORT
)


dds_add_test("tests/transport/simple/run_test.pl shmem bp"
  COMMAND run_test.pl shmem bp
  LABELS DDS_TRANSPORT SHMEM
)


dds_add_test("tests/transport/simple/run_test.pl shmem n"
  COMMAND run_test.pl shmem n
  LABELS DDS_TRANSPORT SHMEM
)


dds_add_test("tests/transport/simple/run_test.pl shmem"
  COMMAND run_test.pl shmem
  LABELS DDS_TRANSPORT SHMEM
)

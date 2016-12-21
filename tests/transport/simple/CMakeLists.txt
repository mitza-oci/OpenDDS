project(DDS_transport_simple CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


requires(NO_OPENDDS_SAFETY_PROFILE)

add_ace_exe(DDS_transport_simple_Publisher
  OUTPUT_NAME simple_publisher
  SOURCE_FILES pub_main.cpp
               PubDriver.cpp
               SimpleDataWriter.cpp
  HEADER_FILES PubDriver.h
               SimpleDataWriter.h
  FOLDER tests/transport/simple
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_Shmem
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

add_ace_exe(DDS_transport_simple_Subscriber
  OUTPUT_NAME simple_subscriber
  SOURCE_FILES sub_main.cpp
               SubDriver.cpp
               SimpleDataReader.cpp
  HEADER_FILES SubDriver.h
               SimpleDataReader.h
  FOLDER tests/transport/simple
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_Shmem
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/transport/simple/run_test.pl bp"
  COMMAND run_test.pl bp
  LABELS DDS_TRANSPORT
)


add_dds_test("tests/transport/simple/run_test.pl n"
  COMMAND run_test.pl n
  LABELS DDS_TRANSPORT
)


add_dds_test("tests/transport/simple/run_test.pl"
  COMMAND run_test.pl
  LABELS DDS_TRANSPORT
)


add_dds_test("tests/transport/simple/run_test.pl shmem bp"
  COMMAND run_test.pl shmem bp
  LABELS DDS_TRANSPORT SHMEM
)


add_dds_test("tests/transport/simple/run_test.pl shmem n"
  COMMAND run_test.pl shmem n
  LABELS DDS_TRANSPORT SHMEM
)


add_dds_test("tests/transport/simple/run_test.pl shmem"
  COMMAND run_test.pl shmem
  LABELS DDS_TRANSPORT SHMEM
)

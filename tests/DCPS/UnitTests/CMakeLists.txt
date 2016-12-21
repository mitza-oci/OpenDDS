project(UnitTests CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(UnitTests_DisjointSequence
  OUTPUT_NAME UnitTests_DisjointSequence
  SOURCE_FILES DisjointSequence.cpp
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)

add_ace_exe(UnitTests_LivelinessCompatibility
  OUTPUT_NAME UnitTests_LivelinessCompatibility
  SOURCE_FILES LivelinessCompatibility.cpp
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)

add_ace_exe(UnitTests_SequenceNumber
  OUTPUT_NAME UnitTests_SequenceNumber
  SOURCE_FILES SequenceNumber.cpp
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)

add_ace_exe(UnitTests_DurationToTimeValue
  OUTPUT_NAME UnitTests_DurationToTimeValue
  SOURCE_FILES DurationToTimeValue.cpp
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)

add_ace_exe(UnitTests_TimeTSubtraction
  OUTPUT_NAME UnitTests_TimeTSubtraction
  SOURCE_FILES TimeTSubtraction.cpp
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)

add_ace_exe(UnitTests_Fragmentation
  OUTPUT_NAME UnitTests_Fragmentation
  SOURCE_FILES Fragmentation.cpp
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)

add_ace_exe(UnitTests_Reassembly
  OUTPUT_NAME UnitTests_Reassembly
  SOURCE_FILES ut_Reassembly.cpp
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Dcps
)

add_ace_exe(UnitTests_RtpsFragmentation
  OUTPUT_NAME UnitTests_RtpsFragmentation
  SOURCE_FILES RtpsFragmentation.cpp
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Rtps_Udp
)

add_ace_exe(UnitTests_GuidGenerator
  OUTPUT_NAME UnitTests_GuidGenerator
  SOURCE_FILES GuidGenerator.cpp
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES OpenDDS_Rtps
)

add_ace_exe(UnitTests_ParameterListConverter
  OUTPUT_NAME UnitTests_ParameterListConverter
  SOURCE_FILES ut_ParameterListConverter.cpp
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES OpenDDS_Rtps
)

add_ace_exe(UnitTests_RepoIdSequence
  OUTPUT_NAME UnitTests_RepoIdSequence
  SOURCE_FILES ut_RepoIdSequence.cpp
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES OpenDDS_Rtps
)

add_ace_exe(UnitTests_BIT_DataReader
  OUTPUT_NAME UnitTests_BIT_DataReader
  SOURCE_FILES ut_BIT_DataReader.cpp
  REQUIRES BUILT_IN_TOPICS
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Rtps_Udp
)

include(${DDS_ROOT}/cmake/AddDdsTest.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/UnitTests/run_test.pl"
  COMMAND run_test.pl
)

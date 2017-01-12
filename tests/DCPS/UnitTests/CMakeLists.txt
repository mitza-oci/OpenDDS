project(UnitTests CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


add_ace_exe(UnitTests_Disjointsequence
  OUTPUT_NAME UnitTests_Disjointsequence
  FOLDER tests/DCPS/UnitTests
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(UnitTests_Disjointsequence
  SOURCE_FILES DisjointSequence.cpp
)


add_ace_exe(UnitTests_Livelinesscompatibility
  OUTPUT_NAME UnitTests_Livelinesscompatibility
  FOLDER tests/DCPS/UnitTests
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(UnitTests_Livelinesscompatibility
  SOURCE_FILES LivelinessCompatibility.cpp
)


add_ace_exe(UnitTests_Sequencenumber
  OUTPUT_NAME UnitTests_Sequencenumber
  FOLDER tests/DCPS/UnitTests
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(UnitTests_Sequencenumber
  SOURCE_FILES SequenceNumber.cpp
)


add_ace_exe(UnitTests_Durationtotimevalue
  OUTPUT_NAME UnitTests_Durationtotimevalue
  FOLDER tests/DCPS/UnitTests
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(UnitTests_Durationtotimevalue
  SOURCE_FILES DurationToTimeValue.cpp
)


add_ace_exe(UnitTests_Timetsubtraction
  OUTPUT_NAME UnitTests_Timetsubtraction
  FOLDER tests/DCPS/UnitTests
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(UnitTests_Timetsubtraction
  SOURCE_FILES TimeTSubtraction.cpp
)


add_ace_exe(UnitTests_Fragmentation
  OUTPUT_NAME UnitTests_Fragmentation
  FOLDER tests/DCPS/UnitTests
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(UnitTests_Fragmentation
  SOURCE_FILES Fragmentation.cpp
)


add_ace_exe(UnitTests_Reassembly
  OUTPUT_NAME UnitTests_Reassembly
  FOLDER tests/DCPS/UnitTests
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Dcps
)
target_cxx_sources(UnitTests_Reassembly
  SOURCE_FILES ut_Reassembly.cpp
)


add_ace_exe(UnitTests_Rtpsfragmentation
  OUTPUT_NAME UnitTests_Rtpsfragmentation
  FOLDER tests/DCPS/UnitTests
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Rtps_Udp
)
target_cxx_sources(UnitTests_Rtpsfragmentation
  SOURCE_FILES RtpsFragmentation.cpp
)


add_ace_exe(UnitTests_Guidgenerator
  OUTPUT_NAME UnitTests_Guidgenerator
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES OpenDDS_Rtps
)
target_cxx_sources(UnitTests_Guidgenerator
  SOURCE_FILES GuidGenerator.cpp
)


add_ace_exe(UnitTests_Parameterlistconverter
  OUTPUT_NAME UnitTests_Parameterlistconverter
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES OpenDDS_Rtps
)
target_cxx_sources(UnitTests_Parameterlistconverter
  SOURCE_FILES ut_ParameterListConverter.cpp
)


add_ace_exe(UnitTests_Repoidsequence
  OUTPUT_NAME UnitTests_Repoidsequence
  FOLDER tests/DCPS/UnitTests
  LINK_LIBRARIES OpenDDS_Rtps
)
target_cxx_sources(UnitTests_Repoidsequence
  SOURCE_FILES ut_RepoIdSequence.cpp
)


add_ace_exe(UnitTests_Bit_datareader
  OUTPUT_NAME UnitTests_Bit_datareader
  REQUIRES BUILT_IN_TOPICS
  FOLDER tests/DCPS/UnitTests
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Rtps_Udp
)
target_cxx_sources(UnitTests_Bit_datareader
  SOURCE_FILES ut_BIT_DataReader.cpp
)

include(${DDS_ROOT}/cmake/add_dds_test.cmake)
configure_dds_test_files()


add_dds_test("tests/DCPS/UnitTests/run_test.pl"
  COMMAND run_test.pl
)

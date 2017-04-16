project(UnitTests CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT OpenDDS_INCLUDE_DIR)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


ace_add_exe(UnitTests_Disjointsequence
  OUTPUT_NAME UnitTests_Disjointsequence
  LINK_LIBRARIES OpenDDS_Default_Discovery
)
ace_target_cxx_sources(UnitTests_Disjointsequence
  SOURCE_FILES DisjointSequence.cpp
)


ace_add_exe(UnitTests_Livelinesscompatibility
  OUTPUT_NAME UnitTests_Livelinesscompatibility
  LINK_LIBRARIES OpenDDS_Default_Discovery
)
ace_target_cxx_sources(UnitTests_Livelinesscompatibility
  SOURCE_FILES LivelinessCompatibility.cpp
)


ace_add_exe(UnitTests_Sequencenumber
  OUTPUT_NAME UnitTests_Sequencenumber
  LINK_LIBRARIES OpenDDS_Default_Discovery
)
ace_target_cxx_sources(UnitTests_Sequencenumber
  SOURCE_FILES SequenceNumber.cpp
)


ace_add_exe(UnitTests_Durationtotimevalue
  OUTPUT_NAME UnitTests_Durationtotimevalue
  LINK_LIBRARIES OpenDDS_Default_Discovery
)
ace_target_cxx_sources(UnitTests_Durationtotimevalue
  SOURCE_FILES DurationToTimeValue.cpp
)


ace_add_exe(UnitTests_Timetsubtraction
  OUTPUT_NAME UnitTests_Timetsubtraction
  LINK_LIBRARIES OpenDDS_Default_Discovery
)
ace_target_cxx_sources(UnitTests_Timetsubtraction
  SOURCE_FILES TimeTSubtraction.cpp
)


ace_add_exe(UnitTests_Fragmentation
  OUTPUT_NAME UnitTests_Fragmentation
  LINK_LIBRARIES OpenDDS_Default_Discovery
)
ace_target_cxx_sources(UnitTests_Fragmentation
  SOURCE_FILES Fragmentation.cpp
)


ace_add_exe(UnitTests_Reassembly
  OUTPUT_NAME UnitTests_Reassembly
  LINK_LIBRARIES OpenDDS_Default_Discovery
)
ace_target_cxx_sources(UnitTests_Reassembly
  SOURCE_FILES ut_Reassembly.cpp
)


ace_add_exe(UnitTests_Rtpsfragmentation
  OUTPUT_NAME UnitTests_Rtpsfragmentation
  LINK_LIBRARIES OpenDDS_Rtps_Udp
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(UnitTests_Rtpsfragmentation
  SOURCE_FILES RtpsFragmentation.cpp
)


ace_add_exe(UnitTests_Guidgenerator
  OUTPUT_NAME UnitTests_Guidgenerator
  LINK_LIBRARIES OpenDDS_Rtps
)
ace_target_cxx_sources(UnitTests_Guidgenerator
  SOURCE_FILES GuidGenerator.cpp
)


ace_add_exe(UnitTests_Parameterlistconverter
  OUTPUT_NAME UnitTests_Parameterlistconverter
  LINK_LIBRARIES OpenDDS_Rtps
)
ace_target_cxx_sources(UnitTests_Parameterlistconverter
  SOURCE_FILES ut_ParameterListConverter.cpp
)


ace_add_exe(UnitTests_Repoidsequence
  OUTPUT_NAME UnitTests_Repoidsequence
  LINK_LIBRARIES OpenDDS_Rtps
)
ace_target_cxx_sources(UnitTests_Repoidsequence
  SOURCE_FILES ut_RepoIdSequence.cpp
)


ace_add_exe(UnitTests_Bit_datareader
  OUTPUT_NAME UnitTests_Bit_datareader
  REQUIRES OPENDDS_HAS_BUILT_IN_TOPICS
  LINK_LIBRARIES OpenDDS_Default_Discovery
                 OpenDDS_Rtps_Udp
)
ace_target_cxx_sources(UnitTests_Bit_datareader
  SOURCE_FILES ut_BIT_DataReader.cpp
)

include(${OpenDDS_INCLUDE_DIR}/cmake/dds_add_test.cmake)
dds_configure_test_files()


dds_add_test("tests/DCPS/UnitTests/run_test.pl"
  COMMAND run_test.pl
)



ace_add_exe(Reliability_Subscriber
  OUTPUT_NAME subscriber
  FOLDER tests/DCPS/Reliability/sub
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../IDL
                      ${CMAKE_CURRENT_BINARY_DIR}/../IDL
                      ${CMAKE_CURRENT_SOURCE_DIR}/..
                      ${CMAKE_CURRENT_BINARY_DIR}/..
  LINK_LIBRARIES OpenDDS_Transports_For_Test
                 OpenDDS_Model
                 Reliability
                 OpenDDS_Default_Discovery
)
ace_target_cxx_sources(Reliability_Subscriber
  SOURCE_FILES ../Boilerplate.cpp
               DataReaderListenerImpl.cpp
               SeqReaderListenerImpl.cpp
               Subscriber.cpp
               TakeNextReaderListenerImpl.cpp
               ZeroCopyReaderListenerImpl.cpp
  HEADER_FILES DataReaderListenerImpl.h
               SeqReaderListenerImpl.h
               TakeNextReaderListenerImpl.h
               ZeroCopyReaderListenerImpl.h
)


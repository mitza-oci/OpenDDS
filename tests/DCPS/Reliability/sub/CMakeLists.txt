

add_ace_exe(Reliability_Subscriber
  OUTPUT_NAME subscriber
  SOURCE_FILES DataReaderListenerImpl.cpp
               TakeNextReaderListenerImpl.cpp
               SeqReaderListenerImpl.cpp
               ZeroCopyReaderListenerImpl.cpp
               Subscriber.cpp
               ../Boilerplate.cpp
  HEADER_FILES DataReaderListenerImpl.h
               TakeNextReaderListenerImpl.h
               SeqReaderListenerImpl.h
               ZeroCopyReaderListenerImpl.h
  FOLDER tests/DCPS/Reliability/sub
  INCLUDE_DIRECTORIES ${CMAKE_CURRENT_SOURCE_DIR}/../IDL
                      ${CMAKE_CURRENT_BINARY_DIR}/../IDL
                      ${CMAKE_CURRENT_SOURCE_DIR}/..
                      ${CMAKE_CURRENT_BINARY_DIR}/..
  LINK_LIBRARIES OpenDDS_Model
                 Reliability
                 ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 ${DCPS_TRANSPORTS_FOR_TEST}
)

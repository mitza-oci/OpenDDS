
find_package(Java)
find_package(JNI)

ace_requires(JAVA_FOUND JNI_FOUND)

option(FULL_JRE "" ON)
set(OPENDDS_JARS i2jrt OpenDDS_DCPS_jar CACHE INTERNAL "")
if (NOT FULL_JRE)
  list(APPEND OPENDDS_JARS i2jrt_compact)
endif()


include(../cmake/dds_java.cmake)

add_subdirectory(idl2jni)
add_subdirectory(tao)
add_subdirectory(dds)
add_subdirectory(tests)

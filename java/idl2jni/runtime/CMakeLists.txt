
ace_requires(BUILD_SHARED_LIBS)

#set(CMAKE_JAVA_COMPILE_FLAGS -sourcepath . -d classes -classpath . -implicit:none)
add_jar(i2jrt
  SOURCES i2jrt/ORB.java
          i2jrt/TAOLocalObject.java
          i2jrt/TAOObject.java
  VERSION ${OpenDDS_VERSION}
  OUTPUT_DIR ${CMAKE_BINARY_DIR}/lib
)

set_target_properties(i2jrt PROPERTIES
  FOLDER java/idl2jni/runtime
)

create_javah(GENERATED_FILES i2jrt_headers
  CLASSES i2jrt.ORB i2jrt.TAOLocalObject i2jrt.TAOObject
  CLASSPATH i2jrt
)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

if (NOT APPLE)
  # In MacOSm ${JNI_LIBRARIES} contains libawt and linking
  # with libawt causes SIGFAULT.
  set(jnilibs ${JNI_LIBRARIES})
endif()

ace_add_lib(idl2jni_runtime
  DEFINE_SYMBOL IDL2JNI_RUNTIME_BUILD_DLL
  PACKAGE OpenDDS
  FOLDER java/idl2jni/runtime
  PUBLIC_INCLUDE_DIRECTORIES ${JNI_INCLUDE_DIRS}
                             $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                             $<INSTALL_INTERFACE:${OpenDDS_INSTALL_DIR}/java/idl2jni/runtime>
  PUBLIC_LINK_LIBRARIES TAO ${jnilibs}
)

ace_target_cxx_sources(idl2jni_runtime
  SOURCE_FILES i2jrt_ORB.cpp
               i2jrt_TAOObject.cpp
               idl2jni_runtime.cpp
  HEADER_FILES idl2jni_BaseJavaPeer.h
               idl2jni_jni.h
               idl2jni_runtime_Export.h
               idl2jni_runtime.h
               ${i2jrt_headers}
)

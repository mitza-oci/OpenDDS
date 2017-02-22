include(UseJava)

define_property(SOURCE PROPERTY IDL2JNI_FLAGS
  BRIEF_DOCS "sets additional idl2jni compiler flags used to build sources within the target"
  FULL_DOCS "sets additional idl2jni compiler flags used to build sources within the target"
)

if (NOT BUILT_IN_TOPICS)
  list(APPEND BASE_IDL2JNI_FLAGS -DDDS_HAS_MINIMUM_BIT)
endif()

if (NOT CONTENT_SUBSCRIPTION)
  list(APPEND BASE_IDL2JNI_FLAGS -DOPENDDS_NO_QUERY_CONDITION
                                 -DOPENDDS_NO_CONTENT_FILTERED_TOPIC
                                 -DOPENDDS_NO_MULTI_TOPIC)
endif()

if (NOT QUERY_CONDITION)
  list(APPEND BASE_IDL2JNI_FLAGS  -DOPENDDS_NO_QUERY_CONDITION)
endif()

if (NOT CONTENT_FILTERED_TOPIC)
  list(APPEND BASE_IDL2JNI_FLAGS -DOPENDDS_NO_CONTENT_FILTERED_TOPIC)
endif()

if (NOT MULTI_TOPIC)
  list(APPEND BASE_IDL2JNI_FLAGS -DOPENDDS_NO_MULTI_TOPIC)
endif()

if (NOT OWNERSHIP_PROFILE)
  list(APPEND BASE_IDL2JNI_FLAGS -DOPENDDS_NO_OWNERSHIP_PROFILE
                                 -DOPENDDS_NO_OWNERSHIP_KIND_EXCLUSIVE)
endif()

if (NOT OWNERSHIP_KIND_EXCLUSIVE)
  list(APPEND BASE_IDL2JNI_FLAGS -DOPENDDS_NO_OWNERSHIP_KIND_EXCLUSIVE)
endif()

if (NOT OBJECT_MODEL_PROFILE)
  list(APPEND BASE_IDL2JNI_FLAGS -DOPENDDS_NO_OBJECT_MODEL_PROFILE)
endif()

if (NOT PERSISTENCE_PROFILE)
  list(APPEND BASE_IDL2JNI_FLAGS -DOPENDDS_NO_PERSISTENCE_PROFILE)
endif()


function(dds_idl2jni_command name)
  ### Warning, all filename in IDL_FILES must be absolute
  set(multiValueArgs FLAGS IDL_FILES)
  cmake_parse_arguments(_arg "" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  set(all_cxx_outputs)
  set(all_java_lists)


  foreach(file ${_arg_IDL_FILES})
    get_filename_component(basename ${file} NAME_WE)
    get_filename_component(filename_no_dir ${file} NAME)
    get_filename_component(abs_filename ${file} ABSOLUTE)
    set(cxx_outputs ${basename}JC.h ${basename}JC.cpp)

    get_property(file_idl2jni_flags SOURCE ${file} PROPERTY IDL2JNI_FLAGS)
    list(APPEND file_idl2jni_flags ${_arg_FLAGS})

    if (NOT "-SS" IN_LIST file_idl2jni_flags)
      list(APPEND cxx_outputs ${basename}JS.h ${basename}JS.cpp)
    endif()
    list(APPEND all_cxx_outputs ${cxx_outputs})

    list(APPEND all_java_lists @${CMAKE_CURRENT_BINARY_DIR}/${filename_no_dir}.java.list)

    add_custom_command(
      OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${filename_no_dir}.java.list ${cxx_outputs}
      COMMAND idl2jni -j ${BASE_IDL2JNI_FLAGS} -I${CMAKE_CURRENT_SOURCE_DIR} ${file_idl2jni_flags} ${abs_filename}
      DEPENDS idl2jni ${abs_filename}
    )
  endforeach()
  source_group("Generated Files" FILES ${all_java_lists})

  set(${name}_CXX_OUTPUTS ${${name}_CXX_OUTPUTS} ${all_cxx_outputs})
  set(${name}_JAVA_OUTPUTS ${${name}_JAVA_OUTPUTS} ${all_java_lists})

  set(${name}_CXX_OUTPUTS ${${name}_CXX_OUTPUTS} PARENT_SCOPE)
  set(${name}_JAVA_OUTPUTS ${${name}_JAVA_OUTPUTS} PARENT_SCOPE)
endfunction()

function(dds_add_taoidl_jar _target_name)
  set(oneValueArgs OUTPUT_NAME VERSION LIB OUTPUT_DIR FOLDER)
  set(multiValueArgs TAO_IDL_FLAGS IDL2JNI_FLAGS IDL_FILES INCLUDE_JARS SOURCES)
  cmake_parse_arguments(_arg "" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if (NOT DEFINED _arg_OUTPUT_NAME)
    set(_arg_OUTPUT_NAME ${_target_name})
  endif()

  if (NOT DEFINED _arg_OUTPUT_DIR)
    set(_arg_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR})
  endif()

  target_link_libraries(${_arg_LIB} PUBLIC
    idl2jni_runtime TAO_PortableServer)

  tao_idl_sources(
    TARGETS ${_arg_LIB}
    IDL_FLAGS ${_arg_TAO_IDL_FLAGS}
    IDL_FILES ${_arg_IDL_FILES}
  )

  set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON PARENT_SCOPE)
  set(CMAKE_INCLUDE_CURRENT_DIR ON PARENT_SCOPE)

  get_target_property(libname ${_arg_LIB} OUTPUT_NAME)
  if (NOT libname)
    set(libname ${_arg_LIB})
  endif()

  dds_idl2jni_command(${_target_name}_idl2jni
    FLAGS -Wb,native_lib_name=${libname} ${_arg_IDL2JNI_FLAGS}
    IDL_FILES ${_arg_IDL_FILES}
  )

  if (${_target_name}_idl2jni_CXX_OUTPUTS)
    target_sources(${_arg_LIB} PRIVATE
      ${${_target_name}_idl2jni_CXX_OUTPUTS}
    )
  endif()

  add_jar(${_target_name}
    OUTPUT_NAME "${_arg_OUTPUT_NAME}"
    OUTPUT_DIR "${_arg_OUTPUT_DIR}"
    VERSION ${_arg_VERSION}
    INCLUDE_JARS i2jrt ${_arg_INCLUDE_JARS}
    SOURCES ${${_target_name}_idl2jni_JAVA_OUTPUTS} ${_arg_SOURCES}
  )

  if (DEFINED _arg_FOLDER)
    set_target_properties(${_target_name} PROPERTIES FOLDER ${_arg_FOLDER})
  endif()

endfunction()

function(dds_add_ddsidl_jar _target_name)
  set(oneValueArgs OUTPUT_NAME VERSION LIB OUTPUT_DIR FOLDER)
  set(multiValueArgs TAO_IDL_FLAGS DDS_IDL_FLAGS IDL2JNI_FLAGS IDL_FILES INCLUDE_JARS SOURCES)
  cmake_parse_arguments(_arg "" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

  if (NOT DEFINED _arg_OUTPUT_NAME)
    set(_arg_OUTPUT_NAME ${_target_name})
  endif()

  if (NOT DEFINED _arg_OUTPUT_DIR)
    set(_arg_OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR})
  endif()

  if (_arg_VERSION)
    set(version_option VERSION ${_arg_VERSION})
  endif()

  target_link_libraries(${_arg_LIB} PUBLIC
    OpenDDS_DCPS_Java
  )

  dds_idl_sources(
    TARGETS ${_arg_LIB}
    TAO_IDL_FLAGS ${_arg_TAO_IDL_FLAGS}
    DDS_IDL_FLAGS -Wb,java ${_arg_DDS_IDL_FLAGS}
    IDL_FILES ${_arg_IDL_FILES}
  )

  set(CMAKE_INCLUDE_CURRENT_DIR_IN_INTERFACE ON PARENT_SCOPE)
  set(CMAKE_INCLUDE_CURRENT_DIR ON PARENT_SCOPE)

  get_target_property(libname ${_arg_LIB} OUTPUT_NAME)
  if (NOT libname)
    set(libname ${_arg_LIB})
  endif()

  dds_idl2jni_command(${_target_name}_idl2jni
    FLAGS -Wb,native_lib_name=${libname} -SS -I${OpenDDS_ROOT} -I${TAO_ROOT} ${_arg_IDL2JNI_FLAGS}
    IDL_FILES ${_arg_IDL_FILES} ${DDS_IDL_TYPESUPPORT_IDLS}
  )

  if (${_target_name}_idl2jni_CXX_OUTPUTS)
    target_sources(${_arg_LIB} PRIVATE
      ${${_target_name}_idl2jni_CXX_OUTPUTS}
    )
  endif()

  add_jar(${_target_name}
    OUTPUT_NAME "${_arg_OUTPUT_NAME}"
    OUTPUT_DIR "${_arg_OUTPUT_DIR}"
    ${version_option}
    INCLUDE_JARS i2jrt OpenDDS_Dcps_jar  ${_arg_INCLUDE_JARS}
    SOURCES ${${_target_name}_idl2jni_JAVA_OUTPUTS} ${_arg_SOURCES} ${DDS_IDL_JAVA_OUTPUTS}
  )

  if (DEFINED _arg_FOLDER)
    set_target_properties(${_target_name} PROPERTIES FOLDER ${_arg_FOLDER})
  endif()

endfunction()
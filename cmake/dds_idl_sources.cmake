
if (NOT DDS_ROOT AND TARGET OpenDDS_Dcps)
# TAO_ROOT is not set, it indicates this file is included from the projects other than TAO
  get_target_property(DDS_INCLUDE_DIRS OpenDDS_Dcps INTERFACE_INCLUDE_DIRECTORIES)
  # set TAO_ROOT to be first element in ${TAO_INCLUDE_DIRS}
  list(GET DDS_INCLUDE_DIRS 0 DDS_ROOT)
endif()

define_property(SOURCE PROPERTY DDS_IDL_FLAGS
  BRIEF_DOCS "sets additional opendds_idl compiler flags used to build sources within the target"
  FULL_DOCS "sets additional opendds_idl compiler flags used to build sources within the target"
)

set(DDS_CMAKE_DIR ${CMAKE_CURRENT_LIST_DIR})

if (DDS_SUPPRESS_ANYS)
  list(APPEND TAO_BASE_IDL_FLAGS -Sa -St)
  list(APPEND DDS_BASE_IDL_FLAGS -Sa -St)
endif()

if (NOT NO_OPENDDS_SAFETY_PROFILE)
  list(APPEND TAO_BASE_IDL_FLAGS -DOPENDDS_SAFETY_PROFILE)
  list(APPEND DDS_BASE_IDL_FLAGS -DOPENDDS_SAFETY_PROFILE)
endif()

foreach(opt ${OPENDDS_BASE_OPTIONS})
  if (NOT ${opt})
    list(APPEND TAO_BASE_IDL_FLAGS -DOPENDDS_NO_${opt})
    list(APPEND DDS_BASE_IDL_FLAGS -DOPENDDS_NO_${opt})
  endif()
endforeach()

list(APPEND TAO_BASE_IDL_FLAGS -I${DDS_ROOT})

function(add_dds_idl_command Name)
  set(add_dds_idl_command_usage "add_dds_idl_command(<Name> TAO_IDL_FLAGS flags DDS_IDL_FLAGS flags IDL_FILES Input1 Input2 ...]")

  set(multiValueArgs TAO_IDL_FLAGS DDS_IDL_FLAGS IDL_FILES WORKING_DIRECTORY)
  cmake_parse_arguments(_arg "NO_TAO_IDL" "" "${multiValueArgs}" ${ARGN})

  if (NOT IS_ABSOLUTE "${_arg_WORKING_DIRECTORY}")
    set(_working_binary_dir ${CMAKE_CURRENT_BINARY_DIR}/${_arg_WORKING_DIRECTORY})
    set(_working_source_dir ${CMAKE_CURRENT_SOURCE_DIR}/${_arg_WORKING_DIRECTORY})
  else()
    set(_working_binary_dir ${_arg_WORKING_DIRECTORY})
    set(_working_source_dir ${CMAKE_CURRENT_SOURCE_DIR})
  endif()

  ## remove trailing slashes
  string(REGEX REPLACE "/$" "" _working_binary_dir ${_working_binary_dir})
  string(REGEX REPLACE "/$" "" _working_source_dir ${_working_source_dir})

  ## opendds_idl would generate different codes with the -I flag followed by absolute path
  ## or relative path, if it's a relatvie path we need to keep it a relative path to the binary tree
  file(RELATIVE_PATH _rel_path_to_source_tree ${_working_binary_dir} ${_working_source_dir})

  foreach(flag ${_arg_DDS_IDL_FLAGS})
    if ("${flag}" MATCHES "^-I(\\.\\..*)")
       list(APPEND _converted_dds_idl_flags -I${_rel_path_to_source_tree}/${CMAKE_MATCH_1})
     else()
       list(APPEND _converted_dds_idl_flags ${flag})
    endif()
  endforeach()

  set(_ddsidl_flags ${DDS_BASE_IDL_FLAGS} ${_converted_dds_idl_flags})

  # cmake_parse_arguments(_ddsidl_cmd_arg "-SI;-GfaceTS" "-o" "" ${_ddsidl_flags})

  set(_dds_idl_outputs)
  set(_type_support_idls)
  set(_type_support_javas)
  set(_taoidl_inputs)

  foreach(input ${_arg_IDL_FILES})
    unset(_ddsidl_cmd_arg_-SI)
    unset(_ddsidl_cmd_arg_-GfaceTS)
    unset(_ddsidl_cmd_arg_-o)
    unset(_ddsidl_cmd_arg_-Wb,java)

    get_property(file_dds_idl_flags SOURCE ${input} PROPERTY DDS_IDL_FLAGS)
    cmake_parse_arguments(_ddsidl_cmd_arg "-SI;-GfaceTS;-Wb,java" "-o" "" ${_ddsidl_flags} ${file_dds_idl_flags})

    get_filename_component(noext_name ${input} NAME_WE)
    get_filename_component(abs_filename ${input} ABSOLUTE)
    get_filename_component(file_ext ${input} EXT)

    if (_ddsidl_cmd_arg_-o)
      set(output_prefix ${_working_binary_dir}/${_ddsidl_cmd_arg_-o}/${noext_name})
    else()
      set(output_prefix ${_working_binary_dir}/${noext_name})
    endif()

    if (NOT _ddsidl_cmd_arg_-SI)
      set(_cur_type_support_idl ${output_prefix}TypeSupport.idl)
      list(APPEND _type_support_idls ${_cur_type_support_idl})
      list(APPEND _taoidl_inputs ${_cur_type_support_idl})
    else()
      unset(_cur_type_support_idl)
    endif()

    set(_cur_idl_headers ${output_prefix}TypeSupportImpl.h)
    set(_cur_idl_outputs ${output_prefix}TypeSupportImpl.cpp ${_cur_idl_headers})

    if (_ddsidl_cmd_arg_-GfaceTS)
      list(APPEND _cur_idl_headers ${output_prefix}C.h ${output_prefix}_TS.hpp)
      list(APPEND _cur_idl_outputs ${output_prefix}C.h ${output_prefix}_TS.hpp ${output_prefix}_TS.cpp)
      ## if this is FACE IDL, do not reprocess the original idl file throught tao_idl
    else()
      list(APPEND _taoidl_inputs ${input})
    endif()

    list(APPEND _dds_idl_outputs ${_cur_idl_outputs})
    list(APPEND _dds_idl_headers ${_cur_idl_headers})

    if (_ddsidl_cmd_arg_-Wb,java)
      set(_cur_java_list "${output_prefix}${file_ext}.TypeSupportImpl.java.list")
      list(APPEND _type_support_javas "@${_cur_java_list}")
      list(APPEND file_dds_idl_flags -j)
    else()
      unset(_cur_java_list)
    endif()

    add_custom_command(
      OUTPUT ${_cur_idl_outputs} ${_cur_type_support_idl} ${_cur_java_list}
      DEPENDS opendds_idl ${DDS_ROOT}/dds/idl/IDLTemplate.txt ${abs_filename}
      COMMAND ${CMAKE_COMMAND} -E env "DDS_ROOT=${DDS_ROOT}" env "TAO_ROOT=${TAO_ROOT}" $<TARGET_FILE:opendds_idl> -I${_working_source_dir}
              ${_ddsidl_flags} ${file_dds_idl_flags} ${abs_filename}
      WORKING_DIRECTORY ${_arg_WORKING_DIRECTORY}
    )

  endforeach(input)

  if (NOT _arg_NO_TAO_IDL)
    add_tao_idl_command(${Name}
      IDL_FLAGS ${_arg_TAO_IDL_FLAGS}
      IDL_FILES ${_taoidl_inputs}
    )
  endif()

  list(APPEND ${Name}_OUTPUT_FILES ${_dds_idl_outputs} ${_type_support_idls})
  list(APPEND ${Name}_HEADER_FILES ${_dds_idl_headers} ${_type_support_idls})
  list(APPEND ${Name}_TYPESUPPORT_IDLS ${_type_support_idls})
  list(APPEND ${Name}_JAVA_OUTPUTS ${_type_support_javas})
  set(${Name}_OUTPUT_FILES ${${Name}_OUTPUT_FILES} PARENT_SCOPE)
  set(${Name}_HEADER_FILES ${${Name}_HEADER_FILES} PARENT_SCOPE)
  set(${Name}_TYPESUPPORT_IDLS ${${Name}_TYPESUPPORT_IDLS} PARENT_SCOPE)
  set(${Name}_JAVA_OUTPUTS ${${Name}_JAVA_OUTPUTS} PARENT_SCOPE)
endfunction()


function(dds_idl_sources)
  set(multiValueArgs TARGETS TAO_IDL_FLAGS DDS_IDL_FLAGS IDL_FILES ASPECTS)
  cmake_parse_arguments(_arg "NO_TAO_IDL" "" "${multiValueArgs}" ${ARGN})

  foreach(target ${_arg_TARGETS})
    if (NOT TARGET ${target})
      return()
    endif()
  endforeach()

  foreach(path ${_arg_IDL_FILES})
    if (IS_ABSOLUTE ${path})
      list(APPEND _result ${path})
    else()
      list(APPEND _result ${CMAKE_CURRENT_LIST_DIR}/${path})
    endif()
  endforeach()
  set(_arg_IDL_FILES ${_result})

  file(RELATIVE_PATH rel_path ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_LIST_DIR})

  if (_arg_NO_TAO_IDL)
    set(OPTIONAL_TAO_IDL NO_TAO_IDL)
  endif()

  foreach(aspect ${_arg_ASPECTS})
    list(APPEND _arg_TAO_IDL_FLAGS ${${aspect}_TAO_IDL_FLAGS})
    list(APPEND _arg_DDS_IDL_FLAGS ${${aspect}_DDS_IDL_FLAGS})
  endforeach()

  add_dds_idl_command(_idl
    ${OPTIONAL_TAO_IDL}
    TAO_IDL_FLAGS ${_arg_TAO_IDL_FLAGS}
    DDS_IDL_FLAGS ${_arg_DDS_IDL_FLAGS}
    IDL_FILES ${_arg_IDL_FILES}
    WORKING_DIRECTORY ${rel_path}
  )

  foreach(target ${_arg_TARGETS})
    target_sources(${target} PRIVATE ${_idl_OUTPUT_FILES} ${_arg_IDL_FILES})
    target_include_directories(${target} PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${rel_path}> $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/${rel_path}>)
    list(APPEND packages ${PACKAGE_OF_${target}})
  endforeach()

  source_group("Generated Files" FILES ${_idl_OUTPUT_FILES} )
  source_group("IDL Files" FILES ${_arg_IDL_FILES})
  set_source_files_properties(${_arg_IDL_FILES} ${_idl_HEADER_FILES} PROPERTIES HEADER_FILE_ONLY ON)

  set(DDS_IDL_TYPESUPPORT_IDLS ${_idl_TYPESUPPORT_IDLS} PARENT_SCOPE)
  set(DDS_IDL_JAVA_OUTPUTS ${_idl_JAVA_OUTPUTS} PARENT_SCOPE)

  if (packages)
    list(REMOVE_DUPLICATES packages)
  endif()

  foreach (package ${packages})
    set(package_root ${${package}_ROOT})
    set(package_install_dir ${${package}_INSTALL_DIR})
    file(RELATIVE_PATH rel_path ${package_root} ${CMAKE_CURRENT_LIST_DIR})
    install(FILES ${_arg_IDL_FILES} ${_idl_HEADER_FILES}
            DESTINATION ${package_install_dir}/${rel_path})
  endforeach()
endfunction()



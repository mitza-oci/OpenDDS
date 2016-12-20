
if (NOT DDS_ROOT AND TARGET OpenDDS_Dcps)
# TAO_ROOT is not set, it indicates this file is included from the projects other than TAO
  get_target_property(DDS_INCLUDE_DIRS OpenDDS_Dcps INTERFACE_INCLUDE_DIRECTORIES)
  # set TAO_ROOT to be first element in ${TAO_INCLUDE_DIRS}
  list(GET DDS_INCLUDE_DIRS 0 DDS_ROOT)
endif()

## IDL flags used by all DDS projects

set(FACE_TAO_IDL_FLAGS -SS -Wb,no_fixed_err)
set(FACE_DDS_IDL_FLAGS -GfaceTS -Lface)

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

  set(_taoidl_flags -I${DDS_ROOT} ${_arg_TAO_IDL_FLAGS})
  set(_ddsidl_flags ${DDS_BASE_IDL_FLAGS} ${_converted_dds_idl_flags})

  cmake_parse_arguments(_ddsidl_cmd_arg "-SI;-GfaceTS" "-o" "" ${_ddsidl_flags})

  set(_dds_idl_outputs)
  set(_type_support_idls)

  foreach(input ${_arg_IDL_FILES})

    get_filename_component(noext_name ${input} NAME_WE)
    get_filename_component(abs_filename ${input} ABSOLUTE)

    if (_ddsidl_cmd_arg_-o)
      set(output_prefix ${_working_binary_dir}/${_ddsidl_cmd_arg_-o}/${noext_name})
    else()
      set(output_prefix ${_working_binary_dir}/${noext_name})
    endif()

    if (NOT _ddsidl_cmd_arg_-SI)
      set(_cur_type_support_idl ${output_prefix}TypeSupport.idl)
      list(APPEND _type_support_idls ${_cur_type_support_idl})
    endif()

    set(_cur_idl_headers  ${output_prefix}TypeSupportImpl.h)
    set(_cur_idl_outputs ${output_prefix}TypeSupportImpl.cpp ${_cur_idl_headers})

    if (_ddsidl_cmd_arg_-GfaceTS)
      list(APPEND _cur_idl_headers ${output_prefix}C.h ${output_prefix}_TS.hpp)
      list(APPEND _cur_idl_outputs ${output_prefix}C.h ${output_prefix}_TS.hpp ${output_prefix}_TS.cpp)
    endif()

    list(APPEND _dds_idl_outputs ${_cur_idl_outputs})
    list(APPEND _dds_idl_headers ${_cur_idl_headers})

    add_custom_command(
      OUTPUT ${_cur_idl_outputs} ${_cur_type_support_idl}
      DEPENDS ${DDS_ROOT}/dds/idl/IDLTemplate.txt ${abs_filename}
      COMMAND ${CMAKE_COMMAND} -E env "DDS_ROOT=${DDS_ROOT}" env "TAO_ROOT=${TAO_ROOT}" $<TARGET_FILE:opendds_idl> -I${_working_source_dir} ${_ddsidl_flags} ${abs_filename}
      WORKING_DIRECTORY ${_arg_WORKING_DIRECTORY}
    )

  endforeach(input)

  if (_ddsidl_cmd_arg_-GfaceTS)
    ## if this is FACE IDL, do not reprocess the original idl file throught tao_idl
    set(_arg_IDL_FILES)
  endif()

  if (NOT _arg_NO_TAO_IDL)
    add_tao_idl_command(${Name}
      IDL_FLAGS ${_taoidl_flags}
      IDL_FILES  ${_arg_IDL_FILES} ${_type_support_idls}
    )
  endif()

  list(APPEND ${Name}_OUTPUT_FILES ${_dds_idl_outputs} ${_type_support_idls})
  list(APPEND ${Name}_HEADER_FILES ${_dds_idl_headers} ${_type_support_idls})
  set(${Name}_OUTPUT_FILES ${${Name}_OUTPUT_FILES} PARENT_SCOPE)
  set(${Name}_HEADER_FILES ${${Name}_HEADER_FILES} PARENT_SCOPE)
endfunction()


function(add_dds_idl_files)
  set(multiValueArgs TARGETS TAO_IDL_FLAGS DDS_IDL_FLAGS IDL_FILES)
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


function(add_face_idl_files)
  set(multiValueArgs TARGETS TAO_IDL_FLAGS DDS_IDL_FLAGS IDL_FILES)
  cmake_parse_arguments(_arg "NO_TAO_IDL" "" "${multiValueArgs}" ${ARGN})
  add_dds_idl_files(
    TARGETS ${_arg_TARGETS}
    TAO_IDL_FLAGS ${_arg_TAO_IDL_FLAGS} ${FACE_TAO_IDL_FLAGS}
    DDS_IDL_FLAGS ${_arg_DDS_IDL_FLAGS} ${FACE_DDS_IDL_FLAGS}
    IDL_FILES ${_arg_IDL_FILES}
  )
endfunction()

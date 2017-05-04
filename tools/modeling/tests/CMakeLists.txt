
function(dds_add_model_lib base)

  set(multiValueArgs PUBLIC_LINK_LIBRARIES)
  cmake_parse_arguments(_arg "" "" "${multiValueArgs}" ${ARGN})

  set(codegen_file ${base}.codegen)
  get_filename_component(base ${codegen_file} NAME_WE)
  configure_file(${base}.opendds ${base}.opendds)

  add_custom_command(
    OUTPUT model/${base}.idl model/${base}Traits.h model/${base}Traits.cpp model/${base}_T.h model/${base}_T.cpp
    DEPENDS sdk_generator_jar ${codegen_file} ${base}.opendds
    COMMAND ${CMAKE_COMMAND} -E env "DDS_ROOT=${OpenDDS_INCLUDE_DIR}" ${Java_JAVA_EXECUTABLE} -jar ${PROJECT_BINARY_DIR}/tools/modeling/plugins/org.opendds.modeling.sdk.model.editor/bin/sdk_generator.jar ${CMAKE_CURRENT_SOURCE_DIR}/${codegen_file}
  )
  add_custom_command(
    OUTPUT model/${base}_export.h
    COMMAND ${CMAKE_COMMAND} -E env "ACE_ROOT=${ACE_INCLUDE_DIR}" perl ${OpenDDS_INCLUDE_DIR}/bin/expfile.pl ${base}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/model
  )
  source_group("Generated Files" FILES
    ${CMAKE_CURRENT_BINARY_DIR}/model/${base}.idl
    ${CMAKE_CURRENT_BINARY_DIR}/model/${base}Traits.h
    ${CMAKE_CURRENT_BINARY_DIR}/model/${base}Traits.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/model/${base}_T.h
    ${CMAKE_CURRENT_BINARY_DIR}/model/${base}_T.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/model/${base}_export.h
  )
  set_source_files_properties(
    ${CMAKE_CURRENT_BINARY_DIR}/model/${base}_T.cpp
    PROPERTIES HEADER_FILE_ONLY ON
  )

  string(TOUPPER ${base} BASE)

  ace_add_lib(${base}
    DEFINE_SYMBOL ${BASE}_BUILD_DLL
    PUBLIC_INCLUDE_DIRECTORIES $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}> $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/model>
    PUBLIC_LINK_LIBRARIES OpenDDS_Transports_For_Test OpenDDS_Model ${_arg_PUBLIC_LINK_LIBRARIES}
  )

  if (TARGET ${base})
    target_sources(${base} PRIVATE
      ${CMAKE_CURRENT_BINARY_DIR}/model/${base}Traits.h
      ${CMAKE_CURRENT_BINARY_DIR}/model/${base}Traits.cpp
      ${CMAKE_CURRENT_BINARY_DIR}/model/${base}_T.h
      ${CMAKE_CURRENT_BINARY_DIR}/model/${base}_T.cpp
      ${CMAKE_CURRENT_BINARY_DIR}/model/${base}_export.h
    )
  endif(TARGET ${base})
  foreach(lib ${_arg_PUBLIC_LINK_LIBRARIES})
    if (CMAKE_CONFIGURATION_TYPES)
      list(APPEND INCLUDE_OPTIONS -I$<TARGET_FILE_DIR:${lib}>/../model)
    else()
      list(APPEND INCLUDE_OPTIONS -I$<TARGET_FILE_DIR:${lib}>/model)
    endif()
  endforeach()

  dds_idl_sources(
    TARGETS ${base}
    DDS_IDL_FLAGS -Wb,export_macro=${base}_Export -o model -I${CMAKE_CURRENT_BINARY_DIR}/model ${INCLUDE_OPTIONS}
    TAO_IDL_FLAGS -I${OpenDDS_INCLUDE_DIR} -Wb,export_macro=${base}_Export -Wb,export_include=${base}_export.h -o model -I${CMAKE_CURRENT_BINARY_DIR}/model ${INCLUDE_OPTIONS}
    IDL_FILES ${CMAKE_CURRENT_BINARY_DIR}/model/${base}.idl
  )

endfunction()

include(../../../cmake/dds_add_test.cmake)

add_subdirectory(Arrays)
add_subdirectory(MessengerMixed)
add_subdirectory(CfTopic)
add_subdirectory(Chained_Data)
add_subdirectory(Chained_Topic)
add_subdirectory(Chained)
add_subdirectory(Codegen)
add_subdirectory(Comments)
add_subdirectory(CompositeKey)
add_subdirectory(CopyTopicQos)
add_subdirectory(DataLibRef)
add_subdirectory(Deep/Down/Reference)
add_subdirectory(DomainZero)
add_subdirectory(EmptyLibs)
add_subdirectory(Exchange)
add_subdirectory(ExternalPolicies)
add_subdirectory(InvalidNames)
add_subdirectory(Looped)
add_subdirectory(Messenger)
add_subdirectory(MessengerDpQos)
add_subdirectory(MessengerGlobalNs)
add_subdirectory(MessengerMC)
add_subdirectory(MessengerMulti)
add_subdirectory(MessengerNoPub)
add_subdirectory(MessengerNoSub)
add_subdirectory(MessengerPubQos)
add_subdirectory(MessengerSimpleTypes)
add_subdirectory(MessengerSplit)
add_subdirectory(MessengerWriterQos)
add_subdirectory(ModuleNameConflict)
add_subdirectory(MultiDCPS)
add_subdirectory(MultiInstance)
add_subdirectory(MultiTopic)
add_subdirectory(PolicyLib)
add_subdirectory(ReaderQos)
add_subdirectory(ReferExternalProj)
add_subdirectory(RemoteInstHandles)
add_subdirectory(ReusedExtTypes)
add_subdirectory(ReusedTypes)
add_subdirectory(Sequences)
add_subdirectory(StockQuoter)
add_subdirectory(SubscriberQos)
add_subdirectory(TopicQos)
add_subdirectory(UDP)


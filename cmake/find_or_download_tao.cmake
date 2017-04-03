function(download_ace_tao)
  include(cmake/DownloadProject.cmake)
  download_project(PROJ                ACE_TAO
                   GIT_REPOSITORY      https://github.com/huangminghuang/ACE_TAO.git
                   GIT_SHALLOW 1
                   GIT_TAG             cmake
                   UPDATE_DISCONNECTED 1
  )
  set(ACE_TAO_SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/ACE_TAO-src CACHE PATH "")
endfunction()

function(ensure_valid_ace_tao_source_tree)
  if (NOT (EXISTS ${ACE_TAO_SOURCE_DIR}/CMakeLists.txt AND
           EXISTS ${ACE_TAO_SOURCE_DIR}/ACE/CMakeLists.txt AND
           EXISTS ${ACE_TAO_SOURCE_DIR}/TAO/CMakeLists.txt))
    message(FATAL_ERROR "ACE_TAO_SOURCE_DIR(${ACE_TAO_SOURCE_DIR}) does not refer to valid ACE_TAO directory")
  endif()
endfunction()

if (OPENDDS_SAFETY_PROFILE OR CMAKE_CROSSCOMPILING)
  find_package(OpenDDS_HostTools CONFIG)
  if (NOT OpenDDS_HostTools_FOUND)
    if(NOT ACE_TAO_SOURCE_DIR)
      download_ace_tao()
    else()
      ensure_valid_ace_tao_source_tree()
    endif(NOT ACE_TAO_SOURCE_DIR)
    include(ExternalProject)
    externalproject_add(host_tools
                        SOURCE_DIR "${PROJECT_SOURCE_DIR}"
                        BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/hosttools_build"
                        CMAKE_ARGS "-DACE_TAO_SOURCE_DIR=${ACE_TAO_SOURCE_DIR}" "-DBUILD_SHARED_LIBS=OFF" "-DCMAKE_BUILD_TYPE=RELEASE" "-DHOSTTOOLS_ONLY=ON"
                        BUILD_COMMAND ${CMAKE_COMMAND} --build .
                        INSTALL_COMMAND "")
    find_package(OpenDDS_HostTools CONFIG PATHS ${CMAKE_CURRENT_BINARY_DIR}/hosttools_build NO_DEFAULT_PATH)
  endif(NOT OpenDDS_HostTools_FOUND)
endif(OPENDDS_SAFETY_PROFILE OR CMAKE_CROSSCOMPILING)

if (NOT TARGET TAO)
  if (ACE_TAO_SOURCE_DIR)
    ensure_valid_ace_tao_source_tree()
    set(ACE_TAO_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/ACE_TAO-build)
    include(ACE_TAO_for_DDS.cmake)
    add_subdirectory(${ACE_TAO_SOURCE_DIR} ${ACE_TAO_BINARY_DIR})
  else(ACE_TAO_SOURCE_DIR)
    find_package(TAO CONFIG)
    if (NOT TAO_FOUND)
      download_ace_tao()
      include(ACE_TAO_for_DDS.cmake)
      add_subdirectory(${ACE_TAO_SOURCE_DIR} ${ACE_TAO_BINARY_DIR})
    else(NOT TAO_FOUND)
      message("-- Found TAO: ${TAO_DIR} (found version \"${TAO_VERSION}\")")
    endif(NOT TAO_FOUND)
  endif(ACE_TAO_SOURCE_DIR)
endif(NOT TARGET TAO)


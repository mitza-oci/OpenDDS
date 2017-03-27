
if (NOT TARGET TAO)
  if (ACE_TAO_SOURCE_DIR)
    include(ACE_TAO_for_DDS.cmake)
    set(ACE_TAO_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/ACE_TAO-build)
    add_subdirectory(${ACE_TAO_SOURCE_DIR} ${ACE_TAO_BINARY_DIR})
  else(ACE_TAO_SOURCE_DIR)
    find_package(TAO CONFIG)
    if (NOT TAO_FOUND)
      include(cmake/DownloadProject.cmake)
      download_project(PROJ                ACE_TAO
                       GIT_REPOSITORY      https://github.com/huangminghuang/ACE_TAO.git
                       GIT_SHALLOW 1
                       GIT_TAG             cmake
                       UPDATE_DISCONNECTED 1
      )
      set(ACE_TAO_SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/ACE_TAO-src CACHE PATH "")
      include(ACE_TAO_for_DDS.cmake)
      add_subdirectory(${ACE_TAO_SOURCE_DIR} ${ACE_TAO_BINARY_DIR})
    else(NOT TAO_FOUND)
      message("-- Found TAO: ${TAO_DIR} (found version \"${TAO_VERSION}\")")
    endif(NOT TAO_FOUND)
  endif(ACE_TAO_SOURCE_DIR)
endif(NOT TARGET TAO)


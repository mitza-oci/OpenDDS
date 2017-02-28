
if (NOT TARGET TAO)
  if (TAO_DIR STREQUAL "${CMAKE_CURRENT_BINARY_DIR}/ACE_TAO-build/TAO/cmake")
    set(ACE_TAO_SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/ACE_TAO-src)
    set(ACE_TAO_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR}/ACE_TAO-build)
    include(ACE_TAO_for_DDS.cmake)
    add_subdirectory(${ACE_TAO_SOURCE_DIR} ${ACE_TAO_BINARY_DIR})
  else()
    find_package(TAO CONFIG)

    if (NOT TAO_FOUND)
      include(cmake/DownloadProject.cmake)

      download_project(PROJ                ACE_TAO
                       GIT_REPOSITORY      https://github.com/huangminghuang/ACE_TAO.git
                       GIT_SHALLOW 1
                       GIT_TAG             cmake
                       UPDATE_DISCONNECTED 1
      )
      include(ACE_TAO_for_DDS.cmake)
      add_subdirectory(${ACE_TAO_SOURCE_DIR} ${ACE_TAO_BINARY_DIR})
    endif(NOT TAO_FOUND)
  endif()
endif()


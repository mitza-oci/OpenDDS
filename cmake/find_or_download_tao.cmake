
if (NOT TARGET TAO)
  if (TAO_DIR STREQUAL "${CMAKE_CURRENT_BINARY_DIR}/ACE_TAO-build/TAO/cmake")
    set(DDS_WHITELIST_TARGETS ${WHITELIST_TARGETS} CACHE STRING "" FORCE)
    include(../ACE_TAO_for_DDS.cmake)
    add_subdirectory(${CMAKE_CURRENT_BINARY_DIR}/ACE_TAO-src ${CMAKE_CURRENT_BINARY_DIR}/ACE_TAO-build)
    set(WHITELIST_TARGETS "${DDS_WHITELIST_TARGETS}" CACHE STRING "" FORCE)
  else()
    find_package(TAO CONFIG)

    if (NOT TAO_FOUND)
      include(cmake/DownloadProject.cmake)

      set(WHITELIST_TARGETS "" CACHE STRING "")

      download_project(PROJ                ACE_TAO
                       GIT_REPOSITORY      https://github.com/huangminghuang/ACE_TAO.git
                       GIT_SHALLOW 1
                       GIT_TAG             cmake
                       UPDATE_DISCONNECTED 1
      )

      set(DDS_WHITELIST_TARGETS ${WHITELIST_TARGETS} CACHE STRING "" FORCE)
      include(../ACE_TAO_for_DDS.cmake)
      add_subdirectory(${ACE_TAO_SOURCE_DIR} ${ACE_TAO_BINARY_DIR})
      set(WHITELIST_TARGETS "${DDS_WHITELIST_TARGETS}" CACHE STRING "" FORCE)
    endif(NOT TAO_FOUND)
  endif()
endif()


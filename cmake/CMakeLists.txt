
if (UNIX)

  configure_file(PostInstall.cmake.in PostInstall.cmake @ONLY)
  install(SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/PostInstall.cmake)

endif()
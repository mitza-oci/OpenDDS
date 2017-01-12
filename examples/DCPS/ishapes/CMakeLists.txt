
project(ishapes CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


find_package(Qt4)
requires(QT4_FOUND)

if (("${MSVC_VERSION}" GREATER 1599) OR (NOT "${CMAKE_CXX_STANDARD}" EQUAL 98))
  ## MSVC_VERSION==1600  is the earliest version of MSVC to support std::shared_ptr
  ## for other compiler, To enable C++11 requires CMAKE_CXX_STANDARD set and not equal to 98.
else()
  find_package(Boost)
  if (NOT Boost_FOUND)
    message("Skipping ishapes because neither C++11 nor boost is found")
    return()
  endif(NOT Boost_FOUND)
  message("Boost_INCLUDE_DIRS=${Boost_INCLUDE_DIRS}")
endif()

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)


add_ace_exe(ishapes
  OUTPUT_NAME ishapes
  FOLDER examples/DCPS/ishapes
  ASPECTS DCPS_DEFAULT_DISCOVERY
  INCLUDE_DIRECTORIES ${Boost_INCLUDE_DIRS}
  LINK_LIBRARIES OpenDDS_Multicast
                 Qt4::QtGui
                 OpenDDS_Tcp
                 OpenDDS_Udp
                 OpenDDS_Rtps_Udp
)
target_cxx_sources(ishapes
  SOURCE_FILES BouncingShapeDynamics.cpp
               Circle.cpp
               DDSShapeDynamics.cpp
               FilterDialog.cpp
               ReaderQosDialog.cpp
               Shape.cpp
               ShapeDynamics.cpp
               ShapesDialog.cpp
               ShapesWidget.cpp
               Square.cpp
               Triangle.cpp
               WriterQosDialog.cpp
               main.cpp
)

dds_idl_sources(
  TARGETS ishapes
  IDL_FILES ShapeType.idl
)

if (TARGET ishapes)
  set(ui_files filterForm.ui
                 iShapesForm.ui
                 qosForm.ui
                 readerQosForm.ui
                 writerQosForm.ui)
  target_sources(ishapes PRIVATE ${ui_files})
  source_group("UI Files" FILES ${ui_files})

  target_sources(ishapes PRIVATE ishape.qrc)
  source_group("Resource Files" FILES ishape.qrc)

  # generate proper GUI program on specified platform
  if(WIN32) # Check if we are on Windows
  	if(MSVC) # Check if we are using the Visual Studio compiler
  		set_target_properties(ishapes PROPERTIES
  			WIN32_EXECUTABLE YES
  			LINK_FLAGS "/ENTRY:mainCRTStartup"
  		)
  	elseif(CMAKE_COMPILER_IS_GNUCXX)
  			# SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mwindows") # Not tested
  	else()
  		message(SEND_ERROR "You are using an unsupported Windows compiler! (Not MSVC or GCC)")
  	endif(MSVC)
  elseif(APPLE)
  	set_target_properties(ishapes PROPERTIES
  			MACOSX_BUNDLE YES
  	)
  elseif(UNIX)
  	# Nothing special required
  else()
  	message(SEND_ERROR "You are on an unsupported platform! (Not Win32, Mac OS X or Unix)")
  endif(WIN32)

endif(TARGET ishapes)

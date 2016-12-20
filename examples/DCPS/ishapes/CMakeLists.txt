
project(ishapes CXX)
cmake_minimum_required(VERSION 3.1)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()
include(${DDS_ROOT}/cmake/AddDdsTest.cmake)

find_package(Qt4)

if (NOT QT4_FOUND)
  message("Skipping ishapes because it requires Qt4")
  return()
endif()

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)


add_ace_exe(ishapes
  OUTPUT_NAME ishapes
  SOURCE_FILES BouncingShapeDynamics.cpp
               Circle.cpp
               DDSShapeDynamics.cpp
               FilterDialog.cpp
               main.cpp
               ReaderQosDialog.cpp
               Shape.cpp
               ShapeDynamics.cpp
               ShapesDialog.cpp
               ShapesWidget.cpp
               Square.cpp
               Triangle.cpp
               WriterQosDialog.cpp
  HEADER_FILES BouncingShapeDynamics.hpp
                Circle.hpp
                DDSShapeDynamics.hpp
                FilterDialog.hpp
                ReaderQosDialog.hpp
                Shape.hpp
                ShapeDynamics.hpp
                ShapesDialog.hpp
                ShapesWidget.hpp
                Square.hpp
                Triangle.hpp
                WriterQosDialog.hpp
                config.hpp
  FOLDER examples/DCPS/ishapes
  LINK_LIBRARIES ${DCPS_DEFAULT_DISCOVERY_LIBS}
                 OpenDDS_Multicast
                 OpenDDS_Dcps
                 OpenDDS_Tcp
                 OpenDDS_Udp
                 OpenDDS_Rtps_Udp
                 Qt4::QtGui
)
add_dds_idl_files(
  TARGETS ishapes
  IDL_FILES ShapeType.idl
)

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


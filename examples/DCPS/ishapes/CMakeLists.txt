
project(ishapes CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


find_package(Qt4)
ace_requires(QT4_FOUND)

if (("${MSVC_VERSION}" GREATER 1599) OR (NOT "${CMAKE_CXX_STANDARD}" EQUAL 98))
  ## MSVC_VERSION==1600  is the earliest version of MSVC to support std::shared_ptr
  ## for other compiler, To enable C++11 ace_requires CMAKE_CXX_STANDARD set and not equal to 98.
else()
  find_package(Boost)
  if (NOT Boost_FOUND)
    message("Skipping ishapes because neither C++11 nor boost is found")
    return()
  endif(NOT Boost_FOUND)
endif()

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

ace_add_exe(ishapes
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
ace_target_cxx_sources(ishapes
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

ace_target_qt_sources(ishapes
  UI_FILES filterForm.ui
           iShapesForm.ui
           qosForm.ui
           readerQosForm.ui
           writerQosForm.ui
  RESOURCE_FILES ishape.qrc
)

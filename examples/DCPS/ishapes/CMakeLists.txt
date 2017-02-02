
project(ishapes CXX)
cmake_minimum_required(VERSION 3.3)

if (NOT DDS_ROOT)
  find_package(OpenDDS REQUIRED CONFIG)
endif()


find_package(Qt4)
ace_requires(QT4_FOUND)


include(CheckCXXSymbolExists)
set(CMAKE_REQUIRED_LIBRARIES ACE)
check_cxx_symbol_exists(ACE_HAS_CPP11 ace/ACE.h ACE_HAS_CPP11)


if (NOT ACE_HAS_CPP11)
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
  INCLUDE_DIRECTORIES ${Boost_INCLUDE_DIRS}
  LINK_LIBRARIES OpenDDS_Multicast
                 Qt4::QtGui
                 OpenDDS_Tcp
                 OpenDDS_Udp
                 OpenDDS_Default_Discovery
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

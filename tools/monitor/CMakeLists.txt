
find_package(Qt4)
ace_requires(QT4_FOUND BUILT_IN_TOPICS)


set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

ace_add_exe(Monitor_App
  OUTPUT_NAME monitor
  FOLDER tools
  ASPECTS DCPS_DEFAULT_DISCOVERY
  LINK_LIBRARIES OpenDDS_Tcp
                 OpenDDS_monitor
                 Qt4::QtGui
)
ace_target_cxx_sources(Monitor_App
  SOURCE_FILES Edge.cpp
               GraphGenerator.cpp
               GvOptions.cpp
               MonitorData.cpp
               MonitorDataModel.cpp
               MonitorDataStorage.cpp
               MonitorTask.cpp
               Monitor_main.cpp
               Node.cpp
               NodeGenerator.cpp
               NodeOptions.cpp
               Options.cpp
               QosFormatter.cpp
               RepoSelect.cpp
               Viewer.cpp
  HEADER_FILES Edge.h
               GraphGenerator.h
               GvOptions.h
               MonitorData.h
               MonitorDataModel.h
               MonitorDataStorage.h
               MonitorTask.h
               Node.h
               NodeGenerator.h
               NodeOptions.h
               Options.h
               QosFormatter.h
               RepoSelect.h
               TreeNode.h
               Viewer.h
  INLINE_FILES MonitorDataStorage.inl
)
ace_target_qt_sources(Monitor_App
  UI_FILES GvOptions.ui
           Monitor.ui
           NodeOptions.ui
           RepoDialog.ui
  RESOURCE_FILES Monitor.qrc
)


if (MSVC)
  target_compile_options(Monitor_App /bigobj)
endif()


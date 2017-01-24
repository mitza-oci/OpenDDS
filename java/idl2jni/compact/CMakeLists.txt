ace_requires("NOT FULL_JRE")


add_jar(i2jrt_compact
  OUTPUT_DIR ${PROJECT_BINARY_DIR}/lib
  SOURCES org/omg/CORBA
)

install_jar(i2jrt_compact ${OpenDDS_INSTALL_DIR}/lib)

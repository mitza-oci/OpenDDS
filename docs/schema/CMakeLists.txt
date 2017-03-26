configure_file(dds_qos.xsd dds_qos.xsd)
install(FILES dds_qos.xsd
        DESTINATION ${OpenDDS_INSTALL_DIR}/docs/schema)
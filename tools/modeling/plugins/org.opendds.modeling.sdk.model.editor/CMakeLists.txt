
add_jar(sdk_generator_jar
  OUTPUT_NAME sdk_generator
  SOURCES src/org/opendds/modeling/sdk/model/GeneratorSpecification/Generator/SdkGenerator.java
          src/org/opendds/modeling/sdk/model/GeneratorSpecification/Generator/IErrorHandler.java
          src/org/opendds/modeling/sdk/model/GeneratorSpecification/Generator/IFileProvider.java
          src/org/opendds/modeling/sdk/model/GeneratorSpecification/Generator/IGeneratorModel.java
          src/org/opendds/modeling/sdk/model/GeneratorSpecification/Generator/ParsedGeneratorFile.java
          src/org/opendds/modeling/sdk/model/GeneratorSpecification/Generator/ParsedModelFile.java
          src/org/opendds/modeling/sdk/model/GeneratorSpecification/Generator/ParsedXmlFile.java
          src/org/opendds/modeling/sdk/model/GeneratorSpecification/Generator/SdkTransformer.java
  OUTPUT_DIR ${CMAKE_CURRENT_BINARY_DIR}/bin
  ENTRY_POINT org.opendds.modeling.sdk.model.GeneratorSpecification.Generator.SdkGenerator
)
Instructions

$ wget https://oss.sonatype.org/content/repositories/snapshots/org/openapitools/openapi-generator-cli/5.0.0-SNAPSHOT/openapi-generator-cli-5.0.0-20200910.041835-628.jar

$ cp openapi-generator-cli-5.0.0-20200910.041835-628.jar openapi-generator-cli.jar

$ mkdir output

$ java -jar openapi-generator-cli.jar generate -g asciidoc -i oas.yaml -o output --skip-validate-spec


#!/bin/bash

if [[ -z $1 ]] ; then 
  echo "Using ../azure-sdk-for-java/ for java sdk"
  SDK_PATH="../azure-sdk-for-java"
else 
  SDK_PATH=$1
fi

SPOTBUGS_EXCLUDE='<?xml version="1.0" encoding="UTF-8"?>
<FindBugsFilter>
  <Match>
  <Bug pattern="UPM_UNCALLED_PRIVATE_METHOD"/>
    </Match>
  <Match>
    <Bug pattern="NP_LOAD_OF_KNOWN_NULL_VALUE"/>
  </Match>
  <Match>
    <Bug pattern="SIC_INNER_SHOULD_BE_STATIC_ANON"/>
  </Match>
  <Match>
    <Bug pattern="NM_CONFUSING"/>
  </Match>
</FindBugsFilter>
'

SPOTBUGS_PLUGIN_CONFIG='<plugin><groupId>com\.github\.spotbugs<\/groupId><artifactId>spotbugs-maven-plugin<\/artifactId><version>4\.2\.0<\/version><configuration><excludeFilterFile>.\/spotbugs\/sportbugs-exclude\.xml<\/excludeFilterFile><\/configuration><\/plugin>'

# VERSION=1.0.0-beta.1
# VERSION_MESSAGE="Initial preview"

find specification/maps/data-plane/*/* -name "readme.md" -print | while read README_PATH ; do 
  TRACK2_COMMAND="autorest --version=3.1.3 --use=@autorest/java@4.0.30 --java.azure-libraries-for-java-folder=$SDK_PATH/sdk/maps --java --pipeline.modelerfour.additional-checks=false --pipeline.modelerfour.lenient-model-deduplication=true --azure-arm --verbose --sdk-integration --fluent=lite --java.fluent=lite --java.license-header=MICROSOFT_MIT_SMALL $README_PATH"

  README_FPATH=$(dirname $README_PATH)
  SERVICE_NAME=$(cat $README_FPATH/readme.java.md | grep '^\s*output-folder:' | sed "s/output-folder://" | xargs basename)
  TARGET_PATH="$SDK_PATH/sdk/maps/$SERVICE_NAME"
  SERVICE_COMPONENENTS=(${SERVICE_NAME//-/ })
  echo $TRACK2_COMMAND
  eval $TRACK2_COMMAND

  mkdir -p $TARGET_PATH/spotbugs

  # replace meta
  sed -i "s/<groupId>com.azure.resourcemanager<\/groupId>/<groupId>com.azure<\/groupId>/" $TARGET_PATH/pom.xml
  sed -i "s/<artifactId>azure-resourcemanager-${SERVICE_COMPONENENTS[2]}-generated<\/artifactId>/<artifactId>${SERVICE_NAME,,}<\/artifactId>/" $TARGET_PATH/pom.xml
  sed -i '0,/<name>.*<\/name>/ '"s/<name>.*<\/name>/<name>Microsoft Azure client library for $SERVICE_NAME service<\/name>/" $TARGET_PATH/pom.xml
  sed -i '0,/<name>.*<\/name>/ '"s/<description>.*<\/description>/<description>This package contains the Microsoft $SERVICE_NAME SDK\.<\/description>>/" $TARGET_PATH/pom.xml

  # add spotbugs exclusions
  echo "$SPOTBUGS_EXCLUDE" > $TARGET_PATH/spotbugs/sportbugs-exclude.xml
  REPLACE_EXPR="s/<plugins>/<plugins>"$SPOTBUGS_PLUGIN_CONFIG"/"
  sed -i $REPLACE_EXPR $TARGET_PATH/pom.xml

  mvn clean install -f $TARGET_PATH/pom.xml
done

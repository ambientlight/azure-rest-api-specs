#!/bin/bash

if [[ -z $1 ]] ; then 
  echo "Using ../azure-sdk-for-python/ for python sdk"
  SDK_PATH="../azure-sdk-for-python/"
else 
  SDK_PATH=$1
fi

TARGET_GENINPUT_PATH="genInput.json"
TARGET_GENOUTPUT_PATH="genOutput.json"
TARGET_PACKAGEOUTPUT_PATH="packageOutput.json"

CHANGED=$(find specification/maps -print | xargs python -c 'import json, sys; print(json.dumps([v for v in sys.argv[1:]]))')
RELATED=$(find specification/maps/data-plane/*/ -name "readme.md" -print | xargs python -c 'import json, sys; print(json.dumps([v for v in sys.argv[1:]]))')
echo '{"relatedReadmeMdFiles":'"$RELATED"', "changedFiles":'"$CHANGED"', "specFolder":"../azure-rest-api-specs/"}' > "$SDK_PATH/$TARGET_GENINPUT_PATH"

cd $SDK_PATH
ln -s tools/azure-sdk-tools/packaging_tools/ packaging_tools
python -m packaging_tools.auto_codegen $TARGET_GENINPUT_PATH $TARGET_GENOUTPUT_PATH
python -m packaging_tools.auto_package $TARGET_GENOUTPUT_PATH $TARGET_PACKAGEOUTPUT_PATH

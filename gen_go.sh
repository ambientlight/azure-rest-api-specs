#!/bin/bash

if [[ -z $1 ]] ; then 
  echo "Using ../azure-sdk-for-go/ for go sdk"
  SDK_PATH="../azure-sdk-for-go"
else 
  SDK_PATH=$1
fi

# VERSION=1.0.0-beta.1
# VERSION_MESSAGE="Initial preview"

find specification/maps/data-plane/*/* -name "readme.md" -print | while read README_PATH ; do 
  #PARAMS=$(jq -s '.[0].autorestArguments | del(.[3]) | join(" ")' --raw-output $SDK_PATH/generate_options.json)
  COMMAND="autorest --go --track2 --use=@autorest/go@4.0.0-preview.22 $README_PATH --go-sdk-folder=$SDK_PATH --multiapi"

  echo $COMMAND
  eval $COMMAND  
done

# hotfix
# find $SDK_PATH/services/preview/maps/ -name '*.go' -exec sed -i -e 's/DefaultGeography\s=\sus/DefaultGeography = Us/g' {} \;
# find $SDK_PATH/services/preview/maps/ -name '*.go' -exec sed -i -e 's/geographicResourceLocation/GeographicResourceLocation/g' {} \;  

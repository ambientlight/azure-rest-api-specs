#!/bin/bash

find specification/maps/data-plane/*/ -name "readme.md" -print | while read README_PATH ; do 
  PARAMS=$(cat ../azure-sdk-for-net/swagger_to_sdk_config.json \
    | jq 'del(.meta.autorest_options."sdkrel:csharp-sdks-folder")' \
    | jq '.meta.autorest_options | to_entries | map("--" + .key + (if .value != "" then "=" else "" end) + .value) | join(" ") ' --raw-output)
  COMMAND="autorest $PARAMS $README_PATH --csharp-sdks-folder=../azure-sdk-for-net/sdk/"
  TRACK2_COMMAND="autorest --csharp --reflect-api-versions --license-header=MICROSOFT_MIT_NO_VERSION $README_PATH --csharp-sdks-folder=/home/ambientlight/repos/azure-sdk-for-net/sdk/ --output-folder=/home/ambientlight/repos/azure-sdk-for-net/sdk/"

  echo $TRACK2_COMMAND
  eval $TRACK2_COMMAND
done

cd ../azure-sdk-for-net/
dotnet msbuild eng/mgmt.proj /t:CreateNugetPackage /p:Scope=maps /v:n /p:SkipTests=true
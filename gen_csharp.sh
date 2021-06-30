#!/bin/bash

VERSION=1.0.0-beta.1
VERSION_MESSAGE="Initial preview"

# TARGET_GENINPUT_PATH="genInput.json"
# TARGET_GENOUTPUT_PATH="genOutput.json"
# TARGET_PACKAGEOUTPUT_PATH="packageOutput.json"

# CHANGED=$(find specification/maps/data-plane/Alias/* -print | xargs python -c 'import json, sys; print(json.dumps([v for v in sys.argv[1:]]))')
# RELATED=$(find specification/maps/data-plane/Alias/*/ -name "readme.md" -print | xargs python -c 'import json, sys; print(json.dumps([v for v in sys.argv[1:]]))')
# echo '{"relatedReadmeMdFiles":'"$RELATED"', "changedFiles":'"$CHANGED"', "specFolder":"../azure-rest-api-specs/"}' > "$SDK_PATH/$TARGET_GENINPUT_PATH"

# cd $SDK_PATH
# pwsh ./eng/scripts/Automation-Sdk-Generate.ps1 $TARGET_GENINPUT_PATH $TARGET_GENOUTPUT_PATH

find specification/maps/data-plane/*/* -name "readme.md" -print | while read README_PATH ; do 
  PARAMS=$(cat ../azure-sdk-for-net/swagger_to_sdk_config.json \
    | jq 'del(.meta.autorest_options."sdkrel:csharp-sdks-folder")' \
    | jq '.meta.autorest_options | to_entries | map("--" + .key + (if .value != "" then "=" else "" end) + .value) | join(" ") ' --raw-output)
  #COMMAND="autorest $PARAMS $README_PATH --csharp-sdks-folder=../azure-sdk-for-net/sdk/"

  README_FPATH=$(dirname $README_PATH)
  SRCPATH=$(cat $README_FPATH/readme.csharp.md | grep '^\s*output-folder:' | sed "s/output-folder://" | xargs dirname)
  SERVICE_NAME=$(dirname $SRCPATH | xargs basename)
  TRACK2_COMMAND='npx autorest@3.2.1 --skip-csproj --skip-upgrade-check --version=3.4.5 '"$README_PATH"' --use='"$(realpath ~)"'/.nuget/packages/microsoft.azure.autorest.csharp/3.0.0-beta.20210615.2/buildMultiTargeting/../tools/netcoreapp3.1/any/ --output-folder='"$(realpath ../azure-sdk-for-net)"'/sdk/maps/'"$SERVICE_NAME"'/src/Generated --namespace='"$SERVICE_NAME"' --clear-output-folder=true --shared-source-folders="'"$(realpath ../azure-sdk-for-net/)"'/eng//../sdk/core/Azure.Core/src/Shared/;'"$(realpath ~)"'/.nuget/packages/microsoft.azure.autorest.csharp/3.0.0-beta.20210615.2/buildMultiTargeting/../content/Generator.Shared/" --public-clients'
  
  echo $TRACK2_COMMAND
  eval $TRACK2_COMMAND

  cp ../azure-sdk-for-net/sdk/template/Azure.Template/src/Azure.Template.csproj ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/$SERVICE_NAME.csproj
  cp ../azure-sdk-for-net/sdk/template/Azure.Template/Directory.Build.props ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/

  # update meta
  sed -i "s/<Version>.*<\/Version>/<Version>$VERSION<\/Version>/" ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/$SERVICE_NAME.csproj
  sed -i "s/<AssemblyTitle>.*<\/AssemblyTitle>/<AssemblyTitle>Azure Maps $SERVICE_NAME<\/AssemblyTitle>/" ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/$SERVICE_NAME.csproj
  sed -i "s/<PackageTags>.*<\/PackageTags>/<PackageTags>Azure;Azure Maps;Maps $SERVICE_NAME<\/PackageTags>/" ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/$SERVICE_NAME.csproj
  sed -i "s/<Description>.*<\/Description>/<Description>Azure Maps $SERVICE_NAME<\/Description>/" ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/$SERVICE_NAME.csproj
  sed -i "s/<\/PropertyGroup>/<NoWarn>\$(NoWarn);AZC0001;AZC0012<\/NoWarn><\/PropertyGroup>/" ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/$SERVICE_NAME.csproj
  # inject additional shared source
  sed -z "s/<ItemGroup>\n\s*<Compile/<ItemGroup>\n    <Compile Include=\"\$(AzureCoreSharedSources)Argument.cs\" Link=\"Shared\%(RecursiveDir)\%(Filename)%(Extension)\" \/>\n    <Compile Include=\"\$(AzureCoreSharedSources)AzureKeyCredentialPolicy.cs\" Link=\"Shared\%(RecursiveDir)\%(Filename)%(Extension)\" \/>\n    <Compile/" ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/$SERVICE_NAME.csproj > ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/$SERVICE_NAME.tmp.csproj
  mv ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/$SERVICE_NAME.tmp.csproj ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/$SERVICE_NAME.csproj

  # the build somehow add condiitional dependencies if autorest.md is present, otherwise I cannot explain build failing without empty autorest.md...
  touch ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/autorest.md

  # hotfix
  find ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/ -name '*.cs' -exec sed -i -e 's/AppendRaw(geography.Value, true)/AppendRaw(geography.ToString(), true)/g' {} \;
  
  # add changelog and generate Nuget package
  echo -e "# Release History\n\n## $VERSION ($(date +%Y-%m-%d))\n- $VERSION_MESSAGE" > ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/CHANGELOG.md
  dotnet pack ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/$SERVICE_NAME.csproj /p:RunApiCompat=$false
  #dotnet build ../azure-sdk-for-net/sdk/maps/$SERVICE_NAME/src/$SERVICE_NAME.csproj /t:RunApiCompat /p:TargetFramework=netstandard2.0 /flp:v=m
done

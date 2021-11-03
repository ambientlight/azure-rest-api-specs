## Swift

These settings apply only when `--swift` is specified on the command line.

```yaml $(swift)
namespace: AzureMapsElevation
title: AzureMapsElevation
license-header: MICROSOFT_MIT_NO_VERSION
package-name: AzureMapsElevation
output-folder: $(swift-sdk-folder)/sdk/maps/AzureMapsElevation
package-version: 1.0.0
clear-output-folder: false
add-credential: true
generate-as-internal: >
    ElevationClient=ElevationClientInternal
directive:
  - rename-model:
      from: Elevation
      to: ElevationEntity
  - rename-operation:
      from: GetDataForPoints
      to: Elevation_GetDataForPoints
  - rename-operation:
      from: PostDataForPoints
      to: Elevation_PostDataForPoints
  - rename-operation:
      from: GetDataForPolyline
      to: Elevation_GetDataForPolyline
  - rename-operation:
      from: PostDataForPolyline
      to: Elevation_PostDataForPolyline
  - rename-operation:
      from: RequestElevationDirectionsBatchSync
      to: Elevation_RequestElevationDirectionsBatchSync
  - rename-operation:
      from: GetDataForBoundingBox
      to: Elevation_GetDataForBoundingBox
```
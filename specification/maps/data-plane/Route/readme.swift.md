## Swift

These settings apply only when `--swift` is specified on the command line.

```yaml $(swift)
namespace: AzureMapsRoute
title: AzureMapsRoute
license-header: MICROSOFT_MIT_NO_VERSION
package-name: AzureMapsRoute
output-folder: $(swift-sdk-folder)/sdk/maps/AzureMapsRoute
package-version: 1.0.0
clear-output-folder: false
add-credential: true
generate-as-internal: >
    RouteClient=RouteClientInternal
directive:
  - rename-model:
      from: Route
      to: RouteEntity
  - rename-operation:
      from: GetRouteDirections
      to: Route_GetRouteDirections
  - rename-operation:
      from: RequestRouteDirectionsBatch
      to: Route_RequestRouteDirectionsBatch
  - rename-operation:
      from: RequestRouteDirectionsBatchSync
      to: Route_RequestRouteDirectionsBatchSync
  - rename-operation:
      from: RouteDirectionsBatchResult
      to: Route_RouteDirectionsBatchResult
  - rename-operation:
      from: RequestRouteMatrix
      to: Route_RequestRouteMatrix
  - rename-operation:
      from: RequestRouteMatrixSync
      to: Route_RequestRouteMatrixSync
  - rename-operation:
      from: GetRouteRange
      to: Route_GetRouteRange
  - rename-operation:
      from: GetRouteDirectionsWithAdditionalParameters
      to: Route_GetRouteDirectionsWithAdditionalParameters
  - rename-operation:
      from: GetRouteMatrix
      to: Route_GetRouteMatrix
  - rename-operation:
      from: GetRouteDirectionsBatch
      to: Route_GetRouteDirectionsBatch
```
## Swift

These settings apply only when `--swift` is specified on the command line.

```yaml $(swift)
namespace: AzureMapsGeolocation
title: AzureMapsGeolocation
license-header: MICROSOFT_MIT_NO_VERSION
package-name: AzureMapsGeolocation
output-folder: $(swift-sdk-folder)/sdk/maps/AzureMapsGeolocation
package-version: 1.0.0
clear-output-folder: false
add-credential: true
generate-as-internal: >
    GeolocationClient=GeolocationClientInternal
directive:
  - rename-operation:
      from: GetLocation
      to: Geolocation_GetLocation
```
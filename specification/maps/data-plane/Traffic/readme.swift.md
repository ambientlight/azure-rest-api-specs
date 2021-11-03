## Swift

These settings apply only when `--swift` is specified on the command line.

```yaml $(swift)
namespace: AzureMapsTraffic
title: AzureMapsTraffic
license-header: MICROSOFT_MIT_NO_VERSION
package-name: AzureMapsTraffic
output-folder: $(swift-sdk-folder)/sdk/maps/AzureMapsTraffic
package-version: 1.0.0
clear-output-folder: false
add-credential: true
generate-as-internal: >
    TrafficClient=TrafficClientInternal
```
## Swift

These settings apply only when `--swift` is specified on the command line.

```yaml $(swift)
namespace: AzureMapsSearch
title: AzureMapsSearch
license-header: MICROSOFT_MIT_NO_VERSION
package-name: AzureMapsSearch
output-folder: $(swift-sdk-folder)/sdk/maps/AzureMapsSearch
package-version: 1.0.0
clear-output-folder: false
add-credential: true
generate-as-internal: >
    SearchClient=SearchClientInternal
```
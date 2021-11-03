## Swift

These settings apply only when `--swift` is specified on the command line.

```yaml $(swift)
namespace: AzureMapsTimezone
title: AzureMapsTimezone
license-header: MICROSOFT_MIT_NO_VERSION
package-name: AzureMapsTimezone
output-folder: $(swift-sdk-folder)/sdk/maps/AzureMapsTimezone
package-version: 1.0.0
clear-output-folder: false
add-credential: true
generate-as-internal: >
    TimezoneClient=TimezoneClientInternal
directive:
  - rename-operation:
      from: GetTimezoneByCoordinates
      to: Timezone_GetTimezoneByCoordinates
  - rename-operation:
      from: GetTimezoneByID
      to: Timezone_GetTimezoneByID
  - rename-operation:
      from: GetIANATimezoneIds
      to: Timezone_GetIANATimezoneIds
  - rename-operation:
      from: GetWindowsTimezoneIds
      to: Timezone_GetWindowsTimezoneIds
  - rename-operation:
      from: GetIANAVersion
      to: Timezone_GetIANAVersion
  - rename-operation:
      from: ConvertWindowsTimezoneToIANA
      to: Timezone_ConvertWindowsTimezoneToIANA
```
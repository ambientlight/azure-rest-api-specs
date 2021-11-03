## Swift

These settings apply only when `--swift` is specified on the command line.

```yaml $(swift)
namespace: AzureMapsWeather
title: AzureMapsWeather
license-header: MICROSOFT_MIT_NO_VERSION
package-name: AzureMapsWeather
output-folder: $(swift-sdk-folder)/sdk/maps/AzureMapsWeather
package-version: 1.0.0
clear-output-folder: false
add-credential: true
generate-as-internal: >
    WeatherClient=WeatherClientInternal
directive:
  - rename-operation:
      from: GetHourlyForecast
      to: Weather_GetHourlyForecast
  - rename-operation:
      from: GetMinuteForecast
      to: Weather_GetMinuteForecast
  - rename-operation:
      from: GetQuarterDayForecast
      to: Weather_GetQuarterDayForecast
  - rename-operation:
      from: GetCurrentConditions
      to: Weather_GetCurrentConditions
  - rename-operation:
      from: GetDailyForecast
      to: Weather_GetDailyForecast
  - rename-operation:
      from: GetWeatherAlongRoute
      to: Weather_GetWeatherAlongRoute
  - rename-operation:
      from: GetSevereWeatherAlerts
      to: Weather_GetSevereWeatherAlerts
  - rename-operation:
      from: GetDailyIndices
      to: Weather_GetDailyIndices
```
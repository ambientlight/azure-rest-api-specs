## Swift

These settings apply only when `--swift` is specified on the command line.

```yaml $(swift)
namespace: AzureMapsRender
title: AzureMapsRender
license-header: MICROSOFT_MIT_NO_VERSION
package-name: AzureMapsRender
output-folder: $(swift-sdk-folder)/sdk/maps/AzureMapsRender
package-version: 1.0.0
clear-output-folder: false
add-credential: true
generate-as-internal: >
    RenderClient=RenderClientInternal
directive:
  - rename-operation:
      from: GetMapStaticImage
      to: Render_GetMapStaticImage
  - rename-operation:
      from: GetMapTile
      to: Render_GetMapTile
  - rename-operation:
      from: GetMapTileV2
      to: Render_GetMapTileV2
  - rename-operation:
      from: GetMapTileset
      to: Render_GetMapTileset
  - rename-operation:
      from: GetMapAttribution
      to: Render_GetMapAttribution
  - rename-operation:
      from: GetMapStateTile
      to: Render_GetMapStateTile
  - rename-operation:
      from: GetCopyrightCaption
      to: Render_GetCopyrightCaption
  - rename-operation:
      from: GetCopyrightCaption
      to: Render_GetCopyrightCaption
  - rename-operation:
      from: GetCopyrightFromBoundingBox
      to: Render_GetCopyrightFromBoundingBox
  - rename-operation:
      from: GetCopyrightForTile
      to: Render_GetCopyrightForTile
  - rename-operation:
      from: GetCopyrightForWorld
      to: Render_GetCopyrightForWorld
```
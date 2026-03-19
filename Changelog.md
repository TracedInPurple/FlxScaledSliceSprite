# Changelog

All notable changes to FlxScaledSliceSprite will be documented here.

---

## [0.1.0] - Major Release (2026-03-17)

### Added
- `resize(width, height)` helper — resizes and updates the hitbox in one call
- `stretchNone()` counterpart to `stretchAll()`
- `scaleMult` is now a readable public field after construction
- `FlxGraphicAsset` support — constructor now accepts a path, `BitmapData`, or `FlxGraphic`

### Changed
- `scaleMult` parameter changed from `Int` to `Float`, allowing non-integer scales (e.g. `1.5`, `2.5`)
- Scaled bitmaps are now cached with a deterministic key (e.g. `assets/ui/box.png_x2`) — no duplicate work across multiple instances at the same scale
- Unused `BitmapData` is disposed immediately on a cache hit to free memory (yayyy)

### Fixed
- Fixed typo: `updatedSlicedHitbox()` renamed to `updateSlicedHitbox()`

---

## [0.0.2] - Minor changes (2025-10-27)

### Added
- `updatedSlicedHitbox()` Helper function to properly update the hitboxes.

### Fixed
- Fixed some issues when scaling and updating the hitbox of a sliced sprite.

---

## [0.0.1] - Inital Release (2025-7-3)

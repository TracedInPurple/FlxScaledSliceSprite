# FlxScaledSliceSprite
<p align="center">
    <img src="https://raw.githubusercontent.com/TracedInPurple/flxscaledslicesprite/main/art/banner.png" alt="FlxScaledSliceSprite Banner" />
</p>
<br>

[![License](https://img.shields.io/github/license/TracedInPurple/FlxScaledSliceSprite?style=for-the-badge)](LICENSE) [![Stars](https://img.shields.io/github/stars/TracedInPurple/FlxScaledSliceSprite?style=for-the-badge)](https://github.com/TracedInPurple/FlxScaledSliceSprite/stargazers) [![Issues](https://img.shields.io/github/issues/TracedInPurple/FlxScaledSliceSprite?style=for-the-badge)](https://github.com/TracedInPurple/FlxScaledSliceSprite/issues)
[![YouTube](https://img.shields.io/badge/YouTube-TracedInPurple-FF0000?logo=youtube&style=for-the-badge)](https://www.youtube.com/@TracedInPurple) [![Ko-fi](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Ko--fi-FF5E5B?logo=ko-fi&logoColor=white&style=for-the-badge)](https://ko-fi.com/tracedinpurple)

---

## What is FlxScaledSliceSprite?

`FlxScaledSliceSprite` is a small extension of [`FlxSliceSprite`](https://api.haxeflixel.com/flixel/addons/display/FlxSliceSprite.html) from HaxeFlixel that adds support for **scaling the source texture before slicing**.

This means you can work with a small base graphic and scale it up cleanly at runtime — no need to manually author higher-resolution versions of every UI asset.

### Use Case

Perfect for games with a UI scale setting (think **Minecraft-style scaling**), where your interface needs to scale up crispy and pixel-perfect without blurring or misaligned slice borders.

<p align="center">
    <img src="https://raw.githubusercontent.com/TracedInPurple/flxscaledslicesprite/main/art/example.png" alt="FlxScaledSliceSprite Example" />
</p>

---

## Features

- Scales the source texture before 9-slicing, preserving crisp pixel edges
- Automatically adjusts the slice rectangle to match the scaled bitmap
- Accepts `FlxGraphicAsset` — pass a path, `BitmapData`, or `FlxGraphic` directly
- Supports `Float` scale multipliers (e.g. `1.5`, `2.5`)
- Scaled bitmaps are cached — no redundant work if you create multiple instances at the same scale
- Exposes `scaleMult` as a readable field after construction
- Built by a HaxeFlixel user for HaxeFlixel users :3

---

## Requirements

- [HaxeFlixel](https://haxeflixel.com/)
- [flixel-addons](https://github.com/HaxeFlixel/flixel-addons)

---

## Installation
```bash
haxelib install flxscaledslicesprite
```

Or directly from GitHub:
```bash
haxelib git flxscaledslicesprite https://github.com/TracedInPurple/FlxScaledSliceSprite.git
```

---

## Usage

### Basic Setup
```haxe
import tracedinpurple.ui.FlxScaledSliceSprite;

var asset = "assets/ui/box.png"; // can be a path / bitmapData / FlxGraphic
var slice = new FlxRect(3, 3, 10, 10); // x, y, width, height of the center slice region

// Create a new SlicedSprite with a scaling Factor of 2, and a final width/height of 200x100
var scaledSprite = new FlxScaledSliceSprite(asset, slice, 2, 200, 100);
add(scaledSprite);
```

### Resizing

Use `resize()` to change dimensions and update the hitbox in one call:
```haxe
scaledSprite.resize(300, 150); // sets the width/height of the sprite to 300x150
```

Or manually if you prefer:
```haxe
scaledSprite.width = 300;
scaledSprite.updateSlicedHitbox();
```

### Stretching

Stretch all nine regions at once:
```haxe
scaledSprite.stretchAll();
```

Or reset them:
```haxe
scaledSprite.stretchNone();
```

Or do them invidivually:
```haxe
scaledSprite.stretchTop = true;
scaledSprite.stretchCenter = false; // and so on...
```

## Tween Examples

If you ever want to have fun with Tweens, here's some examples.
(I have no idea why im adding it here, but it's still something cool so...)

### Horizontal Tween / Vertical Tween

```haxe
// you can use width/height together aswell | {width: 100, height: 300}
FlxTween.tween(sprite, {width: 400}, 1.0, {
	ease: FlxEase.cubeInOut,
	onUpdate: _ -> {
		sprite.resize(sprite.width, sprite.height);
		sprite.screenCenter();
	},
	type: FlxTweenType.PINGPONG
});
```
<p align="center">
  <img src="https://raw.githubusercontent.com/TracedInPurple/flxscaledslicesprite/main/art/Horizontal Tween.gif" width="300" style="margin-right: 10px;"/>
  <img src="https://raw.githubusercontent.com/TracedInPurple/flxscaledslicesprite/main/art/Vertical Tween.gif" width="300"/>
</p>


### Combined Tweens

```haxe
// the possibilities are endless here, so go crazy whenever
FlxTween.tween(sprite, {width: 400}, 1.0, {
	ease: FlxEase.cubeInOut,
	onUpdate: _ -> {
		sprite.resize(sprite.width, sprite.height);
		sprite.screenCenter();
	},
	type: FlxTweenType.PINGPONG
});
FlxTween.tween(sprite, {height: 400}, 1.0, {
	ease: FlxEase.cubeInOut,
	startDelay: 0.4,
	onUpdate: _ -> {
		sprite.resize(sprite.width, sprite.height);
		sprite.screenCenter();
	},
	type: FlxTweenType.PINGPONG
});
```
<p align="center">
  <img src="https://raw.githubusercontent.com/TracedInPurple/flxscaledslicesprite/main/art/Combo Tween.gif" width="300" >
</p>

There is really no limit with what you can do so, have fun with it!!!

---

## Contributing

Pull requests are welcome! Found a bug or have a suggestion? Open an [issue](https://github.com/TracedInPurple/FlxScaledSliceSprite/issues).

---

## Credits

Font by Qrafty — check it out on their [Ko-Fi](https://ko-fi.com/post/qraftium-FONT-N4N81DJKV5).

---

## License

MIT — see [LICENSE](LICENSE) for details.

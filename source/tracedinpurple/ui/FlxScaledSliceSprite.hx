package tracedinpurple.ui;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.addons.display.FlxSliceSprite;
import flixel.math.FlxRect;
import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import openfl.geom.Matrix;

/**
 * Small extension to FlxSliceSprite.
 * Simply allows you to scale the Texture you want to slice instead of loading a *bigger* version of said texture.
 * Despite having a very niche use it works great if you're working with a GUI/UI scale (Minecraft for example)
 */
class FlxScaledSliceSprite extends FlxSliceSprite 
{
	/**
		@param asset Graphic you want to slice
		@param baseSliceRect Rectangle that defines the slice grid
		@param scaleMult Scales the bitmap of your original graphic
		@param width The width of your slice object
		@param height The height of your slice object

		Call `updateSlicedHitbox()` whenver you change the width or height of the sprite!
	**/
	public function new(asset:FlxGraphicAsset, baseSliceRect:FlxRect, scaleMult:Float = 1, width:Float = -1, height:Float = -1) 
	{
		// Load the original bitmap/graphic
		var rawGraphic = FlxG.bitmap.add(asset);
		var originalBitmap = rawGraphic.bitmap;
		
		var matrix = new Matrix(scaleMult, 0, 0, scaleMult); // it works so i won't touch it lol

		var scaledWidth:Int = Math.round(originalBitmap.width * scaleMult);
		var scaledHeight:Int = Math.round(originalBitmap.height * scaleMult);

		/**
		 * Since BitmapData requires the width to be an integer (for whatever reason)
		 * we simply round the width/height when multiplied by the scaleMult
		 * allowing us to use Floats as scaling values!!!
		 * 
		 * Just make sure to also round the slice rectangle to avoid inconsistencies!
		 */
		var scaledBitmap = new BitmapData(scaledWidth, scaledHeight, true, 0x0);
		scaledBitmap.draw(originalBitmap, matrix);

		// Add the upscaled bitmap to the cache
		var scaledGraphic = FlxG.bitmap.add(scaledBitmap);

		// Scale the slice rect accordingly
		var scaledSliceRect = new FlxRect(
			Math.round(baseSliceRect.x * scaleMult),
			Math.round(baseSliceRect.y * scaleMult),
			Math.round(baseSliceRect.width * scaleMult),
			Math.round(baseSliceRect.height * scaleMult)
		);

		/**
		 * If no width and/or height is defined, it will take the original width/height multiplied by the factor!
		 * So if the original width is 200px and the factor is 2
		 * Meaning: If no width is specified, the final width of the sprite will be 400px etc...
		 */
		if (width <= 0) width = scaledBitmap.width;
		if (height <= 0) height = scaledBitmap.height;

		super(scaledGraphic, scaledSliceRect, width, height);

		updateSlicedHitbox();
	}
	/**
		Quick and Easy *(Lazy)* Function to stretch all Elements of the Sprite
	**/
	public function stretchAll():Void
	{
		stretchLeft = stretchTop = stretchRight = stretchBottom = stretchCenter = true;
	}

	/**
		Updates the new hitbox of the sliced sprite.
		Usually good to call after resizing the sprite.
	**/
	public function updateSlicedHitbox() {
		updateFramePixels(); // not sure if necessary but i'll keep it on for now
		updateHitbox();
		offset.set(0,0);
	}
}

package tracedinpurple.ui;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.addons.display.FlxSliceSprite;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxRect;
import openfl.display.BitmapData;
import openfl.geom.Matrix;

/**
 * Small extension to FlxSliceSprite.
 * Simply allows you to scale the Texture you want to slice instead of loading a *bigger* version of said texture
 * Despite having a very niche use it works great if you're woring with a GUI/UI scale (Minecraft for example)
 */
class FlxScaledSliceSprite extends FlxSliceSprite 
{
	/**
	 * Creates a new Sliced Sprite.
	 * NOTE: `updateSlicedHitbox()` whenever you change the width or height of the sprite!
	 * 
	 * @param asset Graphic you want to slice
	 * @param baseSliceRect Rectangle that defines the slice grid
	 * @param scaleMult Scales the bitmap of your original graphic
	 * @param width The width of your slice object
	 * @param height The height of your slice object
	 * 
	**/
	public function new(asset:FlxGraphicAsset, baseSliceRect:FlxRect, scaleMult:Float = 1, width:Float = -1, height:Float = -1) 
	{
		// Load the original bitmap/graphic
		var rawGraphic = FlxG.bitmap.add(asset);
		
		if(scaleMult == 1)
		{
			super(rawGraphic, baseSliceRect, width, height);
		}

		var originalBitmap = rawGraphic.bitmap;

		var matrix = new Matrix(scaleMult, 0, 0, scaleMult); // it works so i won't touch it lol

		var scaledWidth:Int = Math.round(originalBitmap.width * scaleMult);
		var scaledHeight:Int = Math.round(originalBitmap.height * scaleMult);

		/**
		 * Since BitmapData requires the width to be an integer (for whatever reason)
		 * we simply round the width/height when multiplied by the scaleMult
		 * allowing us to use Floats as scaling values!!!
		 * 
		 * just make sure to also round the slice rectangle to avoid inconsistencies!
		 */
		var scaledBitmap = new BitmapData(scaledWidth, scaledHeight, true, 0x0);
		scaledBitmap.draw(originalBitmap, matrix);

		var cacheKey = rawGraphic.key + "_x" + scaleMult;

		// Add the upscaled bitmap to the cache
		var scaledGraphic = FlxG.bitmap.get(cacheKey);

		if(scaledGraphic == null) 
		{
			// if no cached version exists, we make one, and save it with a unique key (eg. overlay.png_x2.5)
			scaledGraphic = FlxG.bitmap.add(scaledBitmap, false, cacheKey);
		}
		else
		{
			// if we find a cached version, we can safely get rid of the Bitmap to free some memory
			scaledBitmap.dispose();
			scaledBitmap = null;
		}

		// Scale the slice rect accordingly
		var scaledSliceRect = new FlxRect(
			Math.round(baseSliceRect.x * scaleMult),
			Math.round(baseSliceRect.y * scaleMult),
			Math.round(baseSliceRect.width * scaleMult),
			Math.round(baseSliceRect.height * scaleMult)
		);

		// If no width/height are provided, use native scaled size
		if (width <= 0) width = scaledBitmap.width;
		if (height <= 0) height = scaledBitmap.height;

		super(scaledGraphic, scaledSliceRect, width, height);

		updateSlicedHitbox();
	}

	/**
		Helper to Stretch all Slices in one go
	**/
	public function stretchAll():Void
	{
		stretchLeft = stretchTop = stretchRight = stretchBottom = stretchCenter = true;
	}

	/**
	 * Helper to Tile all Slices in one go
	 */
	public function stretchNone():Void
	{
		stretchLeft = stretchTop = stretchRight = stretchBottom = stretchCenter = true;
	}

	/**
	 * Helper function to resize the width and height of the sprite.
	 * @param width 
	 * @param height 
	 */
	public function resize(width:Float, height:Float):Void
	{
		this.width = width;
		this.height = height;
		updateSlicedHitbox();
	}


	/**
		Updates the new hitbox of the sliced sprite.
		Usually good to call after resizing the sprite.
	**/
	public function updateSlicedHitbox() 
	{
		updateFramePixels(); // not sure if necessary but i'll keep it on for now
		updateHitbox();
		offset.set(0,0);
	}
}

package utils;

import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.display.MovieClip;
import openfl.utils.AssetType;

class AssetsManager {
	public static function libraries(): Array<String> {
		var libraries:Array<String> = new Array();
		for (path in Assets.list(AssetType.BINARY)) {
			var id:String = path.substring(path.lastIndexOf("/") + 1, path.lastIndexOf("."));
			if (Assets.hasLibrary(id))
				libraries.push(id);
		}
		return libraries;
	}

	public static function clip(name: String): MovieClip {
		for (lib in AssetsManager.libraries()) {
			var library = cast(Assets.getLibrary(lib), openfl.utils.AssetLibrary);
			if (library.exists(name, cast AssetType.MOVIE_CLIP))
				return cast(library.getMovieClip(name), MovieClip);
		}
		return null;
	}

	public static function image(name: String): BitmapData {
		if (Assets.exists(name, cast AssetType.IMAGE))
			return Assets.getBitmapData(name);
		return null;
	}


	public static function bitmap2sprite(bmp: BitmapData): Sprite {
		var data: BitmapData = new BitmapData(bmp.width, bmp.height);
		data.copyPixels(bmp, new Rectangle(0, 0, bmp.width, bmp.height), new Point(0, 0));
		var sprite: Sprite = new Sprite();
		sprite.graphics.beginBitmapFill(data, null, false, true);
		sprite.graphics.drawRect(0, 0, bmp.width, bmp.height);
		sprite.graphics.endFill();
		return sprite;
	}

}
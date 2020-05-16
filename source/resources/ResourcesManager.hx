package resources;

import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.display.Bitmap;
import openfl.display.MovieClip;
import openfl.utils.AssetType;
import openfl.utils.Assets;

class ResourcesManager 
{
	public static function libraries():Array<String> 
	{
		var libraries:Array<String> = new Array();
		for (path in Assets.list(AssetType.BINARY)) 
		{
			var id:String = path.substring(path.lastIndexOf("/") + 1, path.lastIndexOf("."));
			if (Assets.hasLibrary(id))
				libraries.push(id);
		}
		return libraries;
	}

	public static function clip(name:String):MovieClip 
	{
		for (lib in ResourcesManager.libraries()) 
		{
			var library = cast(Assets.getLibrary(lib), openfl.utils.AssetLibrary);
			if (library.exists(name, cast AssetType.MOVIE_CLIP))
				return cast(library.getMovieClip(name), MovieClip);
		}
		return null;
	}

	public static function toBitmapClip(clip: MovieClip): MovieClip
	{
		for (frameIndex in 0...clip.totalFrames) {
			clip.gotoAndStop(frameIndex);
			for (childNum in 0...clip.numChildren) {
				var child: MovieClip = cast(clip.getChildAt(childNum));
				if (child != null) {
					var childRect: Rectangle = child.getRect(child);
					var childImg: Bitmap = new Bitmap(null, "auto", true);
					var childImgData: BitmapData = new BitmapData(Math.ceil(childRect.width), Math.ceil(childRect.height), true, 0);
					childImgData.draw(child);
					childImg.bitmapData = childImgData;
					clip.removeChildAt(childNum);
					clip.addChildAt(childImg, childNum);
					child= null;
				}
			}
		}
		return clip;
	}
}
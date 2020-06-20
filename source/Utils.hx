package;

import openfl.utils.Object;
import openfl.display.Sprite;
import openfl.geom.Rectangle;
import openfl.display.Bitmap;
import openfl.display.DisplayObject;
import openfl.display.Graphics;
import openfl.display.BitmapData;
import openfl.Lib;

class Utils 
{
	public static function basename(path: String, showExtension: Bool = false): String
	{
		return path.substring(path.lastIndexOf("/") + 1, !showExtension ? path.lastIndexOf(".") : path.length);
	}

	public static function dirname(path: String): String {
		return path.substring(0, path.lastIndexOf("/") + 1);
	}
	
	public static function sleep(ms: Float): Void {
		var init: Int = Lib.getTimer();
		while (true) 
		{
			if (Lib.getTimer() - init >= ms) break;
		}
	}
	
	public static function roundImageRect(data: BitmapData, round: Int = 20): BitmapData {
		var rect: Rectangle = new Rectangle(0, 0, data.width, data.height);
		var rounded: Sprite = new Sprite();
		rounded.graphics.beginBitmapFill(data, null, true);
		rounded.graphics.drawRoundRect(0, 0, rect.width, rect.height, round);
		rounded.graphics.endFill();
		rect = rounded.getRect(rounded);
		var bitmapData = new BitmapData(Math.ceil(rect.width), Math.ceil(rect.height), true, 0);
		bitmapData.draw(rounded);
		return bitmapData;
	}

	public static function iterToArary(iter: Iterator<Object>): Array<Object> {
		var arr: Array<Object> = new Array<Object>();
		while (iter.hasNext())
			arr.push(iter.next());
		return arr;
	}
}
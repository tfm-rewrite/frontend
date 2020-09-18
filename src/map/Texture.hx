package map;

import openfl.display.StageQuality;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.display.Sprite;

final class Texture {
	private static final base: Sprite = new Sprite();

	public var x: Float;
	public var y: Float;
	public var data: BitmapData;
	public var rect: Rectangle;

	public function new(clip: Any, width: Float = 0, height: Float = 0, additional: Int = 0) {
		var rect: Rectangle;
		var w: Float;
		var h: Float;
		if (Std.isOfType(clip, BitmapData)) {
			var clip: BitmapData = cast(clip, BitmapData);
			this.data = clip;
			this.rect = clip.rect;
			this.x = this.rect.x;
			this.y = this.rect.y;
		} else if (Std.isOfType(clip, Sprite)) {
			var clip: Sprite = cast(clip, Sprite);
			Transformice.instance.stage.quality = StageQuality.HIGH;
			if (width > 0) {
				rect = new Rectangle(0, 0, 40, 40);
				w = width;
				h = height;
			} else {
				rect = clip.getRect(clip);
				w = rect.width + additional;
				h = rect.height + additional;
			}
			this.rect = new Rectangle(0, 0, w, h);
			this.x = rect.x;
			this.y = rect.y;
			if (base.numChildren > 0 ) base.removeChildAt(0);
			base.addChild(clip);
			clip.x = (additional / 2) - rect.x;
			clip.y = (additional / 2) - rect.y;
			this.data = new BitmapData(Math.ceil(w), Math.ceil(h), true, 0);
			this.data.draw(base);
			Transformice.instance.stage.quality = StageQuality.MEDIUM;
		}
	}
}
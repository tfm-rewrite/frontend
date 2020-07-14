package particle;

import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import openfl.display.Sprite;
import openfl.display.MovieClip;

class Image {

	public var bmpData: BitmapData;
	public var base: Sprite;
	public var target: MovieClip;
	public var animate: Bool = false;
	public var width: Int = 0;
	public var height: Int = 0;
	public var x: Float = 0;
	public var y: Float = 0;

	public function new() {}

	public function draw(): Void {
		if (this.target == null) return;
		if (!this.animate)
			this.target.gotoAndPlay(this.target.totalFrames);
		this.base = new Sprite();
		this.base.addChild(this.target);
		var rect: Rectangle = this.target.getRect(this.target);
		var scaleX: Float = this.target.scaleX;
		var scaleY: Float = this.target.scaleY;
		if (scaleX < 0) {
			this.width = Math.ceil(rect.x * -scaleX) + 4;
			this.x = Math.round(scaleX * (rect.x + this.width));
		} else {
			this.width = Math.ceil(rect.width * scaleX) + 4;
			this.x = Math.round(scaleX * rect.x);
		}
		if (scaleY < 0) {
			this.height = Math.ceil(rect.y * -scaleY) + 4;
			this.y = Math.round(scaleY * (rect.y + this.height));
		} else {
			this.height = Math.ceil(rect.height * scaleY) + 4;
			this.y = Math.round(scaleY * rect.y);
		}
		this.target.x = 2-this.x;
		this.target.y = 2-this.y;
		this.bmpData = new BitmapData(this.width, this.height, true, 0);
		this.bmpData.draw(this.base);
		this.base = null;
		this.target = null;
	}
}
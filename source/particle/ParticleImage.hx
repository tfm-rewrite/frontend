package particle;

import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.display.Sprite;
import openfl.display.MovieClip;
import openfl.display.BitmapData;

class ParticleImage
{
	public var bitmapData: BitmapData;
	public var x: Float = 0;
	public var y: Float = 0;
	public var width: Int;
	public var height: Int;
	public var drawn: Bool = false;
	public var repeat: Bool = false;
	public var clipTarget: MovieClip;
	public var clipBase: Sprite;
	public var stopImage: Int;
	public var label: String;

	public function new(isDrawn: Bool = true) {
		this.drawn = isDrawn;
	}

	public function render(x: Float = 0, y: Float = 0): Void {
		if (this.clipTarget == null)
			return;
		if (!this.repeat)
			this.clipTarget.gotoAndStop(this.stopImage);
		this.drawn = true;
		this.clipBase = new Sprite();
		this.clipBase.addChild(this.clipTarget);
		var clipRect: Rectangle = this.clipTarget.getRect(this.clipTarget);
		var scaleX: Float = this.clipTarget.scaleX;
		var scaleY: Float = this.clipTarget.scaleX;
		if (scaleX < 0) {
			this.width = Math.ceil(clipRect.x * -scaleX) + 4;
			this.x = Math.round(scaleX * (clipRect.x + this.width));
		} else {
			this.width = Math.ceil(clipRect.width * scaleX) + 4;
			this.x = Math.round(scaleX * clipRect.x);
		}
		if (scaleY < 0) {
			this.height = Math.ceil(clipRect.height * -scaleY) + 4;
			this.y = Math.round(scaleY * (this.height + clipRect.y));
		} else {
			this.height = Math.ceil(clipRect.height * scaleY) + 4;
			this.y = Math.round(scaleY * clipRect.y);
		}
		this.clipTarget.x = 2 - this.x;
		this.clipTarget.y = 2 - this.y;
		this.bitmapData = new BitmapData(this.width, this.height, true, 0);
		this.bitmapData.draw(this.clipBase);

		this.clipBase = null;
		this.clipTarget = null;
	}

}
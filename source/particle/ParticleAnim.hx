package particle;

import flash.display.BitmapData;
import openfl.display.Bitmap;

class ParticleAnim extends Bitmap {
	public var zero: ParticleZero;
	public var currentImage: ParticleImage;
	public var currentIndex: Int = 0;
	public var stopIndex: Int = 0;
	public var repeat: Bool = false;
	public var startFrame: Int = 0;
	public var endFrame: Int = 0;
	
	public function new(zero: ParticleZero, repeat: Bool = false, w: Int = 0, h: Int = 0, x: Float = 0, y: Float = 0) {
		super();
		this.zero = zero;
		if (x == 0)
			this.x = -(this.width / 2);
		if (y == 0)
			this.y = -(this.height / 1.5);
		this.repeat = repeat;
		this.bitmapData = new BitmapData(w, h, true, 0);
	}

	public function setStartStop(start: Int = -1, stop: Int = -1) {
		if (start != -1)
			this.startFrame = start;
		if (stop != -1)
			this.endFrame = stop;
		this.currentIndex = this.startFrame;
		this.stopIndex = this.endFrame;
	}

	public function render(): Void {
		if (this.currentIndex == this.stopIndex)
			this.setStartStop(0, this.zero.totalFrames);
		if (this.currentIndex >= this.stopIndex) {
			if (this.repeat) {
				this.currentIndex = this.startFrame;
				this.stopIndex = this.endFrame;
			} else {};
		}
		this.currentImage = this.zero.listImages[this.currentIndex];
		if (this.currentImage == null) {
			this.currentIndex++;
			return;
		};
		this.currentImage.render();
		this.bitmapData = this.currentImage.bitmapData;
		this.x = this.currentImage.x;
		this.y = this.currentImage.y;
		this.currentIndex++;
	}
}

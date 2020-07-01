package particle;

import flash.events.Event;
import flash.display.BitmapData;
import flash.display.Bitmap;

class ParticleAnim extends Bitmap {
	public var zero: ParticleZero;
	public var currentImage: ParticleImage;
	public var currentImageIndex: Int = 0;
	public var repeat: Bool = false;
	public var rendered: Bool = false;
	public var stopped: Bool = false;
	public var startFrame: Int = 0;


	public function new(zero: ParticleZero, repeat: Bool = false, w: Int = 0, h: Int = 0, x: Float = 0, y: Float = 0) {
		super(null, 'auto', true);
		this.zero = zero;
		if (x == 0)
			this.x = -(this.width / 2);
		if (y == 0)
			this.y = -(this.height / 1.5);
		this.repeat = repeat;
		this.bitmapData = new BitmapData(w, h, true, 0);
		Transformice.instance.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
	}

	private function onEnterFrame(event: Event) {
		if (this.rendered) {
			if (this.currentImageIndex >= this.zero.totalFrames) {
				if (this.repeat) 
					this.currentImageIndex = this.startFrame;
				else
					Transformice.instance.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);

			} else 
				this.render();
		}
	}

	public function gotoAndStop(frame: Int) {
		if (frame < this.zero.totalFrames) {
			Transformice.instance.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			this.stopped = true;
			this.currentImageIndex = frame;
			this.currentImage = this.zero.listImages[this.currentImageIndex];
			this.currentImage.render();
			this.bitmapData = this.currentImage.bitmapData;
			this.x = this.currentImage.x;
			this.y = this.currentImage.y;
		}
	}

	public function gotoAndPlay(frame: Int) {
		if (frame < this.zero.totalFrames) {
			this.startFrame = frame;
			this.currentImageIndex = frame;
			this.render();
		}
	}

	public function render(): Void {
		if (this.stopped) return;
		if (!this.rendered) this.rendered = true;
		this.currentImage = this.zero.listImages[this.currentImageIndex];
		if (this.currentImage == null) {
			this.currentImageIndex++;
			return;
		}
		this.currentImage.render();
		this.bitmapData = this.currentImage.bitmapData;
		this.x = this.currentImage.x;
		this.y = this.currentImage.y;
		this.currentImageIndex++;
	}
}

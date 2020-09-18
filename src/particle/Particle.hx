package particle;

import js.Browser;
import openfl.Lib;
import openfl.events.Event;
import openfl.display.BitmapData;
import openfl.display.Bitmap;

class Particle extends Bitmap {

	public var image: Image;
	public var imageIndex: Int = 0;
	public var isLoop: Bool = false;
	private var startFrame: Int = 0;
	private var endFrame: Int = 0;
	private var fpsInterval: Float = 0;
	private var last: Int = Lib.getTimer();
	private var lastSecond: Int = Lib.getTimer();
	private var now: Int = 0;
	private var counter: Int = 0;

	@:isVar public var zero(get, set): Zero;

	public function new(zero: Zero, loop: Bool = true, width: Int = 0, height: Int = 0, frameRate: Float = 30) {
		super();
		this.zero = zero;
		this.x = -(this.width/2);
		this.y = -(this.height/1.5);
		this.isLoop = loop;
		this.fpsInterval = 1000 / Transformice.defaultFrameRate;
		this.bitmapData = new BitmapData(width, height, true, 0);
		this.zero.target.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
	}

	private function onEnterFrame(event: Event): Void {
		if ((Lib.getTimer() - this.last) >= this.fpsInterval) {
			this.last = Lib.getTimer();
			if (this.imageIndex >= this.zero.target.totalFrames) {
				if (this.isLoop)
					this.imageIndex = this.startFrame;
				else return;
			}
			this.draw();
		}
	}

	public function get_zero(): Zero {
		return this.zero;
	}

	public function set_zero(zero: Zero): Zero {
		if (this.zero != null)
			this.zero.target.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		this.zero = zero;
		this.zero.target.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		return this.zero;
	}

	public function draw(): Void {
		this.image = this.zero.images[this.imageIndex];
		if (this.image == null) {
			this.imageIndex++;
			return;
		}
		this.bitmapData = this.image.bmpData;
		this.x = this.image.x;
		this.y = this.image.y;
		this.imageIndex++;
	}
}
package particle;

import openfl.events.Event;
import openfl.display.MovieClip;

class Zero {

	public var target: MovieClip;
	public var images: Array<Image>;
	public var currentFrame: Int = 0;

	public function new(clip: MovieClip, animate: Bool = true) {
		if (clip == null) return;
		this.images = [];
		this.target = clip;
		for (i in 0...this.target.totalFrames) {
			var img: Image = new Image();
			img.target = this.target;
			img.animate = animate;
			if (!animate)
				img.draw();
			this.images[i] = img;
		}
		if (animate) 
			this.target.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
	}

	private function onEnterFrame(event: Event) {
		if (this.images.length == this.currentFrame) {
			this.target.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			return this.target.stopAllMovieClips();
		}
		this.target.gotoAndPlay(this.currentFrame + 1);
		this.images[this.currentFrame].draw();
		this.currentFrame++;
	}
}
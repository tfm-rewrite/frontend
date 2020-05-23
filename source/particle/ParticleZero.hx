package particle;

import openfl.events.TextEvent;
import openfl.events.Event;
import openfl.display.MovieClip;
import openfl.Lib;

class ParticleZero 
{
	public static var zeroList: Array<ParticleZero> = new Array(); 
	
	public var listImages: Array<ParticleImage>; 
	public var totalFrames: Int;
	public var timer: Int = Lib.getTimer();
	public var clipTarget: MovieClip;
	public var currentFrame: Int = 0;

	public function new(clip: MovieClip, loop: Bool = false): Void {
		if (clip == null) return;
		this.totalFrames = clip.totalFrames;
		this.listImages = new Array();
		this.clipTarget = clip;
		if (loop) clip.gotoAndPlay(1);
		for (i in 0...this.totalFrames) {
			var img: ParticleImage = new ParticleImage();
			img.clipTarget = clip;
			img.repeat = loop;
			this.listImages[i] = img;
		}
		if (loop) {
			ParticleZero.zeroList.push(this);
			Transformice.instance.addEventListener(Event.ENTER_FRAME, ParticleZero.onEnterFrame);
		}
	}

	public static function onEnterFrame(event: Event): Void {
		for (i in 0...ParticleZero.zeroList.length) {
			var zero: ParticleZero = ParticleZero.zeroList[i];
			if (zero.listImages.length == zero.currentFrame) {
				zero.clipTarget.stopAllMovieClips();
				ParticleZero.zeroList.splice(i, 1);
				break;
			}
			zero.clipTarget.gotoAndPlay(zero.currentFrame + 1);
			var img: ParticleImage = zero.listImages[zero.currentFrame];
			img.render();
			zero.currentFrame++;
		}
		if (ParticleZero.zeroList.length <= 0)
			Transformice.instance.removeEventListener(Event.ENTER_FRAME, ParticleZero.onEnterFrame);
	}
}

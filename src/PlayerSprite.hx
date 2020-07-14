package;

import particle.Zero;
import particle.Particle;
import openfl.display.MovieClip;
import openfl.display.Sprite;

class PlayerSprite extends Sprite {

	public var player: Player;
	private var zero: Zero;
	private var particle: Particle;

	public function new(player: Player, x: Float = 0, y: Float = 0) {
		super();
		this.player = player;
		this.x = x;
		this.y = y;
		Transformice.instance.world.addChild(this);
	}

	public function playAnimation(animName: String, frameRate: Float = 30): Void {
		var clip: MovieClip = PlayerAnim.getAnim('animations', 1, animName);
		clip.scaleX = 3;
		clip.scaleY = 3;
		this.zero = new Zero(clip, true);
		this.particle = new Particle(this.zero, true, 100, 75, frameRate);
		this.removeChildAt(0);
		this.addChildAt(this.particle, 0);
	}

}
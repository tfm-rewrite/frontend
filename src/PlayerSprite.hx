package;

import particle.Zero;
import particle.Particle;
import openfl.display.MovieClip;
import openfl.display.Sprite;

class PlayerSprite extends Sprite {

	public var player: Player;
	@:isVar public var scale(get, set): Float = 1.2;
	private var zero: Zero;
	private var particle: Particle;
	private var clip: MovieClip;
	
	public function new(player: Player, x: Float = 0, y: Float = 0) {
		super();
		this.player = player;
		this.x = x;
		this.y = y;
		this.playAnimation('AnimStatique', true);
		this.alpha = 0.5;
		Transformice.instance.world.addChild(this);
	}

	public function playAnimation(animName: String, statique: Bool = false, frameRate: Float = 0): Void {
		this.clip = PlayerAnim.getAnim('animations', 16, animName);
		this.clip.scaleX = this.clip.scaleY = this.scale;
		this.zero = new Zero(this.clip, !statique);
		this.particle = new Particle(this.zero, true, 100, 75, frameRate == 0 ? Transformice.defaultFrameRate : frameRate);
		this.removeChildAt(0);
		this.addChildAt(this.particle, 0);
	}

	public function get_scale(): Float {
		return this.scale;
	}

	public function set_scale(value: Float): Float {
		this.playAnimation('AnimStatique');
		return this.scale = value;
	}
	

}
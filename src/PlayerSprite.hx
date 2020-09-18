package;

import particle.Zero;
import particle.Particle;
import openfl.display.MovieClip;
import openfl.display.Sprite;

class PlayerSprite extends Sprite {

	public var player: Player;
	@:isVar public var scale(get, set): Float = 1.2;
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

	public function playAnimation(animName: String, statique: Bool = false): Void {
		this.clip = PlayerAnim.getAnim('animations', 16, animName);
		this.clip.scaleX = this.clip.scaleY = this.scale;
		var zero: Zero = new Zero(this.clip, !statique);
		if (this.particle == null)
			this.particle = new Particle(zero, true, 100, 75, Transformice.defaultFrameRate);
		else
			this.particle.zero = zero;
		this.removeChildAt(0);
		this.addChildAt(this.particle, 0);
	}

	public function get_scale(): Float {
		return this.scale;
	}

	public function set_scale(value: Float): Float {
		this.scale = value;
		this.playAnimation('AnimStatique');
		return this.scale;
	}
	

}
import openfl.events.Event;
import particle.ParticleImage;
import openfl.geom.Rectangle;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import particle.ParticleZero;
import particle.ParticleAnim;
import box2D.collision.shapes.B2MassData;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2FixtureDef;
import box2D.collision.shapes.B2CircleShape;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2Body;
import flash.filters.DropShadowFilter;
import flash.geom.ColorTransform;
import flash.utils.AssetType;
import flash.display.Sprite;
import flash.display.MovieClip;
import flash.Assets;
import haxe.ds.Map;

class Mice extends Sprite
{
	private var animations = new Map<String, MovieClip>();
	public var turnedRight = true;
	public var runningRight = false;
	public var runningLeft = false;
	public var ducking = false;
	public var jumping = false;
	public var furColor = 0xdfd8ce;
	public var lastMovement:Int;
	public var lastYVelocity:Float = 0;
	public var furId = 4;
	public var physics: B2Body;
	public var anim: ParticleAnim;
	public var zero: ParticleZero;
	public var currentClip: MovieClip;
	
	public function new(x: Float, y: Float) {
		super();
		this.x = x;
		this.y = y;
		this.changeAnimation();
		Transformice.instance.world.addChild(this);
		var bodyDef: B2BodyDef = new B2BodyDef();
		bodyDef.type = B2Body.b2_dynamicBody;
		bodyDef.position.x = this.x / 30;
		bodyDef.position.y = this.y / 30;
		bodyDef.fixedRotation = true;
		bodyDef.userData = this;
		var circleFixture: B2FixtureDef = new B2FixtureDef();
		circleFixture.density = 2;
		circleFixture.friction = 0.2;
		circleFixture.restitution = 0.2;
		circleFixture.shape = new B2CircleShape(0.5);
		this.physics = Transformice.instance.physicWorld.createBody(bodyDef);
		this.physics.createFixture(circleFixture);
		var MasseSourisBase = new B2MassData();
		MasseSourisBase.mass = 20;
		this.physics.setMassData(MasseSourisBase);
		var _loc6_:B2Vec2 = this.physics.getLinearVelocity();
		this.physics.setLinearVelocity(new B2Vec2(_loc6_.x,_loc6_.y));
		this.physics.setSleepingAllowed(false);
	}
	public function runLeft() {
		if (!this.runningLeft) {
			this.turnedRight = false;
			this.run();
		}
	}

	public function runRight() {
		if (!this.runningRight) {
			this.turnedRight = true;
			this.run();
		}
	}

	public function stopRun() {
		if (this.runningLeft || this.runningRight) {
			this.runningRight = this.runningLeft = false;
			this.changeAnimation();
		}
	}

	public function jump() {
		if (!this.jumping) {
			this.jumping = true;
			this.changeAnimation();
			this.physics.m_linearVelocity.y = -5;
		}
	}

	public function stopJump() {
		if (this.jumping) {
			this.jumping = false;
			this.changeAnimation();
		}
	}

	public function duck() {
		if (!this.ducking) {
			this.ducking = true;
			this.runningLeft = this.runningRight = false;
			this.changeAnimation();
			if (!this.jumping) {
				var clip = this.currentClip;
				clip.stop();
				clip.play();
				clip.gotoAndPlay(0);
				clip.gotoAndStop(6);
				this.changeAnimation(true);
			}
		}
	}

	public function stopDuck() {
		if (this.ducking) {
			this.ducking = false;
			if (!this.jumping) {
				var clip = this.currentClip;
				clip.stop();
				clip.play();
				clip.gotoAndPlay(7);
				clip.gotoAndStop(10);
				this.changeAnimation(true);
			}
		}
	}

	public function setFur(furId:Int) {
		this.furId = furId;
		this.clear();
	}

	public function setFurColor(furColor:Int) {
		this.furColor = furColor;
		this.furId = 1;
		this.clear();
	}

	private function clear() {
		this.animations.clear();
		this.changeAnimation();
	}

	private function run() {
		this.runningRight = this.turnedRight;
		this.runningLeft = !this.runningRight;
		this.ducking = false;
		this.changeAnimation();
	}



	public function changeAnimation(useCurrentClip: Bool = false, stopDuck: Bool = false): Void {
		var anim = "AnimStatique";
		if (this.runningLeft || this.runningRight || this.jumping) 
			anim = "AnimCourse";
		else if (this.ducking)
			anim = "AnimDuck";
		
		if (!useCurrentClip) {
			this.currentClip = animations.get(anim);
			if (this.currentClip == null) 
				this.currentClip = Animations.getAnimation("animations", this.furId, anim, this.furId == 1 ? [this.furColor] : null);
			this.currentClip.mask = null;
		}
		if (!this.turnedRight && this.scaleX > 0 || this.turnedRight && this.scaleX < 0)
			this.scaleX -= this.scaleX * 2;
		this.zero = new ParticleZero(this.currentClip, false, true);
		if (this.anim == null)
			this.anim = new ParticleAnim(this.zero, true, 100, 70);
		else
			this.anim.zero = this.zero;
		var x = Std.random(this.currentClip.totalFrames);
		this.anim.render();
		this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		this.removeChildAt(0);
		this.addChildAt(this.anim, 0);
	}

	private function onEnterFrame(event: Event) {
		trace("I'm HERE");
		this.anim.render();
		if (this.anim.currentImage != null) {
			this.anim.bitmapData = this.anim.currentImage.bitmapData; 
		}

	}

	private function setAnim() {
	
		var anim = "AnimStatique";
		if (this.runningLeft || this.runningRight || this.jumping) {
		    anim = "AnimCourse";
		} else if (this.ducking) {
		    anim = "AnimDuck";
		}
		var animation = animations.get(anim);
		if (animation == null) 
			animation = Animations.getAnimation("animations", this.furId, anim, this.furId == 1 ? [this.furColor] : null);
		if (!this.jumping)
			animation.gotoAndPlay(0);
		else 
			if (animation.isPlaying)
				animation.gotoAndStop(Std.random(animation.totalFrames));
		animation.mask = null;
		this.currentClip = animation;
		if (!this.turnedRight && this.scaleX > 0)
		    this.scaleX = -(this.scaleX);
		if (this.turnedRight && this.scaleX < 0)
		    this.scaleX = -(this.scaleX);
		this.zero = new ParticleZero(animation, true, !this.jumping && !this.ducking);
		if (this.anim == null) 
			this.anim = new ParticleAnim(this.zero, !this.jumping && !this.ducking);
		else
			this.anim.zero = this.zero;
		this.anim.render();
		this.removeChildAt(0);
		this.addChildAt(this.anim, 0);
	}

}
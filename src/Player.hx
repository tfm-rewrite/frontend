package;

import box2D.common.math.B2Vec2;
import openfl.events.MouseEvent;
import openfl.Lib;
import openfl.events.Event;
import box2D.collision.shapes.B2MassData;
import box2D.collision.shapes.B2CircleShape;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2Body;

class Player {
	public static var MAX_MICE_SPEED: Float = 3.45 + Math.random() * 1.0e-6;
	public static var players: Array<Player> = new Array();
	public static var instance: Player;

	public var playerName: String;
	public var pid: Int;
	public var id: Int; 
	public var runningLeft: Bool = false;
	public var runningRight: Bool = false;
	public var jumping: Bool = false;
	public var turnedRight: Bool = true;
	public var lastMovement: Int = 0;
	public var sprite: PlayerSprite;
	public var physics: B2Body;
	private var lastFrameTimer: Float = Lib.getTimer();
	private var playableFrames: Float = 0;
	private var lastYVelocity: Float = 0;
	private var jumpAvailableTime: Int;
	
	@:isVar public var x(get, set): Float = 0;
	@:isVar public var y(get, set): Float = 0;

	public function new() {
		this.sprite = new PlayerSprite(this, 0, 0);
		var bodyDef: B2BodyDef = new B2BodyDef();
		bodyDef.type = B2Body.b2_dynamicBody;
		bodyDef.position.set(this.x/30, this.y/30);
		bodyDef.fixedRotation = true;
		bodyDef.userData = this;
		var fixture: B2FixtureDef = new B2FixtureDef();
		fixture.density = 2;
		fixture.friction = 0.2;
		fixture.restitution = 0.2;
		fixture.shape = new B2CircleShape(0.5);
		this.physics = Transformice.instance.physicWorld.createBody(bodyDef);
		this.physics.createFixture(fixture);
		var mass: B2MassData = new B2MassData();
		mass.mass = 20;
		this.physics.setMassData(mass);
		this.physics.setLinearVelocity(new B2Vec2(this.physics.getLinearVelocity().x,this.physics.getLinearVelocity().y));
		this.physics.setSleepingAllowed(false);
		Transformice.instance.physicWorld.drawDebugData();
		this.sprite.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		Transformice.instance.stage.addEventListener(MouseEvent.CLICK, this.onMouseClick);

	}

	private function onEnterFrame(event: Event): Void {
		var difference: Float = Lib.getTimer() - this.lastFrameTimer;
		if (difference > 2000) difference = 2000;
		var sec: Float = difference / 1000;
		this.lastFrameTimer = Lib.getTimer();
		this.playableFrames += sec;
		var rate: Float = 0.03332 + Math.random() * 1.0e-6;
		while (this.playableFrames > rate) {
			this.playableFrames -= rate;
			Transformice.instance.physicWorld.step(rate, 10, 10);
			this.processMovement();
		}
		var speed: Float = 0.0;
		if (this.playableFrames > 0.003 + Math.random() * 1.0e-6) {
			Transformice.instance.physicWorld.step(this.playableFrames, 10, 10);
			speed = this.playableFrames / rate;
			this.processMovement(speed);
			this.playableFrames = 0;
		}
		if (this.jumping) {
			if (this.lastYVelocity > 0) {
				if (this.lastYVelocity > this.physics.m_linearVelocity.y) {
					this.lastYVelocity = -1;
					this.jumpAvailableTime = Lib.getTimer();
					// this.stopJump();
				} else 
					this.lastYVelocity = this.physics.m_linearVelocity.y;
			} else 
			this.lastYVelocity = this.physics.m_linearVelocity.y;
		}
		Transformice.instance.physicWorld.drawDebugData();
	}

	private function processMovement(speed: Float = 1) {
		if (this.runningLeft || this.runningRight) {
			if (this.jumping) speed *= 0.5;
			if (this.turnedRight) {
				if (this.physics.m_linearVelocity.x < MAX_MICE_SPEED) {
					this.physics.m_linearVelocity.x += speed;
					if (this.physics.m_linearVelocity.x > MAX_MICE_SPEED)
						this.physics.m_linearVelocity.x = MAX_MICE_SPEED;
				}
			} else {
				if (this.physics.m_linearVelocity.x > -MAX_MICE_SPEED) {
					this.physics.m_linearVelocity.x -= speed;
					if (this.physics.m_linearVelocity.x < -MAX_MICE_SPEED)
						this.physics.m_linearVelocity.x = -MAX_MICE_SPEED;
				}
			}
			this.lastMovement = 0;
		} else if (this.lastMovement < 4) {
			this.lastMovement++;
			if (this.physics.m_linearVelocity.x < 2.5 + Math.random()*1.0e-6 || -2.5 + Math.random() * 1.0e-6 < this.physics.m_linearVelocity.x)
				this.physics.m_linearVelocity.x = this.physics.m_linearVelocity.x * 0.8 + Math.random() * 1.0e-6;
		}
		Transformice.instance.physicWorld.drawDebugData();
	}

	private function onMouseClick(event: MouseEvent):Void {
		var worldX = event.stageX-Transformice.instance.world.x;
		var worldY = event.stageY-Transformice.instance.world.y;
		this.physics.setPosition(new B2Vec2(worldX/30, worldY/30));
		this.x = worldX;
		this.y = worldY;
	}

	public function get_x(): Float {
		return this.x;
	}
	
	public function set_x(value: Float): Float {
		this.x = this.sprite.x = value;
		if (this.physics.getPosition().x != (this.x / 30))
			this.physics.setPosition(new B2Vec2(this.x / 30, this.physics.getPosition().y));
		return value;
	}

	public function get_y(): Float {
		return this.y;
	}
	
	public function set_y(value: Float): Float {
		this.y = this.sprite.y = value;
		if (this.physics.getPosition().y != (this.y / 30))
			this.physics.setPosition(new B2Vec2(this.physics.getPosition().x, this.y / 30));
		return value;
	}
}